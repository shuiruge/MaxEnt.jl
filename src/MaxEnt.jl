### A Pluto.jl notebook ###
# v0.14.5

using Markdown
using InteractiveUtils

# ╔═╡ 7f463268-5e7c-408e-b3cb-37a0a2d05c01
using Statistics: mean

# ╔═╡ 24a84d1d-a463-4928-9c45-6f77878d606f
using SparseArrays: spzeros, AbstractSparseMatrix

# ╔═╡ 1de29404-a68b-445a-b914-3ac51acec0c8
using Flux

# ╔═╡ 71f7324d-5c3c-4b2f-865b-34366ab62299
@doc raw"""
An energy-based model shall implements the following methods:

1. `getparams(model)`: returns the parameters of the model.
1. `getops(model)`: returns the operators {x → ∂E/∂θ(x) | θ ∈ params}.
1. `activate(model, x)`: the activity rule, i.e. $p(x_α | x_{-α})$ for ∀ α.
"""
abstract type EnergyBasedModel end

# ╔═╡ 62b71d25-2326-4dd0-87b1-24bd4c50710b
"""
Expectation along the first array dimension.
"""
function expect(xs::AbstractArray)
	dropdims(mean(xs, dims=1); dims=1)
end

# ╔═╡ 6734347d-db99-4f96-b340-e06b50f21e56
"""
Outer-product of two arrays.
"""
function outer(x::AbstractArray, y::AbstractArray)
	x2 = reshape(x, first(size(x), ndims(x)-1)..., 1, last(size(x)))
	y2 = reshape(y, size(y)..., 1)
	x2 .* y2
end

# ╔═╡ eae1a7b8-0473-4136-9dff-17e2136ab06e
"""
A connection between the `i`-th node and the `j`-th node.

A set of connections describes the topology of the network.
"""
struct Connection
	i::Integer
	j::Integer
end

# ╔═╡ aad77e21-c8a6-4b63-8191-8029d2c32cdc
"""
Collects all the node indices appeared in the network topology.
"""
function collectnodes(topology::Set{Connection})::Set{Integer}
	nodes = Set()
	for conn in topology
		push!(nodes, conn.i)
		push!(nodes, conn.j)
	end
	nodes
end

# ╔═╡ 9d52124e-1897-41f2-b7f6-8a9de28dc319
"""
# Arguments
* `kernel` is a sparse N×N matrix, where N is the total number of nodes.
* `bias` is a dense 1×N matrix.
* `ambientsize` ≤ N.

# Convention
* The node index starts from ambient nodes, and ends with latent nodes.
"""
mutable struct BoltzmannMachine <: EnergyBasedModel
	kernel
	bias
	ambientsize
end

# ╔═╡ 7a704319-7652-464f-b5f3-da172da889a5
"""
Counts how many nodes in the model.
"""
function Base.size(model::BoltzmannMachine)
	size(model.bias)[1]
end

# ╔═╡ e65fc571-a88a-4dc5-9d76-d3d3c58fe34f
function ambientsize(model::BoltzmannMachine)
	model.ambientsize
end

# ╔═╡ 21b7b47a-3271-40cb-a106-24f8384d0dd9
function latentsize(model::BoltzmannMachine)
	size(model) - ambientsize(model)
end

# ╔═╡ 017e1e63-287f-4ae0-b314-f83612202f25
"""
Reutrns a tuple of

1. x → ∂E/∂W(x), where W is the kernel;
1. x → ∂E/∂b(x), where b is the bias.
"""
function getops(model::BoltzmannMachine)
	kernel_op = x -> outer(x, x)
	bias_op = x -> x
	(kernel_op, bias_op)
end

# ╔═╡ 75b123cc-7232-4d45-a475-90798b2d8cdd
@doc raw"""
For ∀ distribution $q(x)$, calculate the
```math
	
	\left\{ \frac{∂L}{∂θ^{α}}(θ; q): α = 1, \ldots \right\}

```
of the energy-based model $p(x; θ)$, where

```math

	L(θ; q) := \mathbb{E}_{x ∼ q} \left[ -\ln p(x; θ) \right].

```

# Arguments
* `real` is the real world data, obeying the $q(x)$ distribution.
* `fantasy` is the data imagined by the model, obeying the $p(x;θ)$
  distribution.

# Returns
A tuple of gradients, one-to-one correspondent to the parameters
obtained by calling `getparams(model)`.
"""
function gradients(
		model::EnergyBasedModel,
		real::AbstractArray{T, N},
		fantasy::AbstractArray{T, N},
		) where {T, N}
	
	function gradient(f)
		expect(f(fantasy)) - expect(f(real))
	end

	[gradient(f) for f in getops(model)]
end

