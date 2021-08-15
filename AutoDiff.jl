function Babylonian(x; N = 10) 
    t = (1+x)/2
    for i = 2:N; t=(t + x/t)/2  end    
    t
end  

Babylonian(π), √π   # \pi + <tab> , and \sqrt + <tab> 

x=2; Babylonian(x),√x  # Type \sqrt+<tab> to get the symbol

using Plots
gr()

i = 0:.01:49

plot([x->Babylonian(x,N=i) for i=1:5],i,label=["Iteration $j" for i=1:1,j=1:5])

plot!(sqrt,i,c="black",label="sqrt",
      title = "Those Babylonians really knew how to √")

struct D <: Number  # D is a function-derivative pair
    f::Tuple{Float64,Float64}
end

import Base: +, /, convert, promote_rule
+(x::D, y::D) = D(x.f .+ y.f)
/(x::D, y::D) = D((x.f[1]/y.f[1], (y.f[1]*x.f[2] - x.f[1]*y.f[2])/y.f[1]^2))
convert(::Type{D}, x::Real) = D((x,zero(x)))
promote_rule(::Type{D}, ::Type{<:Number}) = D

x=2; Babylonian(D((x,1))),(√x,.5/√x)

i = .2:.01:49
plot([x->Babylonian(D((x,1.0)),N=i).f[2] for i=1:5],i)
plot!(x->.5/√x,i,c="black",label="d(sqrt(x))/dx",
    title = " Babylonians Differentiated")

# using Pkg; Pkg.add("SymPy")
using SymPy

symbols("x");

x = symbols("x")
display("Iterations as a function of x")
for k = 1:5
 display( simplify(Babylonian(x,N=k)))
end

display("Derivatives as a function of x")
for k = 1:5
 display(simplify(diff(simplify(Babylonian(x,N=k)),x)))
end

function dBabylonian(x; N = 10) 
    t = (1+x)/2
    t′ = 1/2
    for i = 1:N;  
        t = (t+x/t)/2; 
        t′= (t′+(t-x*t′)/t^2)/2; 
    end    
    t′
end  

x = π; dBabylonian(x), .5/√x

Babylonian(D((x,1)))

Base.show(io::IO,x::D) = print(io,x.f[1]," + ",x.f[2]," ϵ")

# Add the last two rules
import Base: -,*
-(x::D, y::D) = D(x.f .- y.f)
*(x::D, y::D) = D((x.f[1]*y.f[1], (x.f[2]*y.f[1] + x.f[1]*y.f[2])))

ϵ  = D((0,1))

@code_native(ϵ^2)

ϵ * ϵ

1/(1+ϵ)  # Exact power series:  1-ϵ+ϵ²-ϵ³-...

(1+ϵ)^10 ## Note this just works (we didn't teach Julia about exponentiation)!!

function nthroot(x, n=2; t=1, N = 10) 
    for i = 1:N;   t += (x/t^(n-1)-t)/n; end   
    t
end  

nthroot(2,3), ∛2 # take a cube root

nthroot(7,12), 7^(1/12)

x = 17.0
nthroot(x+ϵ,3), ∛x, 1/x^(2/3)/3

# using Pkg; Pkg.add("ForwardDiff")
using ForwardDiff

ForwardDiff.derivative(sqrt, 2)

ForwardDiff.derivative(Babylonian, 2)

@which ForwardDiff.derivative(sqrt, 2)

setprecision(3000)
round.(Float64.(log10.([Babylonian(BigFloat(2),N=k) for k=1:10] .- √BigFloat(2))); digits=3)

struct D1{T} <: Number  # D is a function-derivative pair
    f::Tuple{T,T}
end

z = D((2.0,1.0))
z1 = D1((BigFloat(2.0),BigFloat(1.0)))

import Base: +, /, convert, promote_rule
+(x::D1, y::D1) = D1(x.f .+ y.f)
/(x::D1, y::D1) = D1((x.f[1]/y.f[1], (y.f[1]*x.f[2] - x.f[1]*y.f[2])/y.f[1]^2))
convert(::Type{D1{T}}, x::Real) where {T} = D1((convert(T, x), zero(T)))
promote_rule(::Type{D1{T}}, ::Type{S}) where {T,S<:Number} = D1{promote_type(T,S)}

A = randn(3,3)

x = randn(3)

ForwardDiff.gradient(x->x'A*x,x)

(A+A')*x
