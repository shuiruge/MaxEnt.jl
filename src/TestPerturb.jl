include("Perturb.jl")

using MLDatasets: MNIST
using Statistics: cov
using LinearAlgebra
using Plots
using TSne

# Data
X₀, y₀ = MNIST.traindata()
X = preprocess(X₀[:, :, 1:1000], (32, 32)) .|> x -> smooth(x, 0.35)

# Model
x̂ = expect(X)
Ĉ = cov(X; dims=2, corrected=false)
# σ = map(x -> one(x) / 2, x̂)
σ = x̂
m = getPBM(x̂, Ĉ, σ)
histogram(flatten(m.W); bins=100, title="W")

# Analyze kernel
λ, V = eigen(m.W)
Vᵣ = @. real(V)
Vᵢ = @. imag(V)
λᵣ = @. real(λ)
λᵢ = @. imag(λ)
histogram(λᵣ; bins=100, title="Real part of λ")

# Construct PRBM
rm = getPRBM(m, 0.1)
histogram(flatten(rm.U); bins=100, title="U")

# Re-construct PBM from PRBM
m̃ = getPBM(rm)

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
y₂ = y₀[1:1000]
X₂ = preprocess(filter_by_labels(X₀, y₂, [1, 2, 3]), (32, 32))
R = [recur(100, x -> activate(rm, x), X₂[:, i])[1] for i = 1:size(X₂, 2)]
Z = cat([getlatent(rm, r) for r in R]...; dims=2)
Z₂ = tsne(Z', 2, 50, 1000, 20.0);
i, j = 2, 3
(y₂[i], y₂[j], sum(Int.(Z[:, i] .!= Z[:, i])))


scatter(Z₂[:, 1], Z₂[:, 2], marker=(2,2,:auto,stroke(0)), color=Int.(y₂); title="t-SNE of latent")
