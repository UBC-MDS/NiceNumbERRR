#' Convert human-readable string to numeric number
#'
#' @param string string
#' @param family family of suffix, numeric or filesize
#' @param custom_suff List of custom suffixes, default NULL
#' @param errors 'raise', 'coerce', default 'raise'
#'                If 'raise', then invalid parsing will raise an exception.
#'                If 'coerce', then invalid parsing will return NA.
#'
#' @return a computer-readable numeric number
#' @export
#'
#' @examples to_numeric("69.4K")
#' 69400
library(stringr)
library(tidyverse)
suffix <- list(number = c('K', 'M', 'B', 'T', 'Q'), filesize= c('KB', 'MB', 'GB', 'TB', 'PB'))
to_numeric <- function(string,  family = "number", errors = "throw", custom_suff = NULL) {

  throw_err <- function(err, errors){
    if (errors == "coerce"){
      return (NA)
    }
    else {
      stop(err)
    }
  }

  if (is.character({{string}}) == TRUE ){
    base = 1000
    string <- str_replace_all({{string}}, '^[\\D]+','') %>%
        toupper()
    n <- (str_split(string, "[$[:alpha:]]+") %>%
        unlist())[1] %>%
        as.double()
    unit <- str_extract_all(string, "[[:alpha:]]+")[[1]]
    if (is.null(custom_suff) != TRUE){
      return (n*base**(which(custom_suff == unit)))
    }
    else if ({{family}} == "number") {
      return (n*base**(which(suffix$number == unit)))
    }
    else if ({{family}} == "filesize"){
      return (n*base**(which(suffix$filesize == unit)))
    }
    else {
      err <- "Invalid input for custom_suff or family."
      throw_err(err, errors)
    }
  }
  else if (is.double({{string}}) == TRUE){
    return ({{string}})
  }
  else{
    err <- "Wrong input type for string, should be a number or string."
    throw_err(err, errors)
  }

}


