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
X = preprocess(X₀[:, :, 1:N], IMAGE_SIZE) |> zoomin(ZOOMIN_RATIO, 0.4)

# Model
x̂ = expect(X)
min(x̂...)
Ĉ = cov(X; dims=2, corrected=false)
# m = getPBM(x̂, Ĉ, x̂)  # thus setting the diagonal of W vanish.
m = getPBM(x̂, Ĉ)  # thus enscure the positive semi-defineness of W.
histogram(flatten(m.W); bins=100, title="W", legends=false)

# Analyze kernel
λ, V = eigen(m.W)
Vᵣ = @. real(V)
Vᵢ = @. imag(V)
λᵣ = @. real(λ)
λᵢ = @. imag(λ)
histogram(λᵣ; bins=100, title="Real part of λ", legends=false)
min(λᵣ...)
L∞(λᵢ)

# Construct PRBM
rm = getPRBM(m, 20.)  # δ needs careful fine-tuning.
size(rm.U)
histogram(flatten(rm.U); bins=100, title="U", legends=false)

# Re-construct PBM from PRBM
m̃ = getPBM(rm)
histogram(flatten(m.W - m̃.W); bins=100, title="ΔW", legends=false)

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
X₂ = preprocess(X₂, IMAGE_SIZE)
X₂ = zoomin(ZOOMIN_RATIO, 0., X₂)

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
