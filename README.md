
<!-- README.md is generated from README.Rmd. Please edit that file -->

# groupmaker

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/cforgaci/group-maker/branch/master/graph/badge.svg)](https://codecov.io/gh/cforgaci/group-maker?branch=master)
<!-- badges: end -->

The goal of groupmaker is to make diverse group making easier.

## Installation

You can install the released version of groupmaker from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("groupmaker")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("cforgaci/group-maker")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(groupmaker)

require(dplyr)
#> Loading required package: dplyr
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union

# Example data
students <- tibble(name = c("John", "Mary", "Bob", "Kate", "Ganesh", "Marta", "Janneke"),
                   nationality = c("NL", "RO", "US", "NL", "IN", "DE", "NL"),
                   designer = c(TRUE, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE),
                   gender = c("M", "F", "M", "F", "M", "F", "F"))
students$nationality <- as.factor(students$nationality)
students$gender <- as.factor(students$gender)

# How many students should be in a group?
group_size <- 3

# Make groups
make_groups(students, group_size)
#> # A tibble: 7 × 5
#>   name    nationality designer gender group  
#>   <chr>   <fct>       <lgl>    <fct>  <fct>  
#> 1 John    NL          TRUE     M      group_1
#> 2 Janneke NL          FALSE    F      group_1
#> 3 Bob     US          FALSE    M      group_1
#> 4 Marta   DE          FALSE    F      group_1
#> 5 Kate    NL          TRUE     F      group_2
#> 6 Mary    RO          FALSE    F      group_2
#> 7 Ganesh  IN          TRUE     M      group_2
#> [1] "Gender distribution across groups: OK"
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/master/examples>.

<!-- You can also embed plots, for example: -->
<!-- ```{r pressure, echo = FALSE} -->
<!-- plot(pressure) -->
<!-- ``` -->
<!-- In that case, don't forget to commit and push the resulting figure files, so they display on GitHub and CRAN. -->
