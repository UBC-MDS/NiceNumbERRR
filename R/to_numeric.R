#' Convert human-readable string to numeric number
#'
#' @param string string
#' @param family family of suffix, numeric or filesize
#' @param custom_suff List of custom suffixes, default None
#' @param errors 'raise', 'coerce', default 'raise'
#'                If 'raise', then invalid parsing will raise an exception.
#'                If 'coerce', then invalid parsing will return NA.
#'
#' @return a computer-readable numeric number
#' @export
#'
#' @examples to_numeric("69.4K")
#' 69400
#'
to_human <- function(string,  family = "numeric") {
}
