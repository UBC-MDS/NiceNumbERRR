library(stringr)
library(tidyverse)

suffixes <- list(
    number = c("K", "M", "B", "T", "Q"),
    filesize = c("KB", "MB", "GB", "TB", "PB")
)


throw_err <- function(err, errors) {
    if (errors == "coerce") {
        return(NA)
    }
    else {
        stop(err)
    }
}

check_family <- function(family) {
    if (!family %in% names(suffixes)) {
        stop("Family not in suffixes")
    }
}


#' Convert large number to human readable string
#'
#' @param n number to convert float
#' @param prec precision to round to
#' @param family family of suffix, numeric or filesize
#' @param custom_suff List of custom suffixes, default NULL
#' @param errors 'raise', 'coerce', default 'raise'
#'                If 'raise', then invalid parsing will raise an exception.
#'                If 'coerce', then invalid parsing will return NA.
#'
#' @return string in human readable version
#' @export
#'
#' @examples
#' to_human(69420, prec = 1)
#' "69.4K"
to_human <- function(n, prec = 0, family = "number", errors = "raise", custom_suff = NULL) {
    if (!is.numeric(n)) {
        err <- "Value must be numeric!"
        return(throw_err(err, errors))
    }

    if (!length(n) == 1) {
        stop("Input value must be of length 1!")
    }

    check_family(family)

    base <- 3
    if (n == 0) {
        order <- 0
    } else {
        order <- log10(abs(n)) %/% 1
    }

    idx <- as.integer(order / base)
    number <- n / 10^(3 * idx)

    # check if custom suffix passed in
    if (!is.null(custom_suff)) {
        suffix_list <- custom_suff
    } else {
        suffix_list <- suffixes[[family]]
    }

    # check max length
    max_len <- length(suffix_list)

    if (idx > max_len) {
        err <- "Number too large for conversion!"
        return(throw_err(err, errors))
    }

    if (idx == 0) {
        suffix <- ""
    } else {
        suffix <- suffix_list[[idx]]
    }

    str_prec <- paste0("%.", prec, "f")
    paste0(sprintf(str_prec, round(number, prec)), suffix)
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
#' @examples
#' to_numeric("69.4K")
#' 69400
to_numeric <- function(string, family = "number", errors = "raise", custom_suff = NULL) {
    if (is.character({{ string }}) == TRUE) {
        base <- 1000
        string <- str_replace_all({{ string }}, "^[\\D]+", "") %>%
            toupper()
        n <- (str_split(string, "[$[:alpha:]]+") %>%
            unlist())[1] %>%
            as.double()
        unit <- str_extract_all(string, "[[:alpha:]]+")[[1]]
        if (is.null(custom_suff) != TRUE) {
            return(n * base**(which(custom_suff == unit)))
        }
        else if ({{ family }} == "number") {
            return(n * base**(which(suffixes$number == unit)))
        }
        else if ({{ family }} == "filesize") {
            return(n * base**(which(suffixes$filesize == unit)))
        }
        else {
            err <- "Invalid input for custom_suff or family."
            throw_err(err, errors)
        }
    }
    else if (is.double({{ string }}) == TRUE) {
        return({{ string }})
    }
    else {
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
#' @param errors 'raise', 'coerce', default 'raise'
#'                If 'raise', then invalid parsing will raise an exception.
#'                If 'coerce', then invalid parsing will return NA.
#'
#' @return dataframe with formatting applied
#' @export
#'
#' @examples
#' to_df(df, col_names = c("A", "B"), transform_type = "human")
to_df <- function(df, col_names = NULL, transform_type = "human", family = "number", errors = "raise", ...) {
    if (is.null(col_names)) {
        col_names <- colnames(df)
    }

    # Check inputs for errors
    if (!is.data.frame(df)) {
        err <- "Wrong input type for df, must be a dataframe!"
        return(throw_err(err, errors))
    }

    if (!is.character(col_names) || !is.vector(col_names)) {
        err <- "Wrong input type for col_names, must be a character or character vector!"
        return(throw_err(err, errors))
    }

    if (sum(is.element(col_names, colnames(df))) != length(col_names)) {
        err <- "One or more col_names missing from input df!"
        return(throw_err(err, errors))
    }

    if (!is.element(transform_type, c("human", "num"))) {
        err <- "Wrong input for transform type, try 'human' or 'num'"
        return(throw_err(err, errors))
    }

    # Function body
    if (transform_type == "human") {
        for (col in col_names){
            col <- sym(col)
            df <- df %>%  mutate({{ col }} := map(!!col, to_human, ...))
        }

    } else if (transform_type == "num") {
        for (col in col_names){
            col <- sym(col)
            df <- df %>%  mutate({{ col }} := map(!!col, to_numeric, ...))
        }
    }

    return(df)
}

#' Give all parts of the number with different colors
#'
#' @param number integer
#' @param colors vector of different colors
#'
#' @return vector of colored int
#' @export
#'
#' @examples
#' to_color(1234567L, c("red", "green", "yellow", "blue"))
to_color <- function(number, colors = c("red", "green", "yellow", "blue")) {
    if (!is.integer(number)) {
        stop("Can only support integer number")
    }

    n_str <- unlist(strsplit(as.character(number), ""))

    col_escape <- function(col) {
        paste0("\033[", col, "m")
    }

    palettes <- c(
        "black" = "30",
        "red" = "31",
        "green" = "32",
        "yellow" = "33",
        "blue" = "34",
        "purple" = "35",
        "cyan" = "36",
        "light gray" = "37"
    )

    ans <- ""
    for (i in seq_along(n_str)) {
        col <- palettes[tolower(colors[i %% length(colors) + 1])]
        init <- col_escape(col)
        reset <- col_escape("0")
        tmp <- paste0(init, n_str[i], reset)
        ans <- paste0(ans, tmp)
    }

    ans
}
