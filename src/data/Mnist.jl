using ImageTransformations


"""
Auxillary function of `preprocess`.
"""
function binarize(x)
    (x > 0.5) ? one(x) : zero(x)
end


"""
Auxillary function of `preprocess`.
"""
function smooth(x, δ)
    if x < δ
        δ
    elseif x > 1 - δ
        1 - δ
    else
        x
    end
end


function preprocess(X, imgsize; δ=0., binary=true, dtype=Float64)
    X = imresize(X, imgsize)
    X = reshape(X, imgsize[1] * imgsize[2], size(X, 3))

    if binary
        X = map(binarize, X)
    end

    if δ > 0
        X = map(x -> smooth(x, δ), X)
    end

    dtype.(X)
end


const Datum = AbstractVector{T} where T<:Real
const Data = AbstractMatrix{T} where T<:Real


"""
Randomly flip `bits` bits on the binary datum `binary`.
"""
function addnoise(binary::Datum, bits::Integer)
    indices = 1:size(binary, 1)
    random_indices = rand(indices, bits)

    function flip(index)
        if (index ∈ random_indices)
            1 - binary[index]
        else
            binary[index]
        end
    end

    map(flip, indices)
end
