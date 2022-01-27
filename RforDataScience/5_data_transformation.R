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

# 5.6.7 Exercises
# 1.
# Could take mean, could consider se, positive mean, compare dep_delay with arr_delay.
flights %>% group_by(dest) %>% summarise(arr_mean = mean(arr_delay, na.rm = TRUE), dep_mean = mean(dep_delay, na.rm = TRUE))
flights %>% group_by(dest) %>% 
  summarise(count = n(), dist = mean(distance, na.rm = TRUE), delay = mean(arr_delay, na.rm = TRUE)) %>% 
  filter(dist < 4000, count > 20) %>% 
  ggplot(aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

# 2.
not_cancelled <- flights %>% filter(!is.na(arr_delay), ! is.na(dep_delay))
not_cancelled %>% count(dest) 
not_cancelled %>% count(tailnum, wt = distance)
# Alternative:
not_cancelled %>% group_by(dest) %>% summarise(count = n())
not_cancelled %>% group_by(tailnum) %>% summarise(n = sum(distance))

# 3.
# 4.
flights %>%  group_by(day) %>% 
  summarise(num_cancelled = sum(is.na(dep_delay))) %>% 
  ggplot(aes(x = day, y =  num_cancelled)) +
  geom_point() +
  geom_smooth(se = FALSE)

# 5.
flights %>% group_by(carrier) %>% 
  summarise(arr_avg = mean(arr_delay, na.rm = TRUE), dep_avg = mean(dep_delay, na.rm = TRUE)) %>% 
  arrange(desc(arr_avg), desc(dep_avg))
# F9 seems to be the worst
flights %>% group_by(carrier, dest) %>% summarise(n())

# 6.
?count()

# 5.7.1 Exercises
# 1.
tibble(x = 1:9,
       group = rep(c("a", "b", "c"), each = 3))

# 2.
flights %>% group_by(tailnum) %>% 
  summarise(arr_mean = mean(arr_delay, na.rm = TRUE), dep_mean = mean(dep_delay, na.rm = TRUE)) %>% 
  arrange(desc(arr_mean), desc(dep_mean))
  
# 3.
flights %>% filter(!is.na(arr_delay), !is.na(dep_delay)) %>% mutate(is_delayed = arr_delay > 0) %>%
  group_by(hour) %>%  summarise(count = n(), delayed = sum(is_delayed), arr_avg = mean(arr_delay)) %>% 
  ggplot(aes(x = hour, y = delayed/count)) +
  geom_point()

# 4.
flights %>% filter(arr_delay > 0) %>% group_by(dest) %>% 
  mutate(arr_delay_tot = sum(arr_delay), arr_delay_prop = arr_delay/arr_delay_tot) %>% 
  select(dest, month, day, dep_time, carrier, flight,
         arr_delay, arr_delay_prop) %>%
  arrange(dest, desc(arr_delay_prop))

# 5.
?lag()
lagged_delays <- flights %>%
  arrange(origin, month, day, dep_time) %>%
  group_by(origin) %>%
  mutate(dep_delay_lag = lag(dep_delay)) %>%
  filter(!is.na(dep_delay), !is.na(dep_delay_lag))

lagged_delays %>%
  group_by(dep_delay_lag) %>%
  summarise(dep_delay_mean = mean(dep_delay)) %>%
  ggplot(aes(y = dep_delay_mean, x = dep_delay_lag)) +
  geom_point() +
  scale_x_continuous(breaks = seq(0, 1500, by = 120)) +
  labs(y = "Departure Delay", x = "Previous Departure Delay")

# 6.
flights %>% group_by(origin, dest) %>% summarise(min(air_time, na.rm = TRUE))

# 7.
flights %>%
  # find all airports with > 1 carrier
  group_by(dest) %>%
  mutate(n_carriers = n_distinct(carrier)) %>%
  filter(n_carriers > 1) %>%
  # rank carriers by number of destinations
  group_by(carrier) %>%
  summarize(n_dest = n_distinct(dest))

# 8.
flights %>% select(tailnum, year, month, day, arr_delay) %>% 
  filter(!is.na(arr_delay)) %>%  mutate(gt1 = arr_delay > 60) %>% 
  group_by(tailnum) %>% mutate(cum_gt1 = cumsum(gt1)) %>%  summarise(num_b4gt1 = sum(cum_gt1 == 0))

  
  