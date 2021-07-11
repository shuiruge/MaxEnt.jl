include("../src/MaxEnt.jl")


function test_basic()
    topology = Set([Connection(1, 2), Connection(2, 3)])
    data = rand(Float64, (2, 5))
    model = create_boltzmann(topology, data)
    state = cat(data, rand(eltype(data), latentsize(model), batchsize(data)), dims=1)
    @show activate(model, state)
    @show gradients(model, state, state)
end

test_basic()