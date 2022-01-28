# 7.3.4 Exercises
# 1.
library(tidyverse)

diamonds %>% 
ggplot() +
  geom_histogram(aes(x = x), binwidth = 0.02) 

diamonds %>% 
  ggplot() +
  geom_histogram(aes(x = y), binwidth = 0.02)

diamonds %>% 
  ggplot() +
  geom_histogram(aes(x = z), binwidth = 0.02)

# 2.
ggplot(diamonds, aes(x = price)) + 
  geom_histogram(binwidth = 10)

# 3.
diamonds %>% filter(carat >= 0.99,  carat <= 1) %>% count(carat)
ggplot(diamonds) + geom_bar(aes(x = carat))

# 4.




