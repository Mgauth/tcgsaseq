% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/voom_weights.R
\name{voom_weights}
\alias{voom_weights}
\title{Precision weights accounting for heteroscedasticity in RNA-seq count data}
\usage{
voom_weights(y, x, preprocessed = FALSE, doPlot = FALSE,
  lowess_span = 0.5)
}
\arguments{
\item{y}{a matrix of size \code{G x n} containing the raw RNA-seq counts or
preprocessed expressions from \code{n} samples for \code{G} genes.}

\item{x}{a matrix of size \code{n x p} containing the model covariates from
\code{n} samples (design matrix).}

\item{preprocessed}{a logical flag indicating whether the expression data have
already been preprocessed (e.g. log2 transformed). Default is \code{FALSE}, in
which case \code{y} is assumed to contain raw counts and is normalized into
log(counts) per million.}

\item{doPlot}{a logical flag indicating whether the mean-variance plot should be drawn.
Default is \code{FALSE}.}

\item{lowess_span}{smoother span for the lowess function, between 0 and 1. This gives
the proportion of points in the plot which influence the smooth at each value.
Larger values give more smoothness. Default is \code{0.5}.}
}
\value{
a vector of length \code{n} containing the computed precision weights
}
\description{
Implementation of the procedure described in Law \emph{et al.} for estimating precision
weights from RNA-seq data.
}
\examples{
#rm(list=ls())
set.seed(123)

G <- 10000
n <- 12
p <- 2

y <- sapply(1:n, FUN=function(x){rnbinom(n=G, size=0.07, mu=200)})
x <- sapply(1:p, FUN=function(x){rnorm(n=n, mean=n, sd=1)})

my_w <-  voom_weights(y, x, doPlot=TRUE)
if (requireNamespace("limma", quietly = TRUE)) {
 w_voom <- limma::voom(counts=y, design=x, plot=TRUE) #slightly faster - same results
 all.equal(my_w, w_voom$weights)
}

\dontrun{
microbenchmark::microbenchmark(limma::voom(counts=t(y), design=x, plot=FALSE),
                              voom_weights(x, y, doPlot=FALSE), times=30)}

}
\references{
Law, C. W., Chen, Y., Shi, W., & Smyth, G. K. (2014). voom: Precision
weights unlock linear model analysis tools for RNA-seq read counts. \emph{Genome
Biology}, 15(2), R29.
}
\seealso{
\code{\link{lowess}}  \code{\link{approxfun}}  \code{\link[limma]{voom}}
}
