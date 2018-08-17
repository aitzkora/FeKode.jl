module FeKode
using LinearAlgebra
using SparseArrays
include("Mesh.jl")
include("IntegrationFormula.jl")
include("BasisFunction.jl")
include("Assembler.jl")
include("ReadMeshAscii.jl")
include("squareGenerate.jl") # FIXME fix naming conventions
end
