#######################################################
# Plotting with ggplot2
# X-Y plot and other basics
#######################################################

# Before using ggplot2 the first time, install it, plus some other packages we need here
# install.packages("ggplot2")]
install.packages("car")
install.packages("GGally")

library(ggplot2)
library(car)


df <- read.csv("~/Github/rStuff/tutorial/data/df.csv")

plot(df$weight ~ df$height,
     ylab="Weight (kg)", xlab="Height (m)")

plot(weight ~ height, data=df, ylab="Weight (kg)", xlab="Height (m)")

ggplot(df, aes(x=height,y=weight)) +
  geom_point()

ggplot(df, aes(x=height,y=weight, colour = gender)) + 
  geom_point(size=2) + 
  xlab("Height(m)") + 
  ylab("Weight (kg)") +
  theme_bw()

#######################################################
# Different plot types
#######################################################

### Scatterplots

?SLID
# We only use rows without missing values
SLID = na.omit(SLID)

ggplot(SLID, aes(education, wages)) + 
  geom_point() +
  labs(title = "Scatterplot") +
  xlab("Education") +
  ylab("Wages") +
  theme_bw() +
  facet_wrap(~language)

ggplot(SLID, aes(education, wages)) + 
  geom_point() +
  labs(title = "Scatterplot") +
  xlab("Education") +
  ylab("Wages") +
  theme_bw() +
  facet_wrap(~language + sex) +
  theme_minimal()

### Histograms and density plots

# The standard histogram with counts on the y-axis
ggplot(SLID, aes(wages)) + 
  geom_histogram(binwidth = 2) + 
  labs(title = "Histogram") +
  xlab("Wages") +
  ylab("Frequency") +
  theme_minimal()

# The histogram with density on the y-axis
ggplot(SLID, aes(wages)) + 
  geom_histogram(binwidth = 2,aes(y=..density..)) + 
  labs(title = "Histogram") +
  xlab("Wages") +
  ylab("Frequency") +
  theme_minimal()

# Density plot

ggplot(SLID, aes(wages)) + 
  geom_density(color="darkblue", fill="lightblue",adjust = 2) +
  labs(title = "Density") +
  xlab("Wages") +
  ylab("Frequency") +
  theme_minimal()

?geom_density
?density


### Boxplots

ggplot(SLID, aes(x=language, y=wages)) +
  geom_boxplot(fill = "skyblue") +
  labs(title = "Box Plot") +
  theme_minimal()


### Pairs plots

library(GGally)
ggpairs(SLID) + theme_minimal()

# The more efficient (but less functional) base R version:
pairs(SLID)

