# Solution exercises R with remote databases
# from https://www.r-exercises.com/2017/09/10/r-with-remote-databases-exercises-part-1/

# Exercise 1
library(dplyr)
library(dbplyr)
library(DBI)
library(RSQLite)
library(nycflights13)

con <- dbConnect(SQLite(), path = ":memory:")

# Exercise 2
copy_to(con, flights, name = 'flights', temporary = FALSE)
copy_to(con, planes, name = 'planes', temporary = FALSE)

# Exercise 3
dbListFields(con, 'flights')

# Exercise 4
tbl(con, sql("select carrier, count(*) as count from flights group by 1")) %>%
  collect()

# Exercise 5
tbl(con, 'flights') %>% 
  select(carrier) %>% 
  group_by(carrier) %>% 
  count()

# Exercise 6
tbl(con, 'flights') %>% 
  group_by(tailnum) %>% 
  summarise(count=n(),
    mean_distance = mean(distance),
    total_distance = sum(distance)) %>%
  filter(!is.na(tailnum)) %>%
  compute(name = 'planes_distance')

# Exercise 7
DBI::dbListTables(con)

# Exercise 8
tbl(con, 'planes') %>% 
  head
tbl(con, 'planes') %>% 
  tail
tbl(con, 'planes') %>% 
  nrow

# Exercise 9
tbl(con, 'planes_distance') %>% 
  inner_join(tbl(con, 'planes'), by='tailnum') %>%
  arrange(desc(total_distance)) %>%
  select(total_distance, manufacturer, model)

# Exercise 10
tbl(con, 'planes_distance') %>%
  inner_join(tbl(con, 'planes'), by='tailnum') %>%
  arrange(desc(total_distance)) %>%
  select(total_distance, manufacturer, model) %>%
  show_query()

# Solution exercises R with remote databases part 2
# from https://www.r-exercises.com/2017/09/17/r-with-remote-databases-solutions-part-2/

# Exercise 1
library(dplyr)
library(dbplyr)
library(DBI)
library(RSQLite)
library(nycflights13)

con <- dbConnect(SQLite(), ':memory:')
copy_to(con, flights, name = 'flights', temporary = FALSE)
copy_to(con, flights, name = 'flights_idx', temporary = FALSE, indexes = list("carrier"))

# Exercise 2
microbenchmark::microbenchmark(tbl(con, 'flights') %>%
    group_by(carrier) %>%
    summarise(count = n()) %>%
    collect(),
  tbl(con, 'flights_idx') %>%
    group_by(carrier) %>%
    summarise(count = n()) %>%
    collect(),
  times = 10)

# Exercise 3
tbl(con, 'flights') %>%
  group_by(carrier) %>%
  summarise(count = n()) %>%
  explain()

tbl(con, 'flights_idx') %>%
  group_by(carrier) %>%
  summarise(count = n()) %>%
  explain()

# Exercise 4
translate_sql(as.character(x))

# Exercise 5
translate_sql(substr(x, 1, 3))

# Exercise 6
translate_sql(x^2)
tbl(con, sql('select 1 as x')) %>%
  mutate(sqr = x^2)

# Exercise 7
translate_sql(mean(x))
translate_sql(mean(x, trim = 0.1))
translate_sql(mean(x, na.rm = TRUE))

# Exercise 8
tbl(con, 'flights') %>% 
  group_by(carrier) %>% 
  summarise(mean = mean(dep_delay)) %>% 
  collect()

# Exercise 9
tbl(con, 'flights') %>%
  filter(dest %like% 'A%') %>%
  summarise(cnt = n_distinct(dest))

# Exercise 10
tbl(con, 'flights') %>%
  mutate(org_dest = origin %|| '-' ||% dest) %>%
  select(origin, dest, org_dest)
