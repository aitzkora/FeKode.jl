using Test
using FeKode
using LinearAlgebra
using SparseArrays
rootDir = dirname(dirname(Base.functionloc(FeKode.eval)[1])) # fix with version 1.0
myTests = [ "Basis", "Integration", "Assemblers", "Meshes"]
@testset "FeKode" begin
    for t in myTests
        include("$(t).jl")
    end
end
