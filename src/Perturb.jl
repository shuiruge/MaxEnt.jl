include("Utils.jl")
include("data/Mnist.jl")


struct PerturbedBoltzmannMachine
    σ
    W
end

const PBM = PerturbedBoltzmannMachine


function create_pbm(x̂::AbstractVector{T},
                    Ĉ::AbstractMatrix{T},
                    σ::AbstractVector{T}
                    ) where T<:Real
    W_diag = @. (x̂ - σ) / x̂ / (1 - x̂) / (1/2 - x̂)

    W = zeros(eltype(Ĉ), size(Ĉ))
    for i = 1:size(Ĉ, 1)
        for j = 1:size(Ĉ, 2)
            if i == j
                W[i, j] = W_diag[i]
            else
                W[i, j] = Ĉ[i, j] / x̂[i] / ( 1 -x̂[i]) / x̂[j] / (1 - x̂[j])
            end
        end
    end

    PBM(σ, W)
end


function getx̂(m::PBM)
    σ, W = m.σ, m.W
    W_diag = diag(W)

    @. σ + W_diag * σ * (1 - σ) * (1/2 - σ)
end


function activate(m::PBM, x::Datum; deterministic=true)
    b = @. invσ(m.σ)
    x̂ = getx̂(m)
    W_diag = diag(m.W)
    c = @. b + (1/2 - x̂) * W_diag

    nodes = 1:size(m.σ, 1)

    # Order of node for activation
    indices = (deterministic) ? nodes : shuffle(nodes)

    # Activate
    x = copy(x)
    @inbounds for i = indices
        a = c[i]
        for j = nodes
            if i != j
                a += m.W[i, j] * (x[j] - x̂[j])
            end
        end
        x[i] = (a > 0) ? one(x[i]) : zero(x[i])
    end
    x
end


function activate(m::PBM; deterministic=true)
    x -> activate(m, x; deterministic=deterministic)
end


function recur(maxstep::Integer, fn, init)
    final_step = 1
    x = init
    for step = 1:maxstep
        next_x = fn(x)
        if next_x == x
            break
        else
            x = next_x
        end
        final_step += 1
    end
    x, final_step
end
