% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nloptrbundled-package.R
\docType{package}
\name{nloptrbundled-package}
\alias{nloptrbundled}
\alias{nloptrbundled-package}
\title{Bundled NLopt for R}
\description{
nloptr is an R interface to NLopt, a free/open-source library for nonlinear
optimization started by Steven G. Johnson, providing a common interface for
a number of different free optimization routines available online as well as
original implementations of various other algorithms. The NLopt library is
available under the GNU Lesser General Public License (LGPL), and the
copyrights are owned by a variety of authors. Most of the information here
has been taken from
\href{https://nlopt.readthedocs.io/en/latest/}{the NLopt website},
where more details are available.
}
\details{
NLopt addresses general nonlinear optimization problems of the form:

\deqn{\min f(x)\quad x\in R^n}{min f(x) x in R^n}

\deqn{\textrm{s.t. }\\ g(x) \leq 0\\ h(x) = 0\\ lb \leq x \leq ub}{
s.t.  g(x) <= 0 h(x) = 0 lb <= x <= ub}

where \eqn{f(x)} is the objective function to be minimized and \eqn{x}
represents the \eqn{n} optimization parameters. This problem may optionally
be subject to the bound constraints (also called box constraints), \eqn{lb}
and \eqn{ub}. For partially or totally unconstrained problems the bounds can
take \code{-Inf} or \code{Inf}. One may also optionally have \eqn{m}
nonlinear inequality constraints (sometimes called a nonlinear programming
problem), which can be specified in \eqn{g(x)}, and equality constraints that
can be specified in \eqn{h(x)}. Note that not all of the algorithms in NLopt
can handle constraints.

An optimization problem can be solved with the general \code{nloptr}
interface, or using one of the wrapper functions for the separate algorithms;
\code{auglag}, \code{bobyqa}, \code{ccsaq}, \code{cobyla}, \code{crs2lm},
\code{direct}, \code{directL}, \code{isres}, \code{lbfgs}, \code{mlsl},
\code{mma}, \code{neldermead}, \code{newuoa}, \code{sbplx}, \code{slsqp},
\code{stogo}, \code{tnewton}, \code{varmetric}.

\tabular{ll}{Package: \tab nloptr\cr Type: \tab Package\cr Version: \tab
2.0.3\cr Date: \tab 2022-05-26\cr License: \tab L-GPL >= 3\cr}
}
\note{
See ?nloptrbundled for more examples.
}
\examples{

# Example problem, number 71 from the Hock-Schittkowsky test suite.
#
# \min_{x} x1 * x4 * (x1 + x2 + x3) + x3
# s.t.
#    x1 * x2 * x3 * x4 >= 25
#    x1 ^ 2 + x2 ^ 2 + x3 ^ 2 + x4 ^ 2 = 40
#    1 <= x1, x2, x3, x4 <= 5
#
# we re-write the inequality as
#   25 - x1 * x2 * x3 * x4 <= 0
#
# and the equality as
#   x1 ^ 2 + x2 ^ 2 + x3 ^ 2 + x4 ^ 2 - 40 = 0
#
# x0 = (1, 5, 5, 1)
#
# optimal solution = (1.000000, 4.742999, 3.821151, 1.379408)

#
# f(x) = x1 * x4 * (x1 + x2 + x3) + x3
#
eval_f <- function(x) {
    list("objective" = x[1] * x[4] * (x[1] + x[2] + x[3]) + x[3],
         "gradient" = c(x[1] * x[4] + x[4] * (x[1] + x[2] + x[3]),
                        x[1] * x[4],
                        x[1] * x[4] + 1.0,
                        x[1] * (x[1] + x[2] + x[3])))
}

# constraint functions
# inequalities
eval_g_ineq <- function(x) {
    constr <- c(25 - x[1] * x[2] * x[3] * x[4])

    grad   <- c(-x[2] * x[3] * x[4],
                -x[1] * x[3] * x[4],
                -x[1] * x[2] * x[4],
                -x[1] * x[2] * x[3] )
    list("constraints" = constr, "jacobian" = grad)
}

# equalities
eval_g_eq <- function(x) {
    constr <- c(x[1] ^ 2 + x[2] ^ 2 + x[3] ^ 2 + x[4] ^ 2 - 40)

    grad <- c(2.0 * x[1],
              2.0 * x[2],
              2.0 * x[3],
              2.0 * x[4])
    list("constraints" = constr, "jacobian" = grad)
}

# initial values
x0 <- c(1, 5, 5, 1)

# lower and upper bounds of control
lb <- c(1, 1, 1, 1)
ub <- c(5, 5, 5, 5)


local_opts <- list("algorithm" = "NLOPT_LD_MMA", "xtol_rel"  = 1.0e-7)
opts <- list("algorithm"  = "NLOPT_LD_AUGLAG",
             "xtol_rel"   = 1.0e-7,
             "maxeval"    = 1000,
             "local_opts" = local_opts)

res <- nloptr(x0 = x0,
              eval_f = eval_f,
              lb = lb,
              ub = ub,
              eval_g_ineq = eval_g_ineq,
              eval_g_eq = eval_g_eq,
              opts = opts)
print(res)
}
\references{
Steven G. Johnson, The NLopt nonlinear-optimization package,
\url{https://nlopt.readthedocs.io/en/latest/}
}
\seealso{
\code{\link{optim}} \code{\link{nlm}} \code{\link{nlminb}}
\code{Rsolnp::Rsolnp} \code{Rsolnp::solnp} \code{\link{nloptr}}
\code{\link{auglag}} \code{\link{bobyqa}}  \code{\link{ccsaq}}
\code{\link{cobyla}} \code{\link{crs2lm}} \code{\link{direct}}
\code{\link{directL}} \code{\link{isres}} \code{\link{lbfgs}}
\code{\link{mlsl}} \code{\link{mma}} \code{\link{neldermead}}
\code{\link{newuoa}} \code{\link{sbplx}} \code{\link{slsqp}}
\code{\link{stogo}} \code{\link{tnewton}} \code{\link{varmetric}}
}
\author{
Steven G. Johnson and others (C code) \cr Jelmer Ypma (R interface)
\cr Hans W. Borchers (wrappers)
}
\keyword{interface}
\keyword{internal}
\keyword{optimize}
