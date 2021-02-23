Example Package using splines2 with Rcpp
================

[![Build Status][gha-icon]][gha-url]

Since v0.3.0, the **[splines2][splines2-github]** package provides C++ interface
for constructing regression spline basis functions.  This repository contains an
example package that demonstrates its usage with help of **Rcpp**.

## Get Started

Firstly, in `DESCRIPTION`, we need

- include `Rcpp` in `Imports`
- include `Rcpp`, `RcppArmadillo`, and `splines2 (>=0.3.0)` in `LinkingTo`

Secondly, we need add the following lines to a C++ script:

```C++
#include <RcppArmadillo.h>
// [[Rcpp::plugins(cpp11)]]

// include header file from splines2 package
#include <splines2Armadillo.h>
```

Then we have access to the routines to create spline basis functions under name
space named `splines2`.  For example, we may create a default B-spline object as
follows:

```C++
splines2::BSpline bs_obj;
```

See one of the **splines2** package vignettes for more detailed introduction to
the C++ interface.


[splines2-github]: https://github.com/wenjie2wang/splines2
[gha-icon]: https://github.com/wenjie2wang/example-pkg-Rcpp-splines2/workflows/R-CMD-check/badge.svg
[gha-url]: https://github.com/wenjie2wang//actions
