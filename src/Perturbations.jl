include("Utils.jl")

using LinearAlgebra


struct PerturbedBoltzmannMachine
    x̂
    b
    W
end


"""
Abbreviation.
"""
const PBM = PerturbedBoltzmannMachine


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

    PBM(x̂, invσ.(σ), W)
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




function activate(m::PBM, x; deterministic=true)
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


struct PerturbedRestrictedBoltzmannMachine
    x̂
    b
    U
end


"""
Abbreviation.
"""
const PRBM = PerturbedRestrictedBoltzmannMachine


"""
Creates PRBM from PBM. The δ is for clipping the eigen-values.
"""
function getPRBM(m::PBM, δ)
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

    PRBM(m.x̂, m.b, U)
end


"""
Creates PBM from PRBM.
"""
function getPBM(m::PRBM)
    W = m.U * transpose(m.U) ./ 4
    PBM(m.x̂, m.b, W)
end


function getlatent(m::PRBM, x)
    hardσ.(transpose(m.U) * (x .- m.x̂))
end


function getambient(m::PRBM, z)
    hardσ.(m.U * (z .- 1/2) .+ m.b)
end


function activate(m::PRBM, x)
    getambient(m, getlatent(m, x))
end
