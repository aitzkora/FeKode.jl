"""
generate a plane mesh for the square [xMin, xMax] x [ yMin, yMax] with nX x nY points
beware that cells indexing begins to 1 (for julia, not zero (vtk))
"""
function meshGenerate2D(xMin::Float64, xMax::Float64, yMin::Float64, yMax::Float64, nX::Int, nY::Int)
   x=LinRange(xMin, xMax, nX)
   y=LinRange(yMin, yMax, nY)
   points = hcat([[i,j,0.] for i in x for j in y]...)'
   cells = vcat([vcat([(i-1)*nX+j (i-1)*nX+j+1 i*nX+j+1],[(i-1)*nX+j i*nX+j+1 i*nX+j]) for i=1:nX-1 for j=1:nY-1]...)
   ε=1e-20
   isBoundary = (x,y,z) -> abs(x-xMin)<ε || abs(x-xMax) <ε || abs(y-yMin) < ε || abs(y-yMax) < ε
   boundary=filter(x->isBoundary(points[x,:]...), 1:size(points,1))
   return Mesh(points ,[cells[i,:] for i=1:size(cells,1)], boundary)
end
"""
generate a line mesh for the segment [xMin, xMax] with nX points
beware that cells indexing begins to 1 (for julia, not zero (vtk))
"""
function meshGenerate1D(xMin::Float64, xMax::Float64, nX::Int)
   x=LinRange(xMin, xMax, nX)
   points = hcat([[i, 0, 0. ] for i in x]...)'
   cells = vcat([vcat([i i+1]) for i=1:nX-1]...)
   ε=1e-20
   isBoundary = (x,y,z) -> abs(x-xMin)<ε || abs(x-xMax) <ε
   boundary=filter(x->isBoundary(points[x,:]...), 1:size(points,1))
   return Mesh(points ,[cells[i,:] for i=1:size(cells,1)], boundary)
end
