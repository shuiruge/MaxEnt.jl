include("Utils.jl")

using LinearAlgebra


struct PerturbedBoltzmannMachine{T<:Real}
    x̂::AbstractVector{T}
    b::AbstractVector{T}
    W::AbstractMatrix{T}
end


"""
Creates PBM from real world data.
"""
function getPBM(x̂::AbstractVector{T},
                Ĉ::AbstractMatrix{T},
                σ::AbstractVector{T}
                ) where T<:Real

    # Computes W[i, i]
    function getdiag(x̂, σ)
        if (x̂ == 0.5) && (σ == 0.5)
            one(σ)
        else
            (x̂ - σ) / x̂ / (1 - x̂) / (1/2 - x̂)
        end
    end

    W = zeros(eltype(Ĉ), size(Ĉ))
    for i = 1:size(Ĉ, 1)
        for j = 1:size(Ĉ, 2)
            if i == j
                W[i, j] = getdiag(x̂[i], σ[i])
            else
                W[i, j] = Ĉ[i, j] / x̂[i] / (1 - x̂[i]) / x̂[j] / (1 - x̂[j])
            end
        end
    end

    PerturbedBoltzmannMachine(x̂, invσ.(σ), W)
end


"""
Creates PBM from real world data.
"""
function getPBM(x̂::AbstractVector{T},
                Ĉ::AbstractMatrix{T},
                ) where T<:Real
    # Ensure positive semi-defineness, define σ as follow.
    σ = 2 .* x̂ .- 1/2

    for σᵢ ∈ σ
        @assert 0 < σᵢ < 1
    end

    getPBM(x̂, Ĉ, σ)
end


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
    x̂::AbstractVector{T}
    b::AbstractVector{T}
    U::AbstractMatrix{T}
end


"""
Creates PRBM from PBM. The δ is for clipping the eigen-values.
"""
function getPRBM(m::PerturbedBoltzmannMachine{T}, δ::T) where T<:Real
    λ, V = eigen(m.W)
    λᵣ = @. real(λ)
    Vᵣ = @. real(V)

    indices = filter(i -> λᵣ[i] > δ, 1:size(λᵣ, 1))
    n = length(indices)
    N = size(Vᵣ, 1)

    U = zeros(eltype(Vᵣ), N, n)
    for i = 1:N
        for j = 1:n
            k = indices[j]
            U[i, j] = Vᵣ[i, k] * (2 * √λᵣ[k])
        end
    end

    PerturbedRestrictedBoltzmannMachine(m.x̂, m.b, U)
end


"""
Creates PBM from PRBM.
"""
function getPBM(m::PerturbedRestrictedBoltzmannMachine)
    W = m.U * transpose(m.U) ./ 4
    PerturbedBoltzmannMachine(m.x̂, m.b, W)
end


function getlatent(m::PerturbedRestrictedBoltzmannMachine{T}, x::AbstractVector{T}) where T<:Real
    hardσ.(transpose(m.U) * (x .- m.x̂))
end


function getambient(m::PerturbedRestrictedBoltzmannMachine{T}, z::AbstractVector{T}) where T<:Real
    hardσ.(m.U * (z .- 1/2) .+ m.b)
end


function activate(m::PerturbedRestrictedBoltzmannMachine, x::AbstractVector{T}) where T<:Real
    getambient(m, getlatent(m, x))
end


# TODO: T<:Float ?
"""
Auxillary function of `inflate`.
"""
function sample_bernoulli(p::T) where T<:Real
    if rand(typeof(p)) < p
        one(p)
    else
        zero(p)
    end
end


"""
Auxillary function of `inflate`.
"""
function flip_onebit!(y, target)
    for i = 1:size(y, 1)
        if y[i] != target
            y[i] = eltype(y)(target)
            break
        end
    end
end


function inflate(n, δ::T, x::T) where T<:Real
    @assert 0 <= δ <= 0.5

    if x < 0.5
        y = [sample_bernoulli(δ) for i = 1:n]
        if mean(y) > 0.5
            y = 1 .- y
        elseif mean(y) == 0.5
            flip_onebit!(y, 0)
        end

    else
        y = [sample_bernoulli(1 - δ) for i = 1:n]
        if mean(y) < 0.5
            y = 1 .- y
        elseif mean(y) == 0.5
            flip_onebit!(y, 1)
        end
    end

    y
end


function inflate(n, δ::T, x::AbstractVector{T}) where T<:Real
    vcat(map(x -> inflate(n, δ, x), x)...)
end


function inflate(n, δ::T, x::AbstractMatrix{T}) where T<:Real
    hcat([inflate(n, δ, x[:, i]) for i = 1:size(x, 2)]...)
end
