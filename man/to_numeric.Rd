% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nicenumberrr.R
\name{to_numeric}
\alias{to_numeric}
\title{Convert human-readable string to numeric number}
\usage{
to_numeric(string, family = "number", errors = "raise", custom_suff = NULL)
}
\arguments{
\item{string}{string}

\item{family}{family of suffix, numeric or filesize}

\item{errors}{'raise', 'coerce', default 'raise'
If 'raise', then invalid parsing will raise an exception.
If 'coerce', then invalid parsing will return NA.}

\item{custom_suff}{List of custom suffixes, default NULL}
}
\value{
a computer-readable numeric number
}
\description{
Convert human-readable string to numeric number
}
\examples{
to_numeric("69.4K")
69400
}
