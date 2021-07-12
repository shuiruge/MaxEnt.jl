using Statistics: mean, max
using SparseArrays: spzeros
using Flux


# ------------------ Utils ------------------


"""
Expectation along the last array dimension.
"""
function expect(xs::AbstractArray)
    n = ndims(xs)
    dropdims(mean(xs, dims=n); dims=n)
end


"""
Outer-product of two arrays.
"""
function outer(x::AbstractArray, y::AbstractArray)
    x2 = reshape(x, 1, size(x)...)
    y2 = reshape(y, size(y, 1), 1, size(y)[2:end]...)
    x2 .* y2
end


function maxabs(x)
    max(abs.(x)...)
end


# ------------------ Energy-based Model ------------------


@doc raw"""
An energy-based model shall implements the following methods:

1. `getparams(model)`: returns the parameters of the model.
1. `getops(model)`: returns the operators {x → E[-∂E/∂θ(x)] | θ ∈ params},
   where E is the batch-expectation.
1. `activate(model, x)`: the activity rule, i.e. $p(x_α | x_{-α})$ for ∀ α.
"""
abstract type EnergyBasedModel end


@doc raw"""
For ∀ distribution $q(x)$, calculate the
```math

    \left\{ \frac{∂L}{∂θ^{α}}(θ; q): α = 1, \ldots \right\}

```
of the energy-based model $p(x; θ)$, where

```math

    L(θ; q) := \mathbb{E}_{x ∼ q} \left[ -\ln p(x; θ) \right].

```

# Arguments
* `real` is the real world data, obeying the $q(x)$ distribution.
* `fantasy` is the data imagined by the model, obeying the $p(x;θ)$
  distribution.

# Returns
A tuple of gradients, one-to-one correspondent to the parameters
obtained by calling `getparams(model)`.
"""
function gradients(model::EnergyBasedModel, real, fantasy)
    gradient(f) = f(fantasy) .- f(real)
    [gradient(f) for f in getops(model)]
end


# ------------------ Boltzmann Machine ------------------


"""
A connection between the `i`-th node and the `j`-th node.

A set of connections describes the topology of the network.
"""
struct Connection
    i::Integer
    j::Integer
end


"""
Collects all the node indices appeared in the network topology.
"""
function collectnodes(topology::Set{Connection})::Set{Integer}
    nodes = Set()
    for conn in topology
        push!(nodes, conn.i)
        push!(nodes, conn.j)
    end
    nodes
end


"""
Hinton's initialization strategy for the ambient bias of Boltzmann machine.
"""
function hinton_initialize(data)
    p = expect(data)
    ϵ = eps(eltype(data))
    @. log(p + ϵ) - log(1 - p + ϵ)
end


"""
Parameters
----------
* `topology` represents the connections of the network.
* `kernel` is a sparse N×N matrix, where N is the total number of nodes.
* `bias` is a dense 1×N matrix.
* `ambientsize` ≤ N.

Convention
----------
* The node index starts from ambient nodes, and ends with latent nodes.
"""
mutable struct BoltzmannMachine{T<:Real} <: EnergyBasedModel
    topology::Set{Connection}
    kernel::AbstractMatrix{T}
    bias::AbstractVector{T}
    ambientsize::Integer
end


function create_boltzmann(topology::Set{Connection}, data::AbstractArray{T, 2})::BoltzmannMachine{T} where T<:Real
    N = length(collectnodes(topology))
    dtype = eltype(data)

    # Initialize kernel
    kernel = spzeros(dtype, N, N)

    # Compute latent size
    ambientsize = first(size(data))
    latentsize = N - ambientsize
    if latentsize < 0
        error("Latent size shall be non-negative.")
    end

    # Initialize bias
    ambientbias = hinton_initialize(data)
    latentbias = zeros(dtype, latentsize)
    bias = cat(ambientbias, latentbias, dims=1)

    BoltzmannMachine(topology, kernel, bias, ambientsize)
end


"""
Counts how many nodes in the model.
"""
function Base.size(model::BoltzmannMachine)
    size(model.bias)[1]
end


function ambientsize(model::BoltzmannMachine)
    model.ambientsize
end

function latentsize(model::BoltzmannMachine)
    size(model) - ambientsize(model)
end


"""
Reutrns a tuple of

1. x → E[-∂E/∂W(x)], where W is the kernel;
1. x → E[-∂E/∂b(x)], where b is the bias.
"""
function getops(model::BoltzmannMachine)
    function kernel_op(x)
        n = size(x, 1)
        y = spzeros(eltype(x), n, n)
        for c in model.topology
            y[c.i, c.j] = mean(x[c.i, :] .* x[c.j, :])
            y[c.j, c.i] = mean(x[c.j, :] .* x[c.i, :])
        end
        y
    end

    function bias_op(x)
        y = expect(x)
    end

    (kernel_op, bias_op)
end


function getparams(model::BoltzmannMachine)
    (model.kernel, model.bias)
end


"""
Returns 0 or 1 based on Bernoulli probability `p`.
"""
function bernoulli_sample(p::Number)
    if rand(typeof(p)) < p
        x = 1.
    else
        x = 0.
    end
    x
end


"""
Returns the value that maximizes the Bernoulli probability P(x).
"""
function bernoulli_argmax(p::Number)
    if p > 0.5
        x = 1.
    else
        x = 0.
    end
    x
end


function ambient_latent_kernel(model::BoltzmannMachine{T})::AbstractMatrix{T} where T<:Real
    m = ambientsize(model)
    n = size(model)
    model.kernel[1:m, (m+1):n]
end


