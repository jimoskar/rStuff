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

# 5.3.1 Exercises
# 1.
arrange(flights, desc(is.na(dep_time)))

# 2.
arrange(flights, desc(dep_delay))

# 3.
arrange(flights, desc(distance/air_time))

# 4.
arrange(flights, distance)
arrange(flights, desc(distance))

# 5.4.1 Exercises
# 1.
select(flights, dep_time, dep_delay, arr_time, arr_delay)

# 2.
select(flights, dep_time, dep_time) # nothing happens.

# 3.
?any_of
select(flights, any_of(vars <- c("year", "month", "day", "dep_delay", "arr_delay")))

# 4.
select(flights, contains("TIME"))
select(flights, contains("TIME", ignore.case = FALSE))

# 5.5.2 Exercises
# 1.
transmute(flights,
          dep_time,
          dep_hour = dep_time %/% 100,
          dep_minute = dep_time %% 100,
          dep_time_min = (60*dep_hour + dep_minute) %% 1440,
          sched_dep_time,
          sched_dep_hour = sched_dep_time %/% 100,
          sched_dep_minute = sched_dep_time %% 100,
          sched_dep_time_min = (60*sched_dep_hour + sched_dep_minute) %% 1440
)

# 2.
transmute(flights, air_time, dep_time, arr_time, 
          air_time2 = ((arr_time %/% 100) * 60 + arr_time %% 100) %% 1440
                      - ((dep_time %/% 100) * 60 + dep_time %% 100) %% 1440)

# 3.
time2mins <- function(x) {
  (x %/% 100 * 60 + x %% 100) %% 1440
}
transmute(flights, dep_time_min = time2mins(dep_time), sched_dep_time_min = time2mins(sched_dep_time), 
          diff = dep_time_min - sched_dep_time_min, dep_delay)

# 4.
?min_rank

# 5.
1:3 + 1:10 # recycles values of shorter vector.
