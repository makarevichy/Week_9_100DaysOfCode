# Solution exercises Basic Generalized Linear Modeling
# from https://www.r-exercises.com/2018/07/20/fighting-factors-with-cats-solutions/
library(gapminder)
library(forcats)

# Exercise 1
fct_count(gapminder$continent)
paste(strsplit("forcats", "")[[1]][sample(1:7)], collapse = "")

# Exercise 2
gapminder$continent <- fct_expand(gapminder$continent, "Antarctica")

# Exercise 3
gapminder$continent <- fct_drop(gapminder$continent)
fct_count(gapminder$continent)

# Exercise 4
cont <- c("Argentina", "Bolivia", "Brazil", "Chile", "Colombia", "Ecuador",
  "Paraguay", "Peru", "Uruguay", "Venezuela")
gapminder$continent <- fct_expand(gapminder$continent, "South America", "North America")


gapminder$continent[gapminder$country %in% cont] <- "South America"
gapminder$continent[gapminder$continent == "Americas"] <- "North America"
gapminder$continent <- fct_drop(gapminder$continent)
fct_count(gapminder$continent)

# Exercise 5
gapminder$continent <- fct_relevel(gapminder$continent, sort(levels(gapminder$continent)))
fct_count(gapminder$continent)

# Exercise 6
popul <- aggregate(pop ~ continent, gapminder[gapminder$year == 2007, ], sum)
gapminder$continent <- fct_relevel(gapminder$continent,
  as.character(popul[order(-popul$pop), ]$continent)
)

# Exercise 7
gapminder$continent <- fct_rev(gapminder$continent)

# Exercise 8
gapminder$continent <- fct_relevel(gapminder$continent, "North America")

# Exercise 9
sex <- c("f", "m ", "male ","male", "female", "FEMALE", "Male", "f", "m")
sex <- as_factor(sex)
sex <- fct_collapse(sex,
  Female = c("f", "female", "FEMALE"),
  Male   = c("m ", "m", "male ", "male", "Male"))
fct_count(sex)

# Exercise 10
sex <- fct_anon(sex)
fct_count(sex)