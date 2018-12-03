
BASE58_ALPHABET = b"123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"

function alt_base58encode(s::Union{Base.CodeUnits{UInt8,String},Array{UInt8,1}})
    prefix = []
    for c in s
        if c == 0
            push!(prefix, 0x31)
        else
            break
        end
    end
    num = parse(BigInt, bytes2hex(s), base=16)
    result = []
    while num > 0
        num, i = divrem(num, 58)
        pushfirst!(result, BASE58_ALPHABET[i+1])
    end
    return AbstractArray{UInt8,1}(cat(prefix, result; dims=1))
end

function alt_base58decode(a::AbstractArray{UInt8})
    result = ""
    i = 1
    while i <= length(a)
        result = string(result,Char(a[i]))
        i += 1
    end
    return result
end

# Takes bytes and turns it into base58 encoding with checksum
function alt_base58checkencode(h160::Union{Base.CodeUnits{UInt8,String},Array{UInt8,1}})
    checksum = sha256(sha256(h160))[1:4]
    base58bytes = alt_base58encode(cat(h160, checksum; dims=1))
    return alt_base58decode(base58bytes)
end
