#' Change the formatting of data in column(s) of a dataframe to either human readable or numeric
#'
#' @param df dataframe, df to apply formatting
#' @param col_names list or str, column names to change, default is all columns
#' @param transform_type str, type of transformation
#' @param family str, family of suffix, numeric or filesize
#'
#' @return dataframe with formatting applied
#' @export
#'
#' @examples to_df(df, col_names=['A', 'B', 'C'], transform_type='human')
#'
#'
to_df <- function(df, col_names, transform_type = 'human', family = "numeric") {

}
