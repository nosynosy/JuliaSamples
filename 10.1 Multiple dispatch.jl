struct Roman
    n::Int
end

Base.show(io::IO, r::Roman) = print(io, 'ⅰ' + (r.n - 1) % 10)  # nice display; 'ⅰ' is a Unicode Roman numeral

Roman(4)

typeof.([5 5.0 Roman(5) "Five" '5'  5//1])

x = [7 1 2 5 8 9]
Roman.(x)   # equivalent to map(Roman, x)  or  [Roman(w) for w in x]

Roman(4) + Roman(5)

import Base: +, *

+(a::Roman, b::Roman) = Roman(a.n + b.n)

Roman(4) + Roman(5)

methods(+)

import Base.*
*(i::Roman, j::Roman) = Roman(i.n * j.n)                     # Multiply like a Roman

Roman(3) * Roman(2)

Roman.(1:3) .* [Roman(1) Roman(2) Roman(3)]

Roman(3) * 2

# Complicated mytimes to decide what to do based on type
# not suggested, better way coming soon
function mytimes(i,j)
  if isa(i,Roman) & isa(j,Number)
        return  fill(1, i.n, j)   # i by j matrix with ones
    elseif    isa(i,Number) & isa(j,Roman) 
        return "😄"^(i*j.n)   #  i * j happy faces
    else
        return("I Don't know")
    end
end

mytimes(4,Roman(3)) # Twelve happys

mytimes(Roman(4),3) # 4x3 matrix with ones

*(i::Number, j::Roman) = "😄"^(i*j.n)        #  i * j happy faces

*(i::Roman, j::Number) = fill(1, i.n, j)       # i by j matrix

3 * Roman(3) # Nine happys

Roman(3) * 5  # Three by Five matrix of ones

t(x::Roman,y::Roman) = x.n * y.n

t(Roman(5),Roman(4))

# Notice how tight the assembler is!
@code_native t(Roman(2),Roman(4))

import Base: *, +, ^

*(α::Number,   g::Function) = x -> α * g(x)   # Scalar times function

*(f::Function, λ::Number)   = x -> f(λ * x)   # Scale the argument

*(f::Function, g::Function) = x -> f(g(x))    # Function composition  -- abuse of notation!  use \circ in Julia 0.6

^(f::Function, n::Integer) = n == 1 ? f : f*f^(n-1) # A naive exponentiation algorithm by recursive multiplication

+(f::Function, g::Function) = x -> f(x) + g(x)

pow(n) = x -> x^n

myexp = sum(1/factorial(big(n)) * pow(n) for n in 0:100)   # taylor series not efficient!

[myexp(1); exp(1); exp(big(1))]

f = x -> x^2
f(10)

g = 3f
g(10)

(f^2)(10)  # since we defined multiplication of functions as composition

using Plots;
gr()

x = pi*(0:0.001:4)

plot(x, sin.(x),    c="black", label="Fun")
plot!(x, (12*sin).(x),    c="green", label="Num * Fun")
plot!(x, (sin*12).(x),    c="red", alpha=0.9, label="Fun * Num")
plot!(x, (5*sin*exp).(x), c="blue", alpha=0.2, label="Num * Fun * Fun")

plot([12*sin, sin*12, 5*sin*exp], 0:.01:4π, α=[1 .9 .2], c=[:green :red :blue])

x=(0:.01:2) * pi;

plot(x, (sin^2).(x), c="blue")     # Squaring just works, y=sin(sin(x)), Gauss would be pleased!
plot!(x, sin.(x).^2,  c="red")         

h(a, b::Any) = "fallback"
h(a::Number, b::Number) = "a and b are both numbers"
h(a::Number, b) = "a is a number"
h(a, b::Number) = "b is a number"
h(a::Integer, b::Integer) = "a and b are both integers"

# Try playing with h
