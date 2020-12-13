


d.bodyfat <- read.csv("~/Desktop/R/data/bodyfat.csv")

###############################################################
# This is the R script for the part 6.2
# Introduction into R programming, Linear regression models
###############################################################

library(ggplot2)
library(ggfortify)

d.bodyfat <- read.csv("~/Desktop/R/data/bodyfat.csv")
str(d.bodyfat)

# Overlook
pairs(d.bodyfat)

# Specific plot of bodyfat against bmi
ggplot(d.bodyfat,aes(x=bmi,y=bodyfat)) + 
  geom_point() +
  ylab("body fat (%)") +
  theme_bw()

plot(bodyfat ~ age, data=d.bodyfat)


## Simple linear regression
r.m1 <- lm(bodyfat ~ bmi, data=d.bodyfat)
summary(r.m1)

plot(r.m1)
autoplot(r.m1)


## Multiple linear regression
r.m2 <- lm(bodyfat ~ bmi + age, data=d.bodyfat)

summary(r.m2)
autoplot(r.m2)  


## Using all variables in a dataset
r.m3 <- lm(bodyfat ~ ., data=d.bodyfat)

summary(r.m3)
autoplot(r.m3)


summary(lm(bodyfat ~ abdomen + age, data=d.bodyfat))

summary(lm(bodyfat ~ abdomen * age, data=d.bodyfat))

