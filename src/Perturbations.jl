include("Utils.jl")

using LinearAlgebra


struct PerturbedBoltzmannMachine{T<:Real}
    x̂::AbstractVector{T}
    b::AbstractVector{T}
    W::AbstractMatrix{T}
end


"""
Implements the theorem "Perturbation Solutions of BM".

- x̂: mean value.
- Ĉ: covariance
- w: diagonal of W matrix.
"""
function getPBM(x̂::AbstractVector{T},
                Ĉ::AbstractMatrix{T},
                w::AbstractVector{T}
                ) where T<:Real
    W = zeros(eltype(Ĉ), size(Ĉ))
    for i = 1:size(Ĉ, 1)
        for j = 1:size(Ĉ, 2)
            if i == j
                W[i, j] = w[i]
            else
                W[i, j] = Ĉ[i, j] / x̂[i] / (1 - x̂[i]) / x̂[j] / (1 - x̂[j])
            end
        end
    end

    b = @. invσ(x̂) - w * (x̂ - 1/2)
    PerturbedBoltzmannMachine(x̂, b, W)
end


function energy(m::PerturbedBoltzmannMachine{T}, x::AbstractVector{T}) where T<:Real
    -1/2 * (x .- m.x̂)' * m.W * (x .- m.x̂) - m.b' * x
end


function energy(m::PerturbedBoltzmannMachine{T}, x::AbstractMatrix{T}) where T<:Real
    [energy(m, x[:, i]) for i = 1:size(x, 2)]
end


"""
Implements the theorem "Activity Rule of BM".
"""
function activate(m::PerturbedBoltzmannMachine{T}, x::AbstractVector{T}; deterministic=true) where T<:Real
    W_diag = diag(m.W)
    c = @. m.b + (1/2 - m.x̂) * W_diag

    nodes = 1:size(m.b, 1)

    # Order of node for activation
    indices = (deterministic) ? nodes : shuffle(nodes)

    # Activate
    x = copy(x)
    @inbounds for i = indices
        a = c[i]
        for j = nodes
            if i != j
                a += m.W[i, j] * (x[j] - m.x̂[j])
            end
        end
        x[i] = hardσ(a)
    end
    x
end


struct PerturbedRestrictedBoltzmannMachine{T<:Real}
    v̂::AbstractVector{T}
    b::AbstractVector{T}
    U::AbstractMatrix{T}
end


"""
Implements the lemma "Perturbation of RBM", where we have set ĥⁱ ≡ 1/2 and cᵢ ≡ 0.
"""
function getPRBM(m::PerturbedBoltzmannMachine{T}, ϵ::T) where T<:Real
    λ, V = eigen(m.W)
    λ = @. real(λ)
    V = @. real(V)

    indices = filter(i -> λ[i] > ϵ, 1:size(λ, 1))
    n = length(indices)
    N = size(V, 1)

    U = zeros(eltype(V), N, n)
    for α = 1:N
        for i = 1:n
            j = indices[i]
            U[α, i] = V[α, j] * (2 * √λ[j])
        end
    end

    PerturbedRestrictedBoltzmannMachine(m.x̂, m.b, U)
end


"""
Implements the lemma "Perturbation of RBM", inversely, where we have set ĥⁱ ≡ 1/2 and cᵢ ≡ 0.
"""
function getPBM(m::PerturbedRestrictedBoltzmannMachine)
    W = m.U * transpose(m.U) ./ 4
    PerturbedBoltzmannMachine(m.v̂, m.b, W)
end


"""
Auxillary function of `activate`.
"""
function getlatent(m::PerturbedRestrictedBoltzmannMachine{T}, v::AbstractVector{T}) where T<:Real
    hardσ.(transpose(m.U) * (v .- m.v̂))
end


"""
Auxillary function of `activate`.
"""
function getambient(m::PerturbedRestrictedBoltzmannMachine{T}, h::AbstractVector{T}) where T<:Real
    hardσ.(m.U * (h .- 1/2) .+ m.b)
end


"""
Implements the theorem "Activity Rule of BM".
"""
function activate(m::PerturbedRestrictedBoltzmannMachine, v::AbstractVector{T}) where T<:Real
    getambient(m, getlatent(m, v))
end


# TODO: T<:Float ?
"""
Auxillary function of `zoomin`.
"""
function sample_bernoulli(p::T) where T<:Real
    if rand(typeof(p)) < p
        one(p)
    else
        zero(p)
    end
end


"""
Implements the "Zoom-in Trick".
"""
function zoomin(n, δ::T, x::T) where T<:Real
    @assert 0 <= δ <= 0.5

    if x < 0.5
        [sample_bernoulli(δ) for i = 1:n]
    else
        [sample_bernoulli(1 - δ) for i = 1:n]
    end
end


"""
Implements the "Zoom-in Trick".
"""
function zoomin(n, δ::T, x::AbstractVector{T}) where T<:Real
    vcat([zoomin(n, δ, x[i]) for i = 1:size(x, 1)]...)
end


"""
Implements the "Zoom-in Trick".
"""
function zoomin(n, δ::T, x::AbstractMatrix{T}) where T<:Real
    hcat([zoomin(n, δ, x[:, i]) for i = 1:size(x, 2)]...)
end


function zoomin(n, δ)
    x -> zoomin(n, δ, x)
end
