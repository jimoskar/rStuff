library(nycflights13)
library(tidyverse)

# 5.2.4 Exercises
# 1.
?flights
filter(flights, arr_delay > 120)
filter(flights, dest == 'IAH' | dest == 'HOU')

# 2.
?between()

# 3.
nrow(filter(flights, is.na(dep_time)))

# 4.
NA^0
