# FeKode
 This project is aiming to develop a very basic Finite Elements simulator.
## Assembler
 Currently we simulate only static problems involving stiffness and mass matrices, for example
 we can try to solve $$ \Delta u = f$$ avec $ f = -6y(1-y)+2x^3 $ en utilisant les conditions de dirichlet au bord
```julia
using FeKode, LinearAlgebra, Test
N = 10
m = FeKode.meshGenerate2D(0.,1., 0. , 1., N, N)
boundary =  m.isOnBoundary;
fe = FeKode.P1Basis(2)
#retrieve stiffness and mass matrices
K, M = FeKode.stiffnesAndMassMatrix(m, 2, 2, fe)
x = m.points[:, 1]
y = m.points[:, 2]
u = y.*(1 .- y).*x.^3
f = -6*x.*y.*(1 .-y)+2*x.^3
F = M * f

## substract boundary contribution to the rhs
F -= K[:, boundary] * u[boundary]
F[boundary] = u[boundary]


##suppress rows and columns from the K matrix
Kn = FeKode.removeRowsAndColsAndPutOnes(K, boundary)

## check that the error is less than h^2
sol=Kn\F
@test norm(sol-u) ≈ 0. atol=1e-2
N = 10
m = FeKode.meshGenerate2D(0.,1., 0. , 1., N, N)
boundary =  m.isOnBoundary;
fe = FeKode.P1Basis(2)
K, M = FeKode.stiffnesAndMassMatrix(m, 2, 2, fe)
x = m.points[:, 1]
y = m.points[:, 2]
u = y.*(1 .- y).*x.^3
f = -6*x.*y.*(1 .-y)+2*x.^3
F = M * f

## substract boundary contribution to the rhs
F -= K[:, boundary] * u[boundary]
F[boundary] = u[boundary]

##suppress rows and columns from the K matrix
Kn = FeKode.removeRowsAndColsAndPutOnes(K, boundary)

# check that the error is less than h^2
sol=Kn\F
@test norm(sol-u) ≈ 0. atol=1e-2
```
to view the solution, one could use *surf* from PyPlot package
``` julia
using PyPlot
XX=reshape(x, N, N)
YY=reshape(y, N, N)
ZZ=reshape(sol, N, N)
surf(XX,YY,ZZ)
```
who gives
![example][sol10.svg]

## Limitations
 - Code not optimized
 - we do not support any kind of parallelism (distributed or Shared)
 - lack for time integrator scheme
