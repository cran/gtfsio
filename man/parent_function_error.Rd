% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gtfsio_error.R
\name{parent_function_error}
\alias{parent_function_error}
\title{Parent error function constructor}
\usage{
parent_function_error(message, subclass = character(0))
}
\arguments{
\item{message}{The message to inform about the error.}

\item{subclass}{The subclass of the error.}
}
\description{
Creates a function that raises an error that is assigned to the function in
which the error was originally seen. Useful to prevent big repetitive
\code{gtfsio_error()} calls in the "main" functions.
}
\seealso{
Other error constructors: 
\code{\link{gtfsio_error}()}
}
\concept{error constructors}
\keyword{internal}
