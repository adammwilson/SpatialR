#' ---
#' title       : "Data Wrangling"
#' subtitle    : 
#' author      : "Adam M. Wilson"
#' job         : 
#' framework   : revealjs
#' highlighter : highlight.js
#' hitheme     : dark
#' widgets     : []    # {mathjax, quiz, bootstrap}
#' revealjs: {theme: night, transition: fade, center: "false", width: 1080} 
#' mode        : selfcontained # {standalone, draft}
#' knit        : slidify::knit2slides
#' ---
#' 
#' 
#' 
#' ## From last week
#' 
#' ______________________
#' 
#' **Syllabus**
#' * Added grade translations
#' * UBLearns grade center
#' 
#' ___________
#' **RMarkdown _source_ for presentation**
#' * Last week shared only .R
#' * Will share .Rmd now (use if desired)
#' 
#' 
#' --- 
#' 
#' ## RStudio Shortcuts
#' 
#' ### Running code
#' * `ctrl-R` (or `command-R`) to run current line
#' * Highlight `code` in script and run `ctrl-R` (or `command-R`) to run selection
#' * Buttons: ![buttons](assets/img/Source.png)
#' 
#' ### Switching windows
#' * `ctrl-1`: script window
#' * `ctrl-2`: console window
#' 
#' > Try to run today's script without using your mouse/trackpad
#' 
#' ---
#' ## Data wrangling
#' 
#' > Data Wrangling, Gymnastics, Munging, Janitor Work, Manipulation, Transformation
#'  can take 50-80% of your time?!?
#' 
#' ### Useful packages: [`dplyr`](https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html)  and [`tidyr`]()
#' 
#' [Cheat sheets on website](https://www.rstudio.com/resources/cheatsheets/) for [Data Wrangling](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)
#' 
## ----results='hide'------------------------------------------------------
library(dplyr)
library(tidyr)

#' Remember use `install.packages("dplyr")` to install a new package.
#' 
#' ---
#' ##  Example operations from [here](https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html)
#' 
#' ### New York City Flights
#' Data from [US Bureau of Transportation Statistics](http://www.transtats.bts.gov/DatabaseInfo.asp?DB_ID=120&Link=0) (see `?nycflights13`)
## ----results='hide'------------------------------------------------------
library(nycflights13)

#' Check out the `flights` object
## ------------------------------------------------------------------------
head(flights)

#' 
#' ---
#' ## Object _Structure_
#' Check out data _structure_ with `str()`
## ------------------------------------------------------------------------
str(flights)

#' 
#' ---
#' ## `dplyr` "verbs" of data manipulation
#' 
#' * `select()` and `rename()`: Extract existing variables
#' * `filter()` and `slice()`: Extract existing observations
#' * `arrange()`
#' * `distinct()`
#' * `mutate()` and `transmute()`: Derive new variables
#' * `summarise()`: Change the unit of analysis
#' * `sample_n()` and `sample_frac()`
#' 
#' ---
#' ## Useful select functions
#' 
#' * "`-`"  Select everything but
#' * "`:`"  Select range
#' * `contains()` Select columns whose name contains a character string
#' * `ends_with()` Select columns whose name ends with a string
#' * `everything()` Select every column
#' * `matches()` Select columns whose name matches a regular expression
#' * `num_range()` Select columns named x1, x2, x3, x4, x5
#' * `one_of()` Select columns whose names are in a group of names
#' * `starts_with()` Select columns whose name starts with a character string
#' 
#' ---
#' ## `select()` examples
## ------------------------------------------------------------------------
select(flights,year, month, day)

## ------------------------------------------------------------------------
select(flights,-tailnum)

## ------------------------------------------------------------------------
select(flights,contains("time"))

#' 
#' ---
#' ## `filter()` observations
#' 
#' `filter(.data,expressions)`
#' 
#' For example, select all flights on January 1st:
## ------------------------------------------------------------------------
filter(flights, month == 1, day == 1)

#' 
#' 
#' ---
#' ## _Base_ R method
#' This is equivalent to the more verbose code in base R:
#' 
## ------------------------------------------------------------------------
flights[flights$month == 1 & flights$day == 1, ]

#' 
#' Compare with `dplyr` method: 
## ----eval=F--------------------------------------------------------------
## filter(flights, month == 1, day == 1)`

#' 
#' ---
#' ## Filter excercise
#' > Filter the `flights` data set to keep only evening flights (`dep_time` after 1600) in June.
#' 
#' . . .
#' 
#' 
#' ---
#' ## Other _boolean_ expressions
#' `filter()` is similar to `subset()` except it handles any number of filtering conditions joined together with &. 
#' 
#' You can also use other boolean operators, such as _OR_ ("|"):
## ------------------------------------------------------------------------
filter(flights, month == 1 | month == 2)

#' 
#' ---
#' 
#' ## Filter excercise
#' > Filter the `flights` data set to keep only 'redeye' flights where the departure time (`dep_time`) plus the duration (`air_time`) is after midnight:
#' 
#' . . .
#' 
#' 
#' 
#' ---
#' ## Select rows by position using slice():
## ------------------------------------------------------------------------
slice(flights, 1:10)

#' 
#' ---
#' ## Arrange rows with `arrange()`
#' 
#' `arrange()` is similar to `filter()` except it reorders instead of filtering.  
#' 
## ------------------------------------------------------------------------
arrange(flights, year, month, day)

#' _Base_ R method:
## ----eval=F--------------------------------------------------------------
## flights[order(flights$year, flights$month, flights$day), ]

#' 
#' ---
#' ## Use `desc()` to use descending order:
#' 
## ------------------------------------------------------------------------
arrange(flights, desc(arr_delay))

