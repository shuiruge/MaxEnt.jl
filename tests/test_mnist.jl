include("../src/MaxEnt.jl")

using MLDatasets: MNIST
using Statistics: mean
using Random: shuffle


# Global parameters
const LATENT_SIZE = 64
const BATCH_SIZE = 128
const DTYPE = Float64


function preprocess_mnist(x)
    x = reshape(x, 28 * 28, size(x)[end])
    binarize(x)::DTYPE = x > 0.5 ? 1 : 0
    x = @. binarize(x)
    x = x[:, shuffle(1:end)]
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


function stats(x)
    mean(x), std(x)
end


# Load training data
train_x, _ = MNIST.traindata()
train_x = preprocess_mnist(train_x)
data = Flux.Data.DataLoader(train_x, batchsize=BATCH_SIZE, shuffle=false)
m = size(train_x, 1)

# Construct topology
# 1. connect ambient and latent units
topology = Connection[]
for i = 1:m
    for j = 1:LATENT_SIZE
        push!(topology, Connection(i, m+j))
    end
end
# 2. connect latent and latent units
# for i = 1:LATENT_SIZE
#     for j = 1:LATENT_SIZE
#         push!(topology, Connection(m+i, m+j))
#     end
# end
# 3. connect ambient and ambient units
# for i = 1:m
#     for j = 1:m
#         push!(topology, Connection(i, j))
#     end
# end
topology = Set(topology)

model = create_boltzmann(topology, train_x)
fantasy = DTYPE.(initialize_fantasy(model, BATCH_SIZE))
opt = Flux.Optimise.RMSProp()

function cb(step, real, fantasy, grads)
    m = ambientsize(model)
    real_ambient = real[1:m, :]
    real_latent = real[(m+1):end, :]
    fantasy_ambient = fantasy[1:m, :]
    fantasy_latent = fantasy[(m+1):end, :]

    @show step
    @show stats(reconstruction_error(model, real))
    @show stats((real_ambient))
    @show stats(mean(real_latent))
    @show stats(mean(fantasy_ambient))
    @show stats(mean(fantasy_latent))
    @show stats(mean(grads[1]))
    @show stats(mean(grads[2]))
    @show stats(mean(model.kernel))
    @show stats(mean(model.bias))
end


logger = Logger(model, 10; verbose=true)

fantasy, early_stopped = train!(model, fantasy, data, opt, 0; cb=logger)
@show early_stopped
