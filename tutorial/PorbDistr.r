###Probability Distributions

library(ggplot2)


######################################
### Normal distribution
######################################

?dnorm()
dnorm(0,0,1)
dnorm(0)

dnorm(0.5,1,sqrt(2))
pnorm(0.1,1,0.5)
qnorm(0.975,0,1)



### A graphical example

mu = -1
sigma = 1.5

# Generate a vector with values from -6 to 4 in 0.1 intervals
xx <- seq(-6,4,0.1)

# Store the density of the normal distribution with given mu and sigma for all values in xx
n.dens = dnorm(xx, mu, sigma)

# Plotting

# With base R
plot(xx,n.dens,type="l",xlab="x",ylab="density")

# With ggplot
df = data.frame(x = xx, y=n.dens)

ggplot(data = df, aes(x = x, y = y)) +
  geom_bar(stat = "identity") +
  theme_minimal()


### Drawing a random sample and making a histogram

aa <- rnorm(1000,2,2)

# Base R
hist(aa)

# Or using ggplot
aa <- as.data.frame(aa)

ggplot(data = aa, aes(aa)) + 
  geom_histogram(bins=25) +
  theme_minimal()


######################################
### Binomial distribution
######################################

dbinom(5,10,0.2)
pbinom(5,10,0.2)
qbinom(0.9,10,0.2)

n = 10
p = 0.2
probs = dbinom(0:10, n, p)
df = data.frame(x = 0:10, y = probs)

plot(0:10,dbinom(0:10,n,p),type="h")

ggplot(data = df, aes(x = x, y = y)) + 
  geom_bar(stat = "identity") +
  theme_minimal()

## Drawing a random sample and making a histogram
aa <- rbinom(1000,10,0.3)

# Base R
hist(aa)

# Or using ggplot
aa <- as.data.frame(aa)

ggplot(data = aa, aes(aa)) + 
  geom_histogram(binwidth = 1) +
  theme_minimal()

#Q&A
qnorm(0.025,3,1)
qnorm(0.975,3,1)
pnorm(4,2,sqrt(3),lower.tail = F)

n = 5
p = 0.25
dbinom(1, n ,p)
pbinom(1, n, p, lower.tail = F)
