using ImageTransformations


"""
Auxillary function of `preprocess`.
"""
function binarize(x)
    (x > 0.5) ? one(x) : zero(x)
end


function preprocess(X, imgsize; binary=true, dtype=Float64)
    X = imresize(X, imgsize)
    X = reshape(X, imgsize[1] * imgsize[2], size(X, 3))

    if binary
        X = map(binarize, X)
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


function filter_by_labels(X, y, labels)
    indices = filter(i -> y[i] ∈ labels, 1:size(y, 1))
    X̃ = cat([X[:, :, i] for i in indices]...; dims=3)
    ỹ = [y[i] for i in indices]
    X̃, ỹ
end
