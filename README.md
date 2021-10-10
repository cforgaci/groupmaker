
<!-- README.md is generated from README.Rmd. Please edit that file -->

# groupmaker

<!-- badges: start -->
<!-- [![Codecov test coverage](https://codecov.io/gh/cforgaci/group-maker/branch/master/graph/badge.svg)](https://codecov.io/gh/cforgaci/group-maker?branch=master) -->
<!-- badges: end -->

The goal of groupmaker is to make diverse group making easier.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("cforgaci/group-maker")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(groupmaker)

require(dplyr, warn.conflicts = FALSE)
#> Loading required package: dplyr

# Example data included in the package
students
#> # A tibble: 7 × 4
#>   name    nationality designer gender
#>   <chr>   <fct>       <lgl>    <fct> 
#> 1 John    NL          TRUE     M     
#> 2 Mary    RO          FALSE    F     
#> 3 Bob     US          FALSE    M     
#> 4 Kate    NL          TRUE     F     
#> 5 Ganesh  IN          TRUE     M     
#> 6 Marta   DE          FALSE    F     
#> 7 Janneke NL          FALSE    F

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