# ╔═╡ c8ccc8e8-94a1-44f0-af35-635b99085006
function getparams(model::BoltzmannMachine)
	(model.kernel, model.bias)
end

# ╔═╡ d8550489-c8be-418f-8db3-3753334f7530
"""
Returns 0 or 1 based on Bernoulli probability `p`.
"""
function bernoulli_sample(p::Number)
	if rand(typeof(p)) < p
		x = 1
	else
		x = 0
	end
	x
end

# ╔═╡ 07a3f217-d881-4c1b-bb80-fa62c722c961
"""
Returns the value that maximizes the Bernoulli probability P(x).
"""
function bernoulli_argmax(p::Number)
	if p > 0.5
		x = 1
	else
		x = 0
	end
	x
end

# ╔═╡ 0f33ba86-d982-4863-b02e-b280370e9bee
"""
Multi-step contrastive divergence.
"""
function contrastive_divergence(model::BoltzmannMachine, x, step)
	for _ = 1:step
		x = contrastive_divergence(model, x)
	end
	x
end

# ╔═╡ 7bb553a2-4b82-4b68-b33b-4b751509952f
function ambient_latent_kernel(model::BoltzmannMachine)
	m = ambientsize(model)
	n = size(model)
	model.kernel[1:m, (m+1):n]
end

# ╔═╡ 867a468e-7876-4b48-b0ab-023202b57792
function latent_latent_kernel(model::BoltzmannMachine)
	m = ambientsize(model)
	n = size(model)
	model.kernel[(m+1):n, (m+1):n]
end

# ╔═╡ fdb76bc3-6d9e-408c-bc1e-fc1e1d710f65
function latent_bias(model::BoltzmannMachine)
	n = ambientsize(model)
	model.bias[(n+1):size(model)]
end

# ╔═╡ fae512b2-004e-4174-9948-f82d07d1e334
function meanabs(x)
	mean(abs(x))
end

# ╔═╡ 25dbd0ab-fab8-47d5-9f58-4c2e8268dd6a
"""
Calculate latent nodes by mean-field approximation.

Returns the μ and the final step.
"""
function getlatent(model::BoltzmannMachine, ambient,
			       maxstep::Integer, tolerance::Real)
	v = ambient
	W = ambient_latent_kernel(model)
	J = latent_latent_kernel(model)
	b = latent_bias(model)
	
	# Add dimension for convienent broadcasting
	b = reshape(b, 1, size(b)...)

	# Initialize μ
	batchsize = first(size(ambient))
	μ = rand(eltype(ambient), batchsize, latentsize(model))

	step = 0
	for _ = 1:maxstep
		# Starts a new step
		step += 1

		# Compute the next iteration for μ
		μ2 = Flux.σ.(v * W .+ μ * J .+ b)

		# Stop condition
		if meanabs(μ2 .- μ) < tolerance
			break
		end
		
		# Update μ by the new one.
		μ = μ2
	end

	μ, step
end

# ╔═╡ 9b2db7fe-15ab-41f8-a1ee-4986688df64b
"""
Short version of `getlatent(model, ambient, maxstep, tolerance)`.

Returns the μ only.
"""
function getlatent(model::BoltzmannMachine, ambient)
	μ, _ = getlatent(model::BoltzmannMachine, ambient, 10, 1E-3)
	μ
end

# ╔═╡ c18df662-e0f6-46cd-9589-56d055bc777f
"""
Hinton's initialization strategy for the ambient bias of Boltzmann machine.
"""
function hinton_initialize(data)
	p = expect(data)
	ϵ = eps(eltype(data))
	@. log(p + ϵ) - log(1 - p + ϵ)
end

# ╔═╡ 2bbf883e-c78b-4c02-bad3-8392c0b13685
function initialize_boltzmann(topology::Set{Connection}, data)
	N = length(collectnodes(topology))
	dtype = eltype(data)

	# Initialize kernel
	kernel = spzeros(dtype, N, N)

	# Compute latent size
	ambientsize = last(size(data))
	latentsize = N - ambientsize

	# Initialize bias
	ambientbias = hinton_initialize(data)
	latentbias = zeros(dtype, latentsize)
	bias = cat(ambientbias, latentbias, dims=1)

	BoltzmannMachine(kernel, bias, ambientsize)
end

# ╔═╡ c5c0b140-9a9f-4b99-9497-4a6467a1632c
@doc raw"""
Activity rule of Boltzmann machine. That is,

$$p(x_α = 1 | x_{-α}), ∀ α.$$

"""
function activate(model::BoltzmannMachine, x)
	# Abbreviations
	W, b = model.kernel, model.bias

	# Add dimension for convienent broadcasting
	b = reshape(b, 1, size(b)...)

	Flux.σ.(x * W .+ b)
end

