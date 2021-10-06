include("Perturb.jl")

using MLDatasets: MNIST
using Statistics: cov, mean, std
using LinearAlgebra
using Plots
using TSne
using Distances: hamming

# Data
X₀, y₀ = MNIST.traindata()
X = preprocess(X₀[:, :, 1:1000], (32, 32)) .|> x -> smooth(x, 0.35)

# Model
x̂ = expect(X)
Ĉ = cov(X; dims=2, corrected=false)
# σ = map(x -> one(x) / 2, x̂)
σ = x̂
m = getPBM(x̂, Ĉ, σ)
histogram(flatten(m.W); bins=100, title="W", legends=false)

# Analyze kernel
λ, V = eigen(m.W)
Vᵣ = @. real(V)
Vᵢ = @. imag(V)
λᵣ = @. real(λ)
λᵢ = @. imag(λ)
histogram(λᵣ; bins=100, title="Real part of λ", legends=false)

# Construct PRBM
rm = getPRBM(m, 1.)
size(rm.U)
histogram(flatten(rm.U); bins=100, title="U", legends=false)

# Re-construct PBM from PRBM
m̃ = getPBM(rm)
histogram(flatten(m.W - m̃.W); bins=100, title="ΔW", legends=false)

# Denoise
i = 3
x = X[:, i] .|> binarize
x̃ = addnoise(x, 5)
original_error = sum(Int.(x̃ .!= x))
y1, final_step = recur(100, x -> activate(m, x), x̃)
y2, final_step = recur(100, x -> activate(m̃, x), x̃)
denoised_error_1 = sum(Int.(y1 .!= x))
denoised_error_2 = sum(Int.(y2 .!= x))

# Latent space
X₂, y₂ = filter_by_labels(X₀, y₀[1:3000], [1, 5, 0])
X₂ = preprocess(X₂, (32, 32))
cat_(xs) = cat(xs...; dims=2)
Zi = [getlatent(rm, X₂[:, i]) for i = 1:size(X₂, 2)] |> cat_
Zf = [getlatent(rm, recur(100, x -> activate(rm, x), X₂[:, i])[1]) for i = 1:size(X₂, 2)] |> cat_

# Visulize the latent
rescale(A; dims=1) = (A .- mean(A, dims=dims)) ./ max.(std(A, dims=dims), eps())
Zi2d = tsne(rescale(Zi)', 2)
Zf2d = tsne(rescale(Zf)', 2)
scatter(Zi2d[:, 1], Zi2d[:, 2], color=Int.(y₂), title="t-SNE of latent", legends=false, alpha=0.65)
scatter(Zf2d[:, 1], Zf2d[:, 2], color=Int.(y₂), title="t-SNE of latent", legends=false, alpha=0.65)

function instance(i, j)
    hamming = sum(Int.(Zf[:, i] .!= Zf[:, j]))
    println("y: $(y₂[i]) - $(y₂[j])\nhamming: $hamming")
end
instance(2, 102)
