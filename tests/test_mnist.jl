include("../src/MaxEnt.jl")

using MLDatasets: MNIST
using Statistics: mean


function preprocess_mnist(x)
    x = reshape(x, 28 * 28, size(x)[end])
    binarize(x)::Float64 = x > 0.5 ? 1 : 0
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


function test_mnist()
    latentsize = 64
    batchsize = 128

    train_x, _ = MNIST.traindata()
    train_x = preprocess_mnist(train_x)
    @show train_x[:, 1]
    data = Flux.Data.DataLoader(train_x, batchsize=batchsize)

    topology = Connection[]
    for i = 1:size(train_x, 1)
        for j = 1:latentsize
            push!(topology, Connection(i, j+size(train_x, 1)))
        end
    end
    topology = Set(topology)

    model = create_boltzmann(topology, train_x)
    fantasy::Array{Float64, 2} = initialize_fantasy(model, batchsize)
    cb = (_, real, _, _) -> @show reconstruction_error(model, real)
    fantasy, early_stopped = train!(model, fantasy, data, 1E-3, 1E-3; cb=cb)
    @show mean(fantasy)
    @show mean(fantasy[ambientsize(model)+1:end, :])
    @show early_stopped
end


test_mnist()
