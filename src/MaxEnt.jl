using Flux
using Random
using SparseArrays
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

Parameters
----------
- `real` is the real world data, obeying the $q(x)$ distribution.
- `fantasy` is the data imagined by the model, obeying the $p(x;θ)$
  distribution.

Returns
-------
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
function collectnodes(topology::Vector{Connection})::Set{Integer}
    nodes = Set()
    for c = topology
        push!(nodes, c.i)
        push!(nodes, c.j)
    end
    nodes
end


"""
Hinton's initialization strategy for the ambient bias of Boltzmann machine.
"""
function hinton_initialize(data::AbstractArray{T, 2}; ϵ)::AbstractVector{T} where T<:Real
    p = expect(data)
    @. log(p + ϵ) - log(1 - p + ϵ)
end


"""
Parameters
----------
- `topology` represents the connections of the network.
- `kernel` is a sparse N×N matrix, where N is the total number of nodes.
- `bias` is a dense 1×N matrix.
- `ambientsize` ≤ N.

Convention
----------
- The node index starts from ambient nodes, and ends with latent nodes.
"""
mutable struct BoltzmannMachine{T<:Real} <: EnergyBasedModel
    topology::Vector{Connection}
    kernel::AbstractMatrix{T}
    bias::AbstractVector{T}
    ambientsize::Integer
    minval::T
    maxval::T
end


function Base.eltype(model::BoltzmannMachine{T}) where T<:Real
    eltype(model.bias)
end


function symmetrize(topology::Vector{Connection})
    symmetrized = Connection[]
    for c = topology
        push!(symmetrized, Connection(c.i, c.j))
        push!(symmetrized, Connection(c.j, c.i))
    end
    collect(Set(symmetrized))
end


function create_boltzmann(topology::Array{Connection}, data::AbstractArray{T, 2}; ϵ=1E-8, minval=0, maxval=1)::BoltzmannMachine{T} where T<:Real
    dtype = eltype(data)
    minval = dtype(minval)
    maxval = dtype(maxval)
    N = length(collectnodes(topology))

    # Process topology
    sort_topology(topology) = sort(topology, by=(c -> c.i * N + c.j))
    deduplicate(xs) = collect(Set(xs))
    symmetrize(c::Connection) = [Connection(c.i, c.j), Connection(c.j, c.i)]
    symmetrize(topology::Vector{Connection}) = vcat(map(symmetrize, topology)...)
    topology = topology |> symmetrize |> deduplicate |> sort_topology

    # Initialize kernel
    Is, Js, Vs = [], [], dtype[]
    for c = topology
        push!(Is, c.i)
        push!(Js, c.j)
        push!(Vs, 0)
    end
    kernel = sparse(Is, Js, Vs)

    # Compute latent size
    ambientsize = first(size(data))
    latentsize = N - ambientsize
    if latentsize < 0
        error("Latent size shall be non-negative.")
    end

    # Initialize bias
    ambientbias = hinton_initialize(data; ϵ)
    latentbias = zeros(dtype, latentsize)
    bias = cat(ambientbias, latentbias, dims=1)

    BoltzmannMachine(topology, kernel, bias, ambientsize, minval, maxval)
end


"""
Counts how many nodes in the model.
"""
function Base.size(model::BoltzmannMachine)
    size(model.bias, 1)
end


function latentsize(model::BoltzmannMachine)
    size(model) - model.ambientsize
end


"""
Reutrns a tuple of
    - x → E[-∂E/∂W(x)], where W is the kernel;
    - x → E[-∂E/∂b(x)], where b is the bias.
"""
function getops(model::BoltzmannMachine)
    topo = model.topology
    N = length(topo)

    function kernel_op(x)
        nzval = zeros(eltype(model), N)
        @fastmath @inbounds @simd for n = 1:N
            c = topo[n]
            nzval[n] = mean(x[c.i, :] .* x[c.j, :])
        end
        nzval
    end

    function bias_op(x)
        expect(x)
    end

    (kernel_op, bias_op)
