\name{subset}
\alias{subset}
\alias{subset,itemsets-method}
\alias{subset,itemMatrix-method}
\alias{subset,rules-method}
\alias{subset,transactions-method}
\title{Subsetting Itemsets, Rules and Transactions}
\description{
  Provides the generic function \code{subset} and S4 methods to 
  subset associations or 
  transactions 
  which meet certain conditions (e.g., contains certain items or 
  satisfies a minimum lift).
}
\usage{
subset(x, ...)

\S4method{subset}{itemMatrix}(x, subset, ...)

\S4method{subset}{itemsets}(x, subset, ...)

\S4method{subset}{rules}(x, subset, ...)

\S4method{subset}{transactions}(x, subset, ...)
}
\arguments{
  \item{x}{object to be subsetted.}
  \item{subset}{logical expression indicating elements to keep.}
  \item{\dots}{further arguments to be passed to or from other methods.}
}
\value{
An object of the same class as \code{x} containing only the
elements which satisfy the conditions.
}
\seealso{
  \code{\link{itemsets-class}},
  \code{\link{rules-class}},
  \code{\link{transactions-class}}
}
\examples{
data("Adult_transactions")
rules <- apriori(Adult_transactions)

### subset the rules
rules.sub <- subset(rules, subset = rhs \%in\% "Never-married" & lift > 2)
}
\keyword{manip}