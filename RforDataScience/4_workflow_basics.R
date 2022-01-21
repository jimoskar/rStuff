# 4.4 Exercises
# 1.
my_variable <- 10
my_variable

# 2.
library(tidyverse)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

filter(mpg, cyl == 8)
filter(diamonds, carat > 3)

# 3. 