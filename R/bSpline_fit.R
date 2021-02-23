##' One Dimensional Curve Fitting with B-splines
##'
##' Fits one dimensional curve with B-splines and returns fitted values and
##' residuals.
##'
##' @param x A numeric vector representing the predictor.
##' @param y A numeric vector representing the response variable.
##' @param df An integer representing the degrees of freedom of the spline bases
##'     (including the intercept term).
##' @param degree A non-negative integer representing the degree of the
##'     piecewise polynomial.
##' @param boundary_knots An optional numeric vector (of length two) for
##'     boundary knots.  By default, they are the range of the non-\code{NA}
##'     data.
##'
##' @return
##' A list with named elements:
##'
##' - `coefficients`: estimated coefficients.
##' - `fitted.values`: fitted y values.
##' - `residuals`: residuals.
##' - `derivatives`: estimated derivatives.
##'
##' @example inst/examples/ex-bSpline_fit.R
##'
##' @export
bSpline_fit <- function(x, y, df, degree = 3,
                        boundary_knots = numeric())
{
    rcpp_bSpline_fit(x, y, df, degree, boundary_knots)
}
