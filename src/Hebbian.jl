include("MaxEnt.jl")


function hebbian_gradients(model::EnergyBasedModel, real)
    [-f(real) for f in getops(model)]
end


function hebbian_train!(model::BoltzmannMachine{T}, data, opt, tolerance; cb=nothing) where T<:Real
    params = getparams(model)
    early_stopped = false  # initialize.

    for (step, real_ambient) in enumerate(data)

        # Compute real state (particles)
        μ = getlatent(model, real_ambient)
        real_latent = bernoulli_sample(μ, model.minval, model.maxval)
        real = cat(real_ambient, real_latent; dims=1)

        # Compute gradients
        grads = hebbian_gradients(model, real)

        # Callback
        if cb !== nothing
            cb(step, real, grads)
        end

        # Optimize
        for (p, g) in zip(params, grads)
            Flux.update!(opt, p, g)
        end

        # If early stop
        if step > 1 && max(map(maxabs, grads)...) < tolerance
            early_stopped = true
            break
        end
    end

    early_stopped
end
