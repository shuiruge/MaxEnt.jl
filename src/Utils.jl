using Flux


function rank(x::AbstractArray)
    length(size(x))
end


function unsqueeze(x, dims)
    for dim in sort(dims)
        x = Flux.unsqueeze(x, dim)
    end
    x
end


"""
Outer product along the first and the second dimensions of `x` and `y`, respectively.
"""
function outer(x, y)
    unsqueeze(x, [1]) .* unsqueeze(x, [2])

end


function squeeze(x)
    newsize = filter(n -> n > 1, size(x))
    reshape(x, newsize...)
end


function sum_(x; dims)
    sum(x; dims) |> squeeze
end


"""
Assume that the last dimension is the data batch dimension.
"""
function expect(x::AbstractArray)
    last_dim = rank(x)
    Flux.mean(x, dims=last_dim) |> squeeze
end


"""
Inverse function of sigmoid.
"""
function invσ(x)
    log(x) - log(1-x)
end


function flatten(x)
    reshape(x, prod(size(x)))
end


function L∞(x)
    max(abs.(x)...)
end