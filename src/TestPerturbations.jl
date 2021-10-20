include("Perturbations.jl")
include("data/Mnist.jl")

using MLDatasets: MNIST
using Statistics: cov, mean, std
using LinearAlgebra
using Plots
using TSne
import Random

Random.seed!(42)

# Data
X₀, y₀ = MNIST.traindata()
# N = 5  # for checking denoiseness.
N = 2000  # for showing latent encoding.
IMAGE_SIZE = (16, 16)
ZOOMIN_RATIO = 8
X = preprocess(X₀[:, :, 1:N], IMAGE_SIZE) |> zoomin(ZOOMIN_RATIO, 0.45)

# Model
x̂ = expect(X)
min(x̂...)
Ĉ = cov(X; dims=2, corrected=false)
w = @. 1 / x̂ / (1 - x̂)
bm = getPBM(x̂, Ĉ, w)
histogram(flatten(bm.W); bins=100, title="W", legends=false)


# XXX: test!
# function quantize(x, ϵ)
#     floor(abs(x / ϵ)) * sign(x) * ϵ
# end
#
# quantize(ϵ) = x -> quantize(x, ϵ)
#
# vanish_diag(m::AbstractMatrix) = m .- Diagonal(diag(m))
# Ĉ₀ = vanish_diag(Ĉ)
#
# add_diag(m::AbstractMatrix, v::AbstractVector) = m .+ Diagonal(v)
# C_diag = sum(abs.(Ĉ₀); dims=1) |> squeeze
# λ, V = eigen(add_diag(Ĉ₀, C_diag))
# λ = @. real(λ)
#
# C_diag = C_diag .- λ
# λ, V = eigen(add_diag(Ĉ₀, C_diag))
# λ = @. real(λ)
#
# λ, V = eigen(Ĉ)
# bb = -λ .* [sum(V'[i, :].^2) for i = 1:size(V, 1)]
# γ = bb' * inv(V.^2 ) |> squeeze
# λ, V = eigen(add_diag(Ĉ, γ))
# λ = @. real(λ)


# Analyze kernel
λ, V = eigen(bm.W)
Vᵣ = @. real(V)
Vᵢ = @. imag(V)
λᵣ = @. real(λ)
λᵢ = @. imag(λ)
histogram(λᵣ; bins=100, title="Real part of λ", legends=false)
min(λᵣ...)
L∞(λᵢ)

# Construct PRBM
rbm = getPRBM(bm, 1E-0)
size(rbm.U)
histogram(flatten(rbm.U); bins=100, title="U", legends=false)

# Re-construct PBM from PRBM
bm2 = getPBM(rbm)
histogram([flatten(bm.W - bm2.W), flatten(bm.W)]; bins=100, title="ΔW/W")

# Denoise
# i = 3
# x = X[:, i] .|> binarize
# x̃ = addnoise(x, 20)
# original_error = sum(Int.(x̃ .!= x))
# y1, final_step = recur(100, x -> activate(m, x), x̃)
# y2, final_step = recur(100, x -> activate(m̃, x), x̃)
# denoised_error_1 = sum(Int.(y1 .!= x))
# denoised_error_2 = sum(Int.(y2 .!= x))

"""
Auxillary function for t-SNE.
"""
function rescale(A; dims=1)
    (A .- mean(A, dims=dims)) ./ max.(std(A, dims=dims), eps())
end

# For better quality of visualization, we prefer less labels
X₂, y₂ = filter_by_labels(X₀, y₀[1:3000], [1, 5, 0])
X₂ = preprocess(X₂, IMAGE_SIZE) |> zoomin(ZOOMIN_RATIO, 0.)

# Latent encoding
Z = nothing
for step = 1:20
    if Z === nothing
        Z = [getlatent(rm, X₂[:, i]) for i = 1:size(X₂, 2)]
    else
        Z = [getlatent(rm, getambient(rm, z)) for z in Z]
    end

    # Projection to 2D
    Z2d = tsne(cat(Z...; dims=2)', 2)

    # Plots and save the plot
    fig = scatter(Z2d[:, 1], Z2d[:, 2], color=Int.(y₂), title="t-SNE of latent", legends=false, alpha=0.3)
    output_file = "../data/plots/tsne_at_step_$(step).pdf"
    savefig(fig, output_file)
end


# Check the encoding result.
# TODO: add comments to the code below.
n₁, n₂ = 0, 0
for i = 1:length(Z)
    for j = 1:length(Z)
        if i <= j
            continue
        end

        if y₂[i] == y₂[j]
            continue
        end

        n₁ += 1

        hamming = sum(Int.(Z[i] .!= Z[j]))
        if hamming == 0
            # println("$(hamming)  |   $(y₂[i]) - $(y₂[j])   |   $i - $j")
            n₂ += 1
        end
    end
end
n₁, n₂, n₂ / n₁