function latent_latent_kernel(model::BoltzmannMachine{T})::AbstractMatrix{T} where T<:Real
    m = ambientsize(model)
    n = size(model)
    model.kernel[(m+1):n, (m+1):n]
end


function latent_bias(model::BoltzmannMachine{T})::AbstractVector{T} where T<:Real
    n = ambientsize(model)
    model.bias[(n+1):size(model)]
end


function batchsize(x)
    last(size(x))
end


"""
Calculate latent nodes by mean-field approximation.

Returns the μ and the final step.
"""
function getlatent(model::BoltzmannMachine{T}, ambient::AbstractArray{T, 2},
                   maxstep::Integer, tolerance::Real) where T<:Real
    v = ambient
    W = ambient_latent_kernel(model)
    J = latent_latent_kernel(model)
    b = latent_bias(model)

    # Add dimension for convienent broadcasting
    b = reshape(b, size(b)..., 1)

    # Initialize μ
    μ = rand(eltype(ambient), latentsize(model), batchsize(ambient))

    step = 0
    for _ = 1:maxstep
        # Starts a new step
        step += 1

        # Compute the next iteration for μ
        μ2 = Flux.σ.(W' * v .+ J' * μ .+ b)

        # Stop condition
        if maxabs(μ2 .- μ) < tolerance
            break
        end
        
        # Update μ by the new one.
        μ = μ2
    end

    μ, step
end


"""
Short version of `getlatent(model, ambient, maxstep, tolerance)`.

Returns the μ only.
"""
function getlatent(model::BoltzmannMachine{T}, ambient::AbstractArray{T, 2})::AbstractArray{T, 2} where T<:Real
    (μ, _) = getlatent(model::BoltzmannMachine, ambient, 10, 1E-3)
    μ
end


@doc raw"""
Activity rule of Boltzmann machine. That is,

$$p(x_α = 1 | x_{-α}), ∀ α.$$

"""
function activate(model::BoltzmannMachine{T}, x::AbstractArray{T, 2})::AbstractArray{T, 2} where T<:Real
    # Abbreviations
    W, b = model.kernel, model.bias

    # Add dimension for convienent broadcasting
    b = reshape(b, size(b)..., 1)

    Flux.σ.(W * x .+ b)
end


"""
One-step contrastive divergence.
"""
function contrastive_divergence(model::BoltzmannMachine{T}, x::AbstractArray{T, 2})::AbstractArray{T, 2} where T<:Real
    p = activate(model, x)
    bernoulli_sample.(p)
end


"""
Multi-step contrastive divergence.
"""
function contrastive_divergence(model::BoltzmannMachine{T}, x::AbstractArray{T, 2}, step::Integer) where T<:Real
    for _ = 1:step
        x = contrastive_divergence(model, x)
    end
    x
end


function initialize_fantasy(model::BoltzmannMachine{T}, batchsize::Integer)::AbstractArray{T, 2} where T<:Real
    x = bernoulli_sample.(0.5 .* ones(size(model), batchsize))
    bernoulli_sample.(activate(model, x))
end


# Self-defined RMSProp optimizer.
function train!(model::BoltzmannMachine{T}, fantasy::AbstractArray{T, 2}, batched_data, η, δ, ϵ=1E-8; cb=nothing) where T<:Real
    # Initialize
    kernel_acc = spzeros(size(model.kernel)...)
    bias_acc = zeros(size(model.bias)...)
    early_stopped = false

    for (step, real_ambient) in enumerate(batched_data)
        # Compute real state (particles)
        real_latent = bernoulli_argmax.(getlatent(model, real_ambient))
        real = cat(real_ambient, real_latent; dims=1)

        # Compute gradients
        grads = gradients(model, real, fantasy)

        # Update kernel
        grad_kernel = grads[1]
        for c in model.topology
            g = grad_kernel[c.i, c.j]
            E = 0.9 * kernel_acc[c.i, c.j] + 0.1 * g^2
            kernel_acc[c.i, c.j] = E
            model.kernel[c.i, c.j] -= η * g / √(E + ϵ)
        end

        # Update bias
        grad_bias = grads[2]
        bias_acc = 0.9 .* bias_acc + 0.1 .* grad_bias.^2
        @. model.bias -= η * grad_bias / √(bias_acc + ϵ)

        # Update fantasy state (particles)
        fantasy = contrastive_divergence(model, fantasy)

        # Callback
        if cb !== nothing
            cb(step, real, fantasy, grads)
        end

        # If early stop
        if step > 1 && max(map(maxabs, grads)...) < δ
            early_stopped = true
            break
        end
    end

    fantasy, early_stopped
end


function train!(model::BoltzmannMachine{T}, fantasy::AbstractArray{T, 2}, data, opt, tolerance; cb=nothing) where T<:Real
    params = getparams(model)
    early_stopped = false  # initialize.

    for (step, real_ambient) in enumerate(data)
        # Compute real state (particles)
        real_latent = bernoulli_argmax.(getlatent(model, real_ambient))
        real = cat(real_ambient, real_latent; dims=1)

        # Compute gradients
        grads = gradients(model, real, fantasy)

        # Optimize
        for (p, g) in zip(params, grads)
            Flux.update!(opt, p, g)
        end

        # Update fantasy state (particles)
        fantasy = contrastive_divergence(model, fantasy)

        # Callback
        if cb !== nothing
            cb(step, real, fantasy, grads)
        end

        # If early stop
        if step > 1 && max(map(maxabs, grads)...) < tolerance
            early_stopped = true
            break
        end
    end

    fantasy, early_stopped
end
