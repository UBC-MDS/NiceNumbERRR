
<!-- README.md is generated from README.Rmd. Please edit that file -->

# NiceNumbERRR

<!-- badges: start -->

[![R-CMD-check](https://github.com/UBC-MDS/NiceNumbERRR/workflows/R-CMD-check/badge.svg)](https://github.com/UBC-MDS/NiceNumbERRR/actions)
[![codecov](https://codecov.io/gh/UBC-MDS/NiceNumbERRR/branch/master/graph/badge.svg?token=MF0J6UO2ST)](https://codecov.io/gh/UBC-MDS/NiceNumbERRR)
<!-- badges: end -->

This R package provides basic functions that make numbers display
nicely. In most real-world problems, the datasets are raw and we need to
deal with number formats to make them readable for humans or for
computers. Usually, a few or more lines of coding are needed while
dealing with number-display problems so we are thinking of compressing
the time and programming work on this issue. This package solves this
kind of problems in a way of transfer forward and backward from long
digit numbers to human-readable ones. There are functions doing single
number transactions, column transactions from a data frame, and
displaying colors of input numbers.  
\#\# Installation

You can install the released version of NiceNumbERRR from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("NiceNumbERRR")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("UBC-MDS/NiceNumbERRR")
```

## Features

The package contains the following five functions:

-   `to_human`

This function converts numeric value to human-readable string
representations. Users need to use a specific number as input and choose
decimal precision and prefixes of filesize or numbers as optionals. The
function will return a human-readable string.

-   `to_numeric`

This function converts a human-readble value to a Python readable
numeric value. Users need to use a specific human-readable string of
numbers as input and choose the prefixes of filesize or numbers as
optionals. The function will return a float.

-   `to_df`

This function changes the formatting of text in one or more columns of
data in a dataframe. The inputs should include a data frame, column
name(s), and two optionals: transform type(eg. human) and type of
prefixes. The function will return a dataframe with the values from the
input columns transferred to the transform type(human-readable by
default).

-   `to_color`

This function separate numeric values to parts starting from the right
and each part contains three digits. Then it gives different colors to
each part and the default colors are red, green, yellow, and blue. Users
need to use a specific number as input and choose a list of colors they
want to assign on the number as an optional. The function will return a
string that can be used in print() function to visual numbers with
colors.

## Example

This is a basic example which shows how to generate summary statistics
and conduct moving average modelling:

``` r
#install.packages("NiceNumbERRR")
#library(NiceNumbERRR)
#to_human(78950000, prec = 0, family = "numeric") 
#to_color(1234L, c('red', 'yellow'))
```

## R Ecosystem

There are many R packages that have similar functionalities with this
package in the Python ecosystem. For example:

-   [humanReadable](https://www.rdocumentation.org/packages/gdata/versions/2.18.0/topics/humanReadable)
    converts integer byte sizes to a human readable units such as kB,
    MB, GB, etc.

-   [humanize](https://github.com/gerrymanoim/humanize) provides
    utilities to convert values (times, files sizes, and numbers) into
    human readable forms.

-   [prettyunits](https://github.com/r-lib/prettyunits) works just like
    `humanize`, it formats times and file-sizes quantities in human
    readable form.

We aim to optimize those existing packages so that the users can use one
package instead of using several packages at the same time.
