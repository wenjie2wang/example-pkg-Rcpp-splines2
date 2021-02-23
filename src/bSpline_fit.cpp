#include <RcppArmadillo.h>
// [[Rcpp::plugins(cpp11)]]

// include header file from splines2 package
#include <splines2Armadillo.h>

// convert arma vector type to Rcpp vector type
template <typename T>
inline Rcpp::NumericVector arma2rvec(const T& x) {
    return Rcpp::NumericVector(x.begin(), x.end());
}

// [[Rcpp::export]]
Rcpp::List rcpp_bSpline_fit(const arma::vec& x,
                            const arma::vec& y,
                            const unsigned int df,
                            const unsigned int degree,
                            const arma::vec& boundary_knots)
{
    // BSpline object
    splines2::BSpline bs_obj {
        x, df, degree, boundary_knots
    };
    // get B-spline basis functions
    arma::mat bs_mat { bs_obj.basis(true) };
    // compute their first derivatives
    arma::mat dbs_mat { bs_obj.derivative(1, true) };
    // linear regression
    arma::vec beta { inv_sympd(bs_mat.t() * bs_mat) * (bs_mat.t() * y) };
    arma::vec y_hat { bs_mat * beta };
    arma::vec deriv_y_hat { dbs_mat * beta };
    arma::vec resid { y - y_hat };
    return Rcpp::List::create(
        Rcpp::Named("coefficients") = arma2rvec(beta),
        Rcpp::Named("fitted.values") = arma2rvec(y_hat),
        Rcpp::Named("residuals") = arma2rvec(resid),
        Rcpp::Named("derivatives") = arma2rvec(deriv_y_hat));
}
