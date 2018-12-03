using BenchmarkTools
using Revise
using Base58
using Base64

test_data = hcat(
    [b"",                b""],
    [[0x00],             b"1"],
    [[0x00, 0x00],       b"11"],
    [b"hello world",     b"StV1DL6CwTryKyV"],
    [b"\0\0hello world", b"11StV1DL6CwTryKyV"],
    [nothing,            b"3vQOB7B6uFg4oH"],
    [b""" !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~""",
                         b"3WSNuyEGf19K7EdeCmokbtTAXJwJUdvg8QXxAacYC7kR1bQoYeWVr5iMUHvxvv4FCFY48dVUrX6BrFLod6zsEhHU9NciUXFM17h1qtveYD7ocbnXQyuY84An9nAvEjdt6H"]
);

println("Original implemetation")
println("decode")
@btime base58decode([b"   11111"..., test_data[2, 7]...]) |> String
@btime base58decode(b"     ")
println("encode")
@btime base58encode(test_data[1, 4]);
@btime base58encode(test_data[1, 7]);
@btime base58encode($(test_data[1, 7]));
println("decode")
@btime base58decode($(test_data[2, 7]));
println("encode")
# @btime base58encode($(test_data[1, 1]));
@btime base58encode($(test_data[1, 2]));
@btime base58encode($(test_data[1, 3]));
@btime base58encode($(test_data[1, 4]));
@btime base58encode($(test_data[1, 5]));
@btime base58encode($(test_data[1, 7]));

println("Alternative implemetation")
println("decode")
@btime alt_base58decode([b"   11111"..., test_data[2, 7]...]) |> String
@btime alt_base58decode(b"     ")
println("encode")
@btime alt_base58encode(test_data[1, 4]);
@btime alt_base58encode(test_data[1, 7]);
@btime alt_base58encode($(test_data[1, 7]));
println("decode")
@btime alt_base58decode($(test_data[2, 7]));
println("encode")
# @btime alt_base58encode($(test_data[1, 1]));
@btime alt_base58encode($(test_data[1, 2]));
@btime alt_base58encode($(test_data[1, 3]));
@btime alt_base58encode($(test_data[1, 4]));
@btime alt_base58encode($(test_data[1, 5]));
@btime alt_base58encode($(test_data[1, 7]));
