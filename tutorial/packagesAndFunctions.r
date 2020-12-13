library(ISLR)
library(MASS)
library(ggplot2)


#Functions

mySumPlot <- function(x,y){
  plot(log(y) ~ x)
  a <- x^2 + y^2
  return(a)
}

x <- 1:100
y <- 1:100

mySumPlot(x,y)
