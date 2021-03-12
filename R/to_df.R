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