#' 
#' _Base_ R method:
## ----eval=F--------------------------------------------------------------
## flights[order(desc(flights$arr_delay)), ]

#' 
#' 
#' ---
#' ## Chaining Operations
#' Performing multiple operations sequentially with a _pipe_ character
#' 
## ------------------------------------------------------------------------
a1 <- group_by(flights, year, month, day)
a2 <- select(a1, arr_delay, dep_delay)
a3 <- summarise(a2,
  arr = mean(arr_delay, na.rm = TRUE),
  dep = mean(dep_delay, na.rm = TRUE))
a4 <- filter(a3, arr > 30 | dep > 30)
head(a4)

#' 
#' ---
#' ## Chaining Operations
#' If you don’t want to save the intermediate results: wrap the function calls inside each other:
#' 
## ------------------------------------------------------------------------
filter(
  summarise(
    select(
      group_by(flights, year, month, day),
      arr_delay, dep_delay
    ),
    arr = mean(arr_delay, na.rm = TRUE),
    dep = mean(dep_delay, na.rm = TRUE)
  ),
  arr > 30 | dep > 30
)

#' 
#' Arguments are distant from function -> difficult to read!  
#' 
#' ---
#' ## Chaining Operations
#' 
#' `%>%` allows you to _pipe_ together various commands
#' 
#' `x %>% f(y)` turns into `f(x, y)`
#' 
#' 
#' So you can use it to rewrite multiple operations that you can read left-to-right, top-to-bottom:
## ------------------------------------------------------------------------
flights %>%
  group_by(year, month, day) %>%
  select(arr_delay, dep_delay) %>%
  summarise(
    arr = mean(arr_delay, na.rm = TRUE),
    dep = mean(dep_delay, na.rm = TRUE)
  ) %>%
  filter(arr > 30 | dep > 30)

#' 
#' ---
#' ### `group_by()`
#' Perform operations by _group_: mean departure delay by airport (`origin`)
#' 
## ------------------------------------------------------------------------
flights %>%
  group_by(origin) %>%
  summarise(meanDelay = mean(dep_delay,na.rm=T))

#' 
#' 
#' ---
#' ### `group_by()`
#' Perform operations by _group_: mean and sd departure delay by airline (`carrier`)
#' 
## ------------------------------------------------------------------------
flights %>% 
  group_by(carrier) %>%  
  summarise(meanDelay = mean(dep_delay,na.rm=T),
            sdDelay =   sd(dep_delay,na.rm=T))

#' 
#' 
#' ---
#' ## `group_by()`
#' Perform operations by _group_
#' 
#' > Flights from which airport (`origin`) go the farthest (on average)?  Calculate the maximum flight distance (`distance`) by airport (`origin`).
#' 
#' 
#' > Which destination airport is the farthest from NYC?
#' 
#' > Which destination airport is the farthest from NYC?
#' 
#' ---
#' 
#' # Combining data sets
#' 
#' ## `dplyr` _join_ methods
#' ![join](assets/img/join1.png)
#' 
#' ---
#' ## `dplyr` _join_ methods
#' 
#' ![join](assets/img/join1.png)
#' 
#' * `left_join(a, b, by = "x1")` Join matching rows from b to a.
#' * `right_join(a, b, by = "x1")` Join matching rows from a to b.
#' * `inner_join(a, b, by = "x1")` Retain only rows in both sets.
#' * `full_join(a, b, by = "x1")` Join data. Retain all values, all rows.
#' 
#' --- 
#' ## `dplyr` _join_ methods
#' 
#' `left_join(a, b, by = "x1")` Join matching rows from b to a.
#' 
#' <img src="assets/img/join1.png" alt="Drawing" style="width: 400px;"/>
#' 
#' ![join](assets/img/join_left.png)
#' 
#' --- 
#' ## `dplyr` _join_ methods
#' 
#' `right_join(a, b, by = "x1")` Join matching rows from a to b.
#' 
#' <img src="assets/img/join1.png" alt="Drawing" style="width: 400px;"/>
#' 
#' ![join](assets/img/join_right.png)
#' 
#' 
#' --- 
#' ## `dplyr` _join_ methods
#' 
#' `inner_join(a, b, by = "x1")` Retain only rows in both sets.
#' 
#' <img src="assets/img/join1.png" alt="Drawing" style="width: 400px;"/>
#' 
#' ![join](assets/img/join_inner.png)
#' 
#' --- 
#' ## `dplyr` _join_ methods
#' 
#' `full_join(a, b, by = "x1")` Join data. Retain all values, all rows.
#' 
#' <img src="assets/img/join1.png" alt="Drawing" style="width: 400px;"/>
#' 
#' <img src="assets/img/join_full.png" alt="Drawing" style="width: 450px;"/>
#' 
#' --- 
#' ## `dplyr` _join_ methods
#' 
## ------------------------------------------------------------------------
slice(flights, 1:5)

#' 
#' Let's look at the `airports` data table (`?airports` for documentation):
## ------------------------------------------------------------------------
slice(airports, 1:5)

#' 
#' --- 
#' ## `dplyr` _join_ methods
#' 
#' > Try to _join_ the `flights` database and `airports` database.  Which join will you use?
#' 
#' Hint: you'll need to rename the column names before joining.
#' 
#' ---
#' 
#' --- 
#' ## `dplyr` _join_ methods
#' 
#' > Try to _join_ the `flights` database and `airports` database.  Which join will you use?
#' 
## ------------------------------------------------------------------------
left_join(flights,
          select(airports,dest=faa,destName=name))%>% 
  arrange(desc(distance)) %>% 
  slice(1) %>% 
  select(destName)

