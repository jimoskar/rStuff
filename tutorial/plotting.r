
#Plotting basics

#df <- read.csv("~/Desktop/R/data/df.csv")
df <- read.csv("~/Github/rStuff/tutorial/data/df.csv")


str(df)
head(df)

plot(df$weight ~ df$height,
     ylim = c(30, 120), xlim = c(1.35, 2.10),
     ylab = "Weight (kg)", xlab = "Height (m)",
     main = "Weight and Height", sub = "xyPlot.R",
     cex.main = 1.5, cex.lab = 1.3, cex.sub = 0.5, cex.axis = 1.5,
     las = 1.5,
     pch = 20,
     bty = "l")


#Adding elements

points( df[df$gender =="f", c("height", "weight")], col = "red")
points( df[df$gender =="m", c("height", "weight")], col = "green")

legend("topleft", legend = c("women", "men"), fill = c("red", "green"))

abline(h = mean(df$weight[df$gender == "f"]), col = "red")
abline(h = mean(df$weight[df$gender == "m"]), col = "green")

abline(v = mean(df$height[df$gender == "f"]), col = "red")
abline(v = mean(df$height[df$gender == "m"]), col = "green")


out <-  lm(df$weight ~ df$height)
abline(out, lwd = 3)
r2 <- summary(out)$r.squared
text(x = 1.4, y = 85, paste("R2 = ", round(r2, 4)))


#Some more stuff

hist(df$weight)

plot(density(df$weight))

#together
hist(df$weight, prob = TRUE,  col = "lightblue", ann = FALSE)
lines(density(df$weight), col = "blue", lwd = 3)

#pairs(df, gap = 0)

#Barplot
agr <- aggregate(df$weight, list(df$district), mean)
barplot(agr$x, names.arg = agr$Group.1, main = "Mean Weight by District")

#Boxplots
boxplot(df$weight)
boxplot(df$weight ~ df$gender)

df$gender <- ordered(df$gender, c("m","f"))
boxplot(df$weight ~ df$gender)

boxplot(df$weight ~ df$district:df$gender)

boxplot(df$weight, xlab = "Weight (kg)",
        col = "orange", border = "brown",
        horizontal = TRUE, notch = TRUE)

b <- boxplot(df$weight, plot = FALSE)
b[c("stats","conf")]


#######################################################
# Skill Lesson:
# fine tuning plots 
#######################################################


df <- read.csv("df.csv")
str(df)

# First plot

dl <- split(df, df$district)

ylims <- c(40, 100)
xlims <- c(1.3, 2)

par(mfrow=c(2, 3))
lapply(dl, function(x) plot(x$weight~x$height, ylim=ylims, 
                            xlim=xlims, col=c("green", "red")[x$gender]))

par(oma=c(2,2,3,0), mar=c(2,2,1,1))
lapply(dl, function(x) plot(x$weight~x$height, ylim=ylims, 
                            xlim=xlims, col=c("green", "red")[x$gender]))

#Create an empty plot to put legend inside
plot(5, 5, 
     type="n", 
     axes=FALSE, 
     ann=FALSE, 
     xlim=c(0, 10), 
     ylim=c(0, 10))

text(5, 5, "Some explanation")
legend("topleft",
       legend=c("women","men"), 
       col=c("red","green"),
       pch=1,
       bty="n")
mtext(text="Height and weight in five districts", 
      side=3, outer=T, cex=2, adj=0)
mtext(text="Height (m)", side=1, outer=T, line=0.8)
mtext(text="Weight (kg)", side=2, outer=T, line=0.8)


graphics.off()
#
# Second Plot


plot(df$weight[df$bmi>25]~df$height[df$bmi>25])
points(df$weight[df$bmi<18]~df$height[df$bmi<18], col="blue") # Does not work because outside of plotting region

par(mai=c(.8,.8,.1,.1))
plot(y=1.6, x=70, type="n", xlim=xlims, ylim=ylims, axes=F,
     xlab='', ylab='')

points(df$weight ~ df$height, col="lightgray", pch=20)
points(df$weight[df$bmi>25]~df$height[df$bmi>25], xlim=xlims,
       ylim=ylims, col="red")
points(df$weight[df$bmi<18]~df$height[df$bmi<18], xlim=xlims,
       ylim=ylims, col="red")

axis(2, labels=c(40,60,80,100), at=c(40,60,80,100), 
     tick=FALSE, las=1)
axis(1, labels=c(1.4,1.6,1.8,2), at=c(1.4,1.6,1.8,2), 
     tick=FALSE)
box(bty="l")
mtext(text="Weight (kg)", side=2, line=2.3)
mtext(text="Height (kg)", side=1, line=2.5)

text(x=1.5, y=80, "Problematic BMIs are\n highlighted in red",
     cex=0.8)       
          