# ╔═╡ a0cc06a4-6627-4d1f-8be5-7d3bf36c8390
"""
Activity rule of Boltzmann machine.
"""
function activate(model::BoltzmannMachine, ambient, latent)
	state = cat(ambient, latent, dims=2)
	activate(model, state)
end

# ╔═╡ 5a1ebf7c-1820-4402-9365-986a84515413
"""
One-step contrastive divergence.
"""
function contrastive_divergence(model::BoltzmannMachine, x)
	p = activate(model, x)
	@. bernoulli_sample(p)
end

# ╔═╡ 1e9f6ef7-5727-4601-9c44-16430de22631


# ╔═╡ 42444b2a-c149-4242-853e-94649a9db2d7


# ╔═╡ 0bbfad44-4813-49b1-bafb-26e4ca9ba57f


# ╔═╡ 31c9f954-9e7c-4349-a270-abd8f6052f5c
topology = Set([Connection(1, 2), Connection(2, 3)])

# ╔═╡ 03aa03f3-8028-46ca-8be4-9c3b67f3ef62
data = rand(Float64, (5, 2))

# ╔═╡ a80696d2-2ab1-4369-b5a8-cd9abc2e02c2
model = initialize_boltzmann(topology, data)

# ╔═╡ 8b13cdbf-51c4-40b4-8a8b-2da878b60c4c
state = cat(data, rand(eltype(data), first(size(data)), latentsize(model)), dims=2)

# ╔═╡ fdc470e0-c6a8-4daf-a99d-c02d0bc0c3b3
activate(model, state)

# ╔═╡ a72ac95e-bb98-4383-86a4-93f1f7b01159
gradients(model, state, state)

# ╔═╡ Cell order:
# ╠═7f463268-5e7c-408e-b3cb-37a0a2d05c01
# ╠═24a84d1d-a463-4928-9c45-6f77878d606f
# ╠═1de29404-a68b-445a-b914-3ac51acec0c8
# ╠═71f7324d-5c3c-4b2f-865b-34366ab62299
# ╠═62b71d25-2326-4dd0-87b1-24bd4c50710b
# ╠═6734347d-db99-4f96-b340-e06b50f21e56
# ╠═75b123cc-7232-4d45-a475-90798b2d8cdd
# ╠═eae1a7b8-0473-4136-9dff-17e2136ab06e
# ╠═aad77e21-c8a6-4b63-8191-8029d2c32cdc
# ╠═9d52124e-1897-41f2-b7f6-8a9de28dc319
# ╠═7a704319-7652-464f-b5f3-da172da889a5
# ╠═e65fc571-a88a-4dc5-9d76-d3d3c58fe34f
# ╠═21b7b47a-3271-40cb-a106-24f8384d0dd9
# ╠═017e1e63-287f-4ae0-b314-f83612202f25
# ╠═c8ccc8e8-94a1-44f0-af35-635b99085006
# ╠═d8550489-c8be-418f-8db3-3753334f7530
# ╠═07a3f217-d881-4c1b-bb80-fa62c722c961
# ╠═5a1ebf7c-1820-4402-9365-986a84515413
# ╠═0f33ba86-d982-4863-b02e-b280370e9bee
# ╠═7bb553a2-4b82-4b68-b33b-4b751509952f
# ╠═867a468e-7876-4b48-b0ab-023202b57792
# ╠═fdb76bc3-6d9e-408c-bc1e-fc1e1d710f65
# ╠═fae512b2-004e-4174-9948-f82d07d1e334
# ╠═25dbd0ab-fab8-47d5-9f58-4c2e8268dd6a
# ╠═9b2db7fe-15ab-41f8-a1ee-4986688df64b
# ╠═c18df662-e0f6-46cd-9589-56d055bc777f
# ╠═2bbf883e-c78b-4c02-bad3-8392c0b13685
# ╠═c5c0b140-9a9f-4b99-9497-4a6467a1632c
# ╠═a0cc06a4-6627-4d1f-8be5-7d3bf36c8390
# ╠═1e9f6ef7-5727-4601-9c44-16430de22631
# ╠═42444b2a-c149-4242-853e-94649a9db2d7
# ╠═0bbfad44-4813-49b1-bafb-26e4ca9ba57f
# ╠═31c9f954-9e7c-4349-a270-abd8f6052f5c
# ╠═03aa03f3-8028-46ca-8be4-9c3b67f3ef62
# ╠═a80696d2-2ab1-4369-b5a8-cd9abc2e02c2
# ╠═8b13cdbf-51c4-40b4-8a8b-2da878b60c4c
# ╠═fdc470e0-c6a8-4daf-a99d-c02d0bc0c3b3
# ╠═a72ac95e-bb98-4383-86a4-93f1f7b01159
