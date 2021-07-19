using Flux
using SparseArrays: spzeros
using Statistics: std


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
function hinton_initialize(data::AbstractArray{T, 2})::AbstractVector{T} where T<:Real
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


function symmetrize(topology::Set{Connection})
    symmetrized = Connection[]
    for c in topology
        push!(symmetrized, Connection(c.i, c.j))
        push!(symmetrized, Connection(c.j, c.i))
    end
    Set(symmetrized)
end


function create_boltzmann(topology::Set{Connection}, data::AbstractArray{T, 2})::BoltzmannMachine{T} where T<:Real
    topology = symmetrize(topology)

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
            @inbounds y[c.i, c.j] = mean(x[c.i, :] .* x[c.j, :])
        end
        y
    end

    function bias_op(x)
        expect(x)
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
        x = one(p)
    else
        x = zero(p)
    end
    x
end


"""
Returns the value that maximizes the Bernoulli probability P(x).
"""
function bernoulli_argmax(p::Number)
    if p > 0.5
        x = one(p)
    else
        x = zero(p)
    end
    x
end


function ambient_ambient_kernel(model::BoltzmannMachine{T})::AbstractMatrix{T} where T<:Real
    m = ambientsize(model)
    model.kernel[1:m, 1:m]
end


function ambient_latent_kernel(model::BoltzmannMachine{T})::AbstractMatrix{T} where T<:Real
    m = ambientsize(model)
    model.kernel[1:m, (m+1):end]
end


function latent_latent_kernel(model::BoltzmannMachine{T})::AbstractMatrix{T} where T<:Real
    m = ambientsize(model)
    model.kernel[(m+1):end, (m+1):end]
end


function ambient_bias(model::BoltzmannMachine{T})::AbstractVector{T} where T<:Real
    m = ambientsize(model)
    model.bias[1:m]
end


function latent_bias(model::BoltzmannMachine{T})::AbstractVector{T} where T<:Real
    m = ambientsize(model)
    model.bias[(m+1):end]
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
        μ̂ = Flux.σ.(W' * v .+ J' * μ .+ b)

        # Stop condition
        if maxabs(μ̂ .- μ) < tolerance
            break
        end
        
        # Update μ by the new one.
        μ = μ̂
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
    W = model.kernel
    b = model.bias

    # Add dimension for convienent broadcasting
    b = reshape(b, size(b)..., 1)

    Flux.σ.(W * x .+ b)
end


"""
One-step contrastive divergence.
"""
function contrastive_divergence(model::BoltzmannMachine{T}, x::AbstractArray{T, 2})::AbstractArray{T, 2} where T<:Real
    p = activate(model, x)
    @. bernoulli_sample(p)
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
    p = 0.5 .* ones(size(model), batchsize)
    x = @. bernoulli_sample(p)

    p̂ = activate(model, x)
    @. bernoulli_sample(p̂)
end


function train!(model::BoltzmannMachine{T}, fantasy::AbstractArray{T, 2}, data, opt, tolerance; cb=nothing) where T<:Real
    params = getparams(model)
    early_stopped = false  # initialize.

    for (step, real_ambient) in enumerate(data)
        # Compute real state (particles)
        μ = getlatent(model, real_ambient)
        real_latent = @. bernoulli_sample(μ)
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


mutable struct Logger
    model::BoltzmannMachine
    logstep::Integer
    verbose::Bool
    logs::Dict{Integer, Any}  # step => anything to log.

    Logger(model::BoltzmannMachine, logstep::Integer; verbose=false) = new(model, logstep, verbose, Dict())
end


function (logger::Logger)(step, real, fantasy, grads)
    if step % logger.logstep != 0
        return
    end

    m = ambientsize(logger.model)
    real_ambient = real[1:m, :]
    real_latent = real[(m+1):end, :]
    fantasy_ambient = fantasy[1:m, :]
    fantasy_latent = fantasy[(m+1):end, :]
    stats(x) = Dict("mean" => mean(x), "std" => std(x))

    recon = bernoulli_argmax.(activate(model, real))
    recon_ambient = recon[1:m, :]
    recon_err = mean((x -> x != 0 ? 1 : 0).(real_ambient .- recon_ambient))

    log = [
        ("real_ambient", stats(real_ambient)),
        ("real_latent", stats(real_latent)),
        ("fantasy_ambient", stats(fantasy_ambient)),
        ("fantasy_latent", stats(fantasy_latent)),
        ("kernel_grad", stats(grads[1])),
        ("bias_grad", stats(grads[2])),
        ("recon_err", stats(recon_err)),
    ]
    logger.logs[step] = log

    if logger.verbose
        println("step => $step")
        for (k, v) in log
            v1 = v["mean"]
            v2 = v["std"]
            println("$k => $v1 ⨦ $v2")
        end
    end
end