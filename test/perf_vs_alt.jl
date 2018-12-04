using BenchmarkTools
using Revise
using Base58
using Base64

function int2bytes(x::Integer)
    hex = string(x, base=16)
    if mod(length(hex), 2) != 0
        hex = string("0", hex)
    end
    return hex2bytes(hex)
end

for e ∈ [16,32,64,128,256,512,1024,2048,4096]

    SAMPLE_SIZE = 32

    encode_data = []
    while length(encode_data) < SAMPLE_SIZE
        push!(encode_data, int2bytes(rand(big.(1:big(2)^e))))
    end

    decode_data = []

    i = 1
    encode_avg = 0
    while i < length(encode_data)
        original = @elapsed base58encode(encode_data[i])
        alternative = @elapsed Base58.alt.base58encode(encode_data[i])
        push!(decode_data, alt.base58encode(encode_data[i]))
        encode_avg += original - alternative
        i += 1
    end
    println(length(encode_data[i]) * 8, " bits average encoding Δ: ", round(encode_avg / length(encode_data) * 10^6), " ns")

    i = 1
    decode_avg = 0
    while i < length(decode_data)
        original = @elapsed base58decode(decode_data[i])
        alternative = @elapsed Base58.alt.base58decode(decode_data[i])
        decode_avg += original - alternative
        i += 1
    end
    println(length(encode_data[i]) * 8, " bits average decoding Δ: ", round(decode_avg / length(decode_data) * 10^6), " ns")

end
