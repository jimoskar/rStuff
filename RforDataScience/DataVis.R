library(tidyverse)

#### Data Visualization with ggplot

# -------------------#
# Geometric objects  #
# -------------------#

# Combining geometric objects:
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv))

# Better:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(mapping = aes(linetype = drv))

# Without confidence interval:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

# Exercise 3.6.6

# With stroke:
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(colour="white", shape=21, size = 4,
             aes(stroke = 2, fill = factor(drv))) 
# Overlapping geometric objects:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(color = "white", size = 4) +
  geom_point(aes(color = drv))

# ------------------------------#
# Statistical transformations   #
# ------------------------------#

# Everey statistical tr. (stat) is associated with a geom, and every geom is 
# associated with a stat.

# Exercise 3.7.1

# Using a statistical:
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )

# Recreating plot with geom:
ggplot(data = diamonds, aes(x = cut, y = depth)) +
  geom_pointrange(stat = "summary",
  fun.min = min,
  fun.max = max,
  fun = median)

# -----------------------#
# Position adjustments   #
# -----------------------#

# Stack proportions within each group
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

# Modify the position:

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

# Overplotting: multiple points are approximated as one point because
# of the gridding. Can be accomodated by 'jittering':

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")

# Equivalently:
ggplot(data = mpg) +
  geom_jitter(aes(displ, hwy))

# -------------------#
# Coordinate systems #
# -------------------#

# Exercise 3.9.1

bar <- ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

bar + coord_polar()





