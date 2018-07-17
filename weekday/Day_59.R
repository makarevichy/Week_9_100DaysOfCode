# Solution exercises of data.table: Smooth data exploration
# from https://www.r-exercises.com/2017/08/23/basics-of-data-table-smooth-data-exploration/

# Exercise 1
library(data.table)
library(AER)
data("Fertility")
df <- as.data.table(Fertility)

# Exercise 2
df[35:50, .(age, work)]

# Exercise 3
df[.N]

# Exercise 4
df[morekids == 'yes', .N]

# Exercise 5
df[ , .N, by = .(gender1, gender2)]

# Exercise 6
df[ , mean(work <= 4), by = .(afam, hispanic, other)]

# Exercise 7
df[between(age, 22, 24), mean(gender1 == 'male')]

# Exercise 8
df[ , age_squared := age ^ 2]

# Exercise 9
df[ , .(.N, proportion_male = mean(gender1 == "male")), by = .(afam, hispanic, other)]

# Exercise 10
df[ , mean(morekids == "yes"), by = .(gender1, gender2)]
