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
W_diag = one.(diag(Ĉ))
m = PBM(x̂, Ĉ, W_diag)

# Analysis
λ, U = eigen(m.W)
λᵣ = @. real(λ)
λᵢ = @. imag(λ)
L∞(λᵢ)
histogram(λᵣ; bins=100, title="Real part of λ")

# Denoise
i = 1
x = X[:, i] .|> binarize
x̃ = addnoise(x, 10)
original_error = sum(Int.(x̃ != x))
y, final_step = recur(100, x -> activate(m, x), x̃)
denoised_error = sum(Int.(y != x))
