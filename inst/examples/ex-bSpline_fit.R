library(example.pkg.Rcpp.splines2)

## an example curve
foo <- function(x) {
    (1 - x + 2 * x ^ 2) * exp(- 0.2 * x ^ 2)
}
## generate some random samples
set.seed(123)
n <- 200
x <- runif(n, - 4, 4)
y <- foo(x) + rnorm(n, sd = 0.5)

## 1. use the written Rcpp function
res1 <- bSpline_fit(x, y, df = 6)

## 2. equivalent R code
bs_mat <- splines::bs(x, df = 6, intercept = TRUE)
res2 <- lm.fit(bs_mat, y)

all.equal(res1$coefficients, res2$coefficients, check.attributes = FALSE)
all.equal(res1$fitted.values, res2$fitted.values, check.attributes = FALSE)

if (requireNamespace("microbenchmark", quietly = TRUE)) {
    library(microbenchmark)
    microbenchmark(
        "Rcpp" = bSpline_fit(x, y, df = 6),
        "base R" = lm.fit(splines::bs(x, df = 6, intercept = TRUE), y)
    )
}
