% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/VS.R
\name{VS}
\alias{VS}
\title{Function to perform variable selection}
\usage{
VS(x, method = "FDR", threshold = NA, subgroup = 1)
}
\arguments{
\item{x}{fitted object obtained with \code{BayesSurvive}, or a matrix/array,
or a list consisting of matrices and arrays}

\item{method}{variable selection method to choose from
\code{c("CI", "SNC", "MPM", "FDR")}. Default is "FDR"}

\item{threshold}{SNC threshold value (default 0.5) or the Bayesian expected
false discovery rate threshold (default 0.05)}

\item{subgroup}{index(es) of subgroup(s) for visualizing variable selection}
}
\value{
A boolean vector of selected (= TRUE) and rejected (= FALSE)
variables for one group or a list for multiple groups
}
\description{
Perform variable selection using the 95% credible interval (CI), scaled
neighborhood criterion (SNC), median probability model (MPM) or Bayesian
false discovery rate (FDR). Note that the Bayesian FDR only applies for each
subgroup if there are subgroups.
}
\examples{

library("BayesSurvive")
set.seed(123)

# Load the example dataset
data("simData", package = "BayesSurvive")

dataset <- list(
  "X" = simData[[1]]$X,
  "t" = simData[[1]]$time,
  "di" = simData[[1]]$status
)

# Initial value: null model without covariates
initial <- list("gamma.ini" = rep(0, ncol(dataset$X)))
# Hyperparameters
hyperparPooled <- list(
  "c0"     = 2, # prior of baseline hazard
  "tau"    = 0.0375, # sd for coefficient prior
  "cb"     = 20, # sd for coefficient prior
  "pi.ga"  = 0.02, # prior variable selection probability for standard Cox models
  "a"      = -4, # hyperparameter in MRF prior
  "b"      = 0.1, # hyperparameter in MRF prior
  "G"      = simData$G # hyperparameter in MRF prior
)

\donttest{
# run Bayesian Cox with graph-structured priors
fit <- BayesSurvive(
  survObj = dataset, hyperpar = hyperparPooled,
  initial = initial, nIter = 50, burnin = 30
)
# show variable selection
VS(fit, method = "FDR")
}

}
\references{
Lee KH, Chakraborty S, Sun J (2015). Survival prediction and variable
selection with simultaneous shrinkage and grouping priors. Statistical
Analysis and Data Mining, 8:114-127

Newton MA, Noueiry A, Sarkar D, Ahlquist P (2004). Detecting differential
gene expression with a semiparametric hierarchical mixture method.
Biostatistics, 5(2), 155-76
}
