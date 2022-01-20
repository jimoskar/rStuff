library(tidyverse)

#### Data Visualization with ggplot

# -------------------#
# Geometric objects  #
# -------------------#

## 3.3.1 Exercises
# 1.
# Wrong:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
# Fix:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color ="blue")

# 2.
str(mpg)
mpg

# 3.
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = displ))
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, size = displ))

# 4.
ggplot(data = mpg, aes(x = displ, y = displ)) + geom_point() 

# 5.
ggplot(data = mpg, aes(x = displ, y = displ, stroke = 3), shape = 21) + geom_point() 

# 6.
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5))

## 3.5.1
# 1.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid( ~ displ)

# 2.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))

# 3.
# by row:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)
# by column:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

# 4.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

# 5.

## 3.6.1 Exercises

# 1.
# geom_box

# 2.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

# 3.
# Removes lenged.

# 4.
# se: Whether to include prediction interval

# 5.
# No.

# 6.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth(se = F)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, group = drv)) + 
  geom_point() + 
  geom_smooth(se = F)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, group = drv, color  = drv)) + 
  geom_point() + 
  geom_smooth(se = F)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(aes(color = drv)) + 
  geom_smooth(se = F)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(aes(color = drv)) + 
  geom_smooth(aes(linetype = drv),se = F)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(aes(color = drv), shape = 21) 

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
  geom_point(size = 4, color = 'white') +
  geom_point()
  
# 3.8.1 Exercises
# 1.
# Fix: 
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_jitter()

# 2.
?geom_jitter

# 3.
?geom_count
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_count()

# 4.
?geom_boxplot # dodge2
ggplot(data = mpg) + 
  geom_boxplot(aes(x = drv, y = displ))

# 3.9.1 Exercises
# 1.
ggplot(data = mpg) + 
  geom_bar( mapping = aes(x = factor(1), fill = drv), width = 1) + 
  coord_polar(theta = "y")

# 2.
?labs()

# 3.
?coord_quickmap
?coord_map

# 4.
?coord_fixed
?geom_abline

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + 
  geom_abline() +
  coord_fixed()


# Exercise 3.6.6

# With stroke:
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(colour="white", shape=21, size = 4,
             aes(stroke = 2, fill = factor(drv))) 
# Overlapping geometric objects:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(color = "white", size = 4) +
  geom_point(aes(color = drv))

ggplot(data = mpg, mapping = aes(x = drv, y = class)) + geom_point()
?mpg
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





