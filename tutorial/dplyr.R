###############################################################
# This is the R script for the Bonus on the tidyverse
# Introduction into R programming, Data manipulation in tidyverse
#
# In this script we tried to reproduce as closely as possible the code that is used to follow the video https://www.youtube.com/watch?v=Zc_ufg4uW4U by G. Grolemund; However some of the datasets were a little bit different, but for the understanding of the R code this should not matter.
#
###############################################################

# install.packages("tidyverse")
# install.packages("nycflights13")
library(tidyverse)
library(nycflights13)

####################################################
# Checking the helpfiles for some useful dply verbs:

?select
?filter
?arrange
?mutate
?summarise


####################################################
# Using select() to pull out colums from the data
####################################################

# Start by loading the storms data from the nycflights13 package
data(storms)

# The storms data is a so-called tibble (https://tibble.tidyverse.org/), which we can quickly summarise by using the function glimpse()
glimpse(storms)

# select the two columns called storm and pressure. The first argument in the select() function is always the data (note that the storm column is called "name" in the dataset we use)
select(storms,name,pressure)

# select all colums except name
select(storms,-name)

# select all columns between the column "name" and "hour" (directly wrap glimpse around the command)
select(storms,name:hour)


####################################################
# Using filter() chooses all rows that fulfill the conditions
####################################################

# We can filter out all the rows that fulfill the condition of wind>50. Again, the dataset is the first argument in the filter() function; this leaves 4163 rows in the dataset
filter(storms,wind>50)

# Filtering for more than one condition;
# Here we filter for wind speet >50 and three storms;
# This leaves only 105 rows: 
filter(storms,wind>50,name %in% c("Alberto","Alex","Allison"))

####################################################
# mutate() adds new columns to the existing dataframe
####################################################

# Here we add a new column to the strom data, called "ratio". It contains the ratio between the pressure and the wind columns:
mutate(storms,ratio=pressure/wind)

# We can even add another column at the same time, which is a transformation of a new column generated earlier in the same call:
mutate(storms,ratio=pressure/wind, inverse = 1/ratio)


####################################################
# summarise() to summarise the data in some way
####################################################

# We can for example calculate median and variance of all wind speeds
summarise(storms, median=median(wind),variance=var(wind))

# Alternatively, we can "pipe" the dataset as follows (this corresponds to how it is done in the video for the pollution data example); the pipe will be described further down
storms %>% summarise(median=median(wind),variance=var(wind))


####################################################
# arrange() rearranges the order of the rows depending on some values of the columns
####################################################

# To sort the storms data in increasing order of wind speed:
arrange(storms,wind)

# To sort the storms data in decreasing order of wind speed:
arrange(storms,desc(wind))

# To sort the storms data in increasing order of wind speed, and within the same wind speed, order according to year (it's like a hierarchicay way of ordering)
arrange(storms,wind,year)


####################################################
# The pipe operator %>% 
####################################################

# As an example, in the original example where we used select, we can do the same in two ways:
select(storms,name,pressure)
storms %>% select(name,pressure)
# So storms is taken as the first argument in the following command select()

# The same holds for all the other examples, e.g.

filter(storms,wind>50) # is the same as
storms %>% filter(wind>50)

# Why should this be useful? It becomes most useful if we pipe sequentially several times, for example
storms %>%
  filter(wind>50) %>%
  select(name,pressure)

# The above command first filters the wind speeds >50 and from that filtered version of the data, selects the columns name and pressure. We could do the same by nesting the commands into each other:

select(filter(storms,wind>50),name,pressure)

# but that quickly becomes very confusing...


### Another example where we first add the new column ratio, and then select the name and ratio columns from that dataset
storms %>%
  mutate(ratio=pressure/wind) %>% 
  select(name,ratio)

####################################################
# group_by() + summarise()
####################################################
# We don't have the pollution data, but make an example using the storms data; 
# For better illustration we reduce our storms data to only three storms

storms.small <- storms %>% filter(name %in% c("Alicia","Barry","Ernesto"))

# The following code gives the mean and variance of wind speed measured in each storm, and the number of measurements taken (n)

storms.small %>% 
  group_by(name) %>% 
  summarise(mean=mean(wind),variance=var(wind),n=n())

# Example where we group for two variables, name of the storm and month
storms.small %>% 
  group_by(name,month) %>% 
  summarise(mean.wind=mean(wind)) 




# Each time we summarize we remove one layer of our grouping
storms.small %>% 
  group_by(name,month) %>% 
  summarise(mean.wind=mean(wind)) %>% 
  summarise(mean.wind=mean(mean.wind)) 
