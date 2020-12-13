# First R script where we load and analyze data
# 12/12-2020
# Jim Totland

# Clear R's brain to remove things that might have been loaded in your workspace and might interfere with the new analysis
rm(list=ls())

d.book <- read.csv("~/Desktop/R/data/book_prices.csv")

head(d.book)

tail(d.book)

names(d.book)

dim(d.book)

str(d.book)

plot(price ~ pages,data=d.book)


pdf("~/Desktop/R/plot.pdf")

plot(price ~ pages, data = d.book)
plot(pages ~ price, data = d.book)

dev.off()