end


function getparams(model::BoltzmannMachine)
    (model.kernel.nzval, model.bias)
end


"""
Returns `minval` or `maxval` based on Bernoulli probability `p`.
"""
function bernoulli_sample(p::AbstractArray, minval::T, maxval::T)::AbstractArray{T} where T<:Real
    f(p) = rand(typeof(p)) < p ? maxval : minval
    f.(p)
end


function bernoulli_sample(model::BoltzmannMachine{T}, p) where T<:Real
    bernoulli_sample(p, model.minval, model.maxval)
end


"""
Returns the value that maximizes the Bernoulli probability P(x).
"""
function bernoulli_argmax(p::AbstractArray, minval::T, maxval::T)::AbstractArray{T} where T<:Real
    f(p) = p > 0.5 ? maxval : minval
    f.(p)
end

function bernoulli_argmax(model::BoltzmannMachine{T}, p::AbstractArray)::AbstractArray{T} where T<:Real
    bernoulli_argmax(p, model.minval, model.maxval)
end


function ambient_ambient_kernel(model::BoltzmannMachine{T})::AbstractMatrix{T} where T<:Real
    m = model.ambientsize
    model.kernel[1:m, 1:m]
end


function ambient_latent_kernel(model::BoltzmannMachine{T})::AbstractMatrix{T} where T<:Real
    m = model.ambientsize
    model.kernel[1:m, (m+1):end]
end


function latent_latent_kernel(model::BoltzmannMachine{T})::AbstractMatrix{T} where T<:Real
    m = model.ambientsize
    model.kernel[(m+1):end, (m+1):end]
end


function ambient_bias(model::BoltzmannMachine{T})::AbstractVector{T} where T<:Real
    m = model.ambientsize
    model.bias[1:m]
end


function latent_bias(model::BoltzmannMachine{T})::AbstractVector{T} where T<:Real
    m = model.ambientsize
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
    @fastmath @inbounds for _ = 1:maxstep
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
    (μ, _) = getlatent(model, ambient, 10, 1E-1)
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

    @fastmath @inbounds Flux.σ.(W * x .+ b)
end


"""
One-step contrastive divergence.
"""
function contrastive_divergence(model::BoltzmannMachine{T}, x::AbstractArray{T, 2})::AbstractArray{T, 2} where T<:Real
    p = activate(model, x)
    bernoulli_sample(model, p)
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
    p = 0.5 .* ones(size(model), batchsize) .|> eltype(model)
    x = bernoulli_sample(model, p)

    p̂ = activate(model, x)
    bernoulli_sample(model, p̂)
end


function train!(model::BoltzmannMachine{T}, fantasy::AbstractArray{T, 2}, data, opt, tolerance; cb=nothing) where T<:Real
    params = getparams(model)
    early_stopped = false  # initialize.

    for (step, real_ambient) in enumerate(data)
        # Compute real state (particles)
        μ = getlatent(model, real_ambient)
        real_latent = bernoulli_sample(model, μ)
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


"""
A callback for logging the training process.
"""
mutable struct Logger
    model::BoltzmannMachine
    logstep::Integer
    verbose::Bool
    logs::Dict{Integer, Any}  # step => anything to log.

    Logger(model::BoltzmannMachine, logstep::Integer; verbose=false) = new(model, logstep, verbose, Dict())
end


function (logger::Logger)(step, real, fantasy, grads)
    if (step == 1) || (step % logger.logstep == 0)
        m = logger.model.ambientsize
        real_ambient = real[1:m, :]
        real_latent = real[(m+1):end, :]
        fantasy_ambient = fantasy[1:m, :]
        fantasy_latent = fantasy[(m+1):end, :]
        stats(x) = Dict("mean" => mean(x), "std" => std(x))

        recon = bernoulli_argmax(model, activate(model, real))
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
end