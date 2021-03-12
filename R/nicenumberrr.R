library(stringr)
library(tidyverse)

suffixes <- list(
    number = c('K', 'M', 'B', 'T', 'Q'),
    filesize= c('KB', 'MB', 'GB', 'TB', 'PB'))


throw_err <- function(err, errors) {
    if (errors == "coerce"){
        return (NA)
    }
    else {
        stop(err)
    }
}

check_family <- function(family) {
    
}


#' Convert large number to human readable string
#'
#' @param number float
#' @param prec precision to round to
#' @param family family of suffix, numeric or filesize
#'
#' @return string in human readable version
#' @export
#'
#' @examples to_human(69420, prec = 1)
#' "69.4K"
#'
to_human <- function(number, prec = 0, family = "number", errors = "throw", custom_suff = NULL) {
    
    if (!is.numeric(number)) {
        err <- "Value must be numeric!"
        throw_err(err, errors)
    }


}


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
to_numeric <- function(string,  family = "number", errors = "throw", custom_suff = NULL) {
  

  
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
      return (n*base**(which(suffixes$number == unit)))
    }
    else if ({{family}} == "filesize"){
      return (n*base**(which(suffixes$filesize == unit)))
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


#' Change the formatting of data in column(s) of a dataframe to either human readable or numeric
#'
#' @param df dataframe, dataframe to apply formatting
#' @param col_names str or vector, column names to apply formatting (default is all columns)
#' @param transform_type str, type of transformation (e.g. human, num)
#' @param family str, family of suffix, numeric or filesize
#'
#' @return dataframe with formatting applied
#' @export
#'
#' @examples to_df(df, col_names=c("A", "B"), transform_type="human")
#'
#'
to_df <- function(df, col_names = NULL, transform_type = "human", family = "numeric") {
  if (is.null(col_names)) {
    col_names <-  colnames(df)
  }
  
  if (transform_type == "human") {
    df[] <- map_at(df, col_names, ~ to_human(.))
  } else if (transform_type == "num") {
    df[] <- map_at(df, col_names, ~ to_numeric(.))
  }
  
  return(df)
}


#' Give all parts of the number with different colors
#'
#' @param number int
#' @param colors vector of different colors
#'
#' @return vector of colored int
#' @export
#'
#' @examples to_color(1234, c('red', 'yellow'))
to_color <- function(number, colors) {
  
}

