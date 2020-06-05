module TestTelegram
using Test

for file in sort([file for file in readdir(@__DIR__) if
                                   occursin(r"^test[_0-9]+.*\.jl$", file)])
    m = match(r"test([0-9]+)_(.*).jl", file)
    filename = String(m[2])
    testnum = string(parse(Int, m[1]))

    # with this test one can run only specific tests, for example
    # Pkg.test("Telegram", test_args = ["xxx"])
    # or
    # Pkg.test("Telegram", test_args = ["1"])
    if isempty(ARGS) || (filename in ARGS) || (testnum in ARGS) || (m[1] in ARGS)
        @testset "$filename" begin
            # Here you can optionally exclude some test files
            # VERSION < v"1.1" && file == "test_xxx.jl" && continue

            include(file)
        end
    end
end

end # module
