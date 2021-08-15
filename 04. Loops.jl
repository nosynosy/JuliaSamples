n = 0
while n < 10
    n += 1
    println(n)
end
n

myfriends = ["Ted", "Robyn", "Barney", "Lily", "Marshall"]

i = 1
while i <= length(myfriends)
    friend = myfriends[i]
    println("Hi $friend, it's great to see you!")
    i += 1
end

for n in 1:10
    println(n)
end

myfriends = ["Ted", "Robyn", "Barney", "Lily", "Marshall"]

for friend in myfriends
    println("Hi $friend, it's great to see you!")
end

m, n = 5, 5
A = fill(0, (m, n))

for j in 1:n
    for i in 1:m
        A[i, j] = i + j
    end
end
A

B = fill(0, (m, n))

for j in 1:n, i in 1:m
    B[i, j] = i + j
end
B

C = [i + j for i in 1:m, j in 1:n]





@assert squares[10] == 100
@assert squares[11] == 121



@assert length(squares_arr) == 100
@assert sum(squares_arr) == 338350
