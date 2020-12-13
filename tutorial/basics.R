#######################################################
# This is the R script for the "The basics of using R" (Part 2, vectors, logical operators and matrices) 
# Introduction into R programming
#######################################################

##################################################
### Vectors
##################################################

x = c(1, 2, 3)
typeof(x)
y = c("a", "b", "c")
typeof(y)
u = c("1", "2", "3")
typeof(u)
v = as.numeric(u)
typeof(v)
z = c("red", 1, "yellow", 2)
typeof(z)

#################################################
x <- 1:5

x[2]
x[2] = 10
x

x[3:4] = 0
x

x[-2] = 1
x

x[c(1, 4)] = 4

################################################
x = 1:5
y = 2
z = 11:15

5 * x
x + z
x/z
x*z

# However, notice what happens when the length of your vectors is not the same:
x - y
x*y

#################################################
x <- 1:5

y <- 6:10

a = t(x) %*% y 


# More operations and functions
y = log(x)
z = exp(y)

min(x)
max(x)
sum(x)
mean(x)
var(x)
length(x)
sort(x)
order(x)
sort(x) == x[order(x)]

?order()

##################################################
### Logical operators
##################################################


# generate a factor of factor variables
gender = factor(c("male", "female", "female", "male"))

# Look at it and make a summary table
gender
table(gender)

# Figure out what the following commands do:
gender == "male"
sum(gender == "male")


# Some simple exercise that involve logical operators. Work through them and try to understad what happens:

x = 1:5
x = seq(1, 5, length = 5)
x = c(1, 2, 3, 4, 5)
x > 4
x[x > 4] = 10

2 %in% x
6 %in% x


##################################################
### Matrices
##################################################

# Generating simple matrices

A = matrix(1:6, nrow = 3, ncol = 2)
A

B = matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)
B

# The functions cbind() (column bind) and rbind() (row bind) can also be used to create matrices:
x1 = 1:3
x2 = c(7, 6, 6)
x3 = c(12, 19, 21)

# Bind vectors x1, x2, and x3 column-wise into a matrix
C = cbind(x1, x2, x3) # Bind vectors x1, x2, and x3 column-wise into a matrix
C

# Bind vectors x1, x2, and x3 row-wise into a matrix.
D = rbind(x1, x2, x3) # Bind vectors x1, x2, and x3 row-wise into a matrix.
D

# Matrix multiplication
# Matrices can either be multiplied component-wise (*) or using matrix multiplication with the %*% symbol:

# Some examples of matrix multiplication; t() generates the transposed of a matrix.
A %*% B 
A * t(B)
A %*% t(A)

# We can also take exponents of matrices, but note that this is the component-wise multiplication in R!
A^2

# As just mentioned, matrices cannot be multiplied if their dimensions don't fit. And remember that component-wise and matrix multiplication have different requirements...
#A %*% t(B)
A*B


# Here are some other useful  matrix commands

dim(A) # get the dimensions of a matrix
nrow(A) # number of rows
ncol(A) # number of columns
apply(A, 1, sum) # apply the sum function to the rows of A
apply(A, 2, sum) # apply the sum function to the columns of A
sum(diag(A)) # trace of A

A = diag(1:3) # a 3 by 3 diagonal matrix with entries 1, 2, 3
solve(A) # inverse of A, in general solve(A,b) solves Ax=b wrt x
det(A) # determinant of A

#Testing

A <- rbind(c(0, -1, 2), c(1, 3, 1))

B <-  rbind(c(-1, 2, 3),c(1, 2, 1))

C <-  cbind(c(4, 1), c(2, -3))

x <- c(-1, 2, 1)
y <- c(2, 3, 0)

x %*% y
solve(C)
solve(A %*% t(B))
#solve(A %*% B)

z <- seq(0,100,2)
sum(z >= 80)