% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/main.R
\name{get_univarCox_result}
\alias{get_univarCox_result}
\title{Get univarCox result.}
\usage{
get_univarCox_result(freq_matrix, sur)
}
\arguments{
\item{freq_matrix}{The mutations matrix,generated by `get_mut_status`.}

\item{sur}{A nx2 data frame of samples' survival data,the first line is samples' survival event and the second line is samples' overall survival.}
}
\value{
The result of Cox univariate analysis.
}
\description{
The function `get_univarCox_result` is used to calculate the result of Cox univariate analysis.
}
\examples{
\donttest{#load the data
data(mut_status)
sur<-system.file("extdata","sur.csv",package ="ProgModule")
sur<-read.delim(sur,sep=",",header=TRUE,row.names=1)
#perform the function `get_univarCox_result`.
univarCoxresult.example<-get_univarCox_result(freq_matrix=mut_status,sur)}
}
