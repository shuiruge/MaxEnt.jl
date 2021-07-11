include("../src/MaxEnt.jl")

using MLDatasets: MNIST
using Statistics: mean


# Global parameters
const LATENT_SIZE = 64
const BATCH_SIZE = 128
const DTYPE = Float64


function preprocess_mnist(x)
    x = reshape(x, 28 * 28, size(x)[end])
    binarize(x)::DTYPE = x > 0.5 ? 1 : 0
    @. binarize(x)
end


function reconstruction_error(model::BoltzmannMachine, real::AbstractArray{T, 2}) where T<:Real
    recon = bernoulli_argmax.(activate(model, real))

    N = 0
    nerror = 0
    for i = 1:size(real, 2)
        for j = 1:ambientsize(model)
            N += 1
            if recon[j, i] != real[j, i]
                nerror += 1
            end
        end
    end

    nerror / N
end


# Load training data
train_x, _ = MNIST.traindata()
train_x = preprocess_mnist(train_x)
data = Flux.Data.DataLoader(train_x, batchsize=BATCH_SIZE, shuffle=true)

# Construct topology
topology = Connection[]
for i = 1:size(train_x, 1)
    for j = 1:LATENT_SIZE
        push!(topology, Connection(i, j+size(train_x, 1)))
    end
end
topology = Set(topology)

model = create_boltzmann(topology, train_x)
fantasy = DTYPE.(initialize_fantasy(model, BATCH_SIZE))
opt = Flux.Optimise.ADAM()
cb = (_, real, _, _) -> @show reconstruction_error(model, real)

fantasy, early_stopped = train!(model, fantasy, data, opt, 1E-3; cb=cb)

@show mean(fantasy)
@show mean(fantasy[ambientsize(model)+1:end, :])
@show early_stopped
