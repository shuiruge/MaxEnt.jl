include("Perturb.jl")

using MLDatasets: MNIST
using Statistics: cov
using LinearAlgebra
using Plots

# Data
X₀, y₀ = MNIST.traindata()
X = preprocess(X₀[:, :, 1:5], (16, 16)) .|> x -> smooth(x, 0.35)

# Model
x̂ = expect(X)
Ĉ = cov(X; dims=2, corrected=false)
# σ = map(x -> one(x) / 2, x̂)
σ = x̂
m = create_pbm(x̂, Ĉ, σ)

# Analyze kernel
λ, U = eigen(m.W)
Uᵣ = @. real(U)
Uᵢ = @. imag(U)
λᵣ = @. real(λ)
λᵢ = @. imag(λ)
histogram(λᵣ; bins=100, title="Real part of λ")

# Clipping kernel
Ũ = Uᵣ * Diagonal(map(x -> (x > 0) ? √(x) : zero(x), λᵣ))
W̃ = Ũ * transpose(Ũ)
m̃ = PBM(m.σ, W̃)

# Denoise
i = 2
x = X[:, i] .|> binarize
x̃ = addnoise(x, 10)
original_error = sum(Int.(x̃ .!= x))
# y, final_step = recur(100, x -> activate(m, x), x̃)
y, final_step = recur(100, x -> activate(m̃, x), x̃)
denoised_error = sum(Int.(y .!= x))
