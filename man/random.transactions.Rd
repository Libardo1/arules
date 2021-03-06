\name{random.transactions}
\alias{random.transactions}
\alias{random.patterns}
\title{Simulate a Random Transaction Data Set}
\description{
  Simulates a random \code{\linkS4class{transactions}} object using different
  methods.
}
\usage{
random.transactions(nItems, nTrans, method = "independent", \ldots,
	verbose = FALSE)
}
\arguments{
  \item{nItems}{an integer. Number of items.}
  \item{nTrans}{an integer. Number of transactions.}
  \item{method}{name of the simulation method used (default: 
    all items occur independently).}  
  \item{\ldots}{further arguments used for the specific simulation 
    method (see details).}
  \item{verbose}{report progress.} 
}
\details{
  The function generates a \code{nitems} times \code{ntrans} 
  transaction database.
  
  Currently two simulation methods are implemented:
  \describe{
    \item{method \code{"independent"} (see Hahsler et al., 2005)}{
      All items are treated as independent. 
      Each transaction is the result of \code{nItems} independent 
      Bernoulli trials, one for each item with success 
      probabilities given by the numeric 
      vector \code{iProb} of length \code{nItems} 
      (default: 0.01 for each item).
  }
  \item{method \code{"agrawal"} (see Agrawal and Srikant, 1994)}{
      This method creates transactions with correlated items 
         uses the following additional parameters:
      \describe{
      \item{lTrans}{average length of transactions.} 
      \item{nPats}{number of patterns (potential maximal frequent itemsets) 
	used.} 
      \item{lPats}{average length of patterns.} 
      \item{corr}{correlation between consecutive patterns.} 
      \item{cmean}{mean of the corruption level (normal distr.).} 
      \item{cvar}{variance of the corruption level.} 
      }  

      The simulation is a two-stage process. First, a set of
      \code{nPats} patterns
      (potential maximal frequent itemsets) is generated. 
      The length of the patterns is Poisson distributed with mean
      \code{lPats} and consecutive patterns share some items controlled by
      the correlation parameter \code{corr}.
      For later use, for each pattern a pattern weight is 
      generated by drawing 
      from an exponential distribution with a mean of 1 and
      a corruption level is chosen from a normal distribution 
      with mean \code{cmean} and variance \code{cvar}.
      
      The patterns are created using the following function:
     
      \code{random.patterns(nItems, nPats = 2000,  method = "agrawal", lPats = 4, corr = 0.5, cmean = 0.5, cvar = 0.1, iWeight = NULL, verbose = FALSE)}
     
     The function returns the patterns as an \code{itemsets} objects which can 
     be supplied to \code{random.transactions} as the argument \code{patterns}.
     If no argument \code{patterns} is supplied, the default values given above
     are used.
     
     In the second step, the transactions are generated using the patterns.
     The length the transactions follows a Poisson 
     distribution with mean \code{lPats}. For each transaction, patterns are 
     randomly chosen using the pattern weights till the transaction length
     is reached. For each chosen 
     pattern, the associated corruption level is used to drop some
     items before adding the pattern to the transaction.
  }
  }
}
\value{
  Returns an object of class
  \code{\linkS4class{transactions}}.
}
\seealso{
  \code{\link{transactions-class}}.
}
\references{
Michael Hahsler, Kurt Hornik, and Thomas Reutterer (2006). Implications of
probabilistic data modeling for mining association rules. In M. Spiliopoulou,
R. Kruse, C. Borgelt, A. Nuernberger, and W. Gaul, editors, \emph{From Data and
Information Analysis to Knowledge Engineering, Studies in Classification, Data
Analysis, and Knowledge Organization}, pages 598--605. Springer-Verlag.

Rakesh Agrawal and Ramakrishnan Srikant (1994). Fast algorithms for mining
association rules in large databases. In Jorge B. Bocca, Matthias Jarke, and
Carlo Zaniolo, editors,  \emph{Proceedings of the 20th International Conference
on Very Large Data Bases, VLDB}, pages 487--499, Santiago, Chile.
}
\examples{
## generate random 1000 transactions for 200 items with 
## a success probability decreasing from 0.2 to 0.0001
## using the method described in Hahsler et al. (2006).
trans <- random.transactions(nItems = 200, nTrans = 1000, 
   iProb = seq(0.2,0.0001, length=200))

## display random data set
image(trans)

## use the method by Agrawal and Srikant (1994) to simulate transactions 
## which contains correlated items. This should create data similar to
## T10I4D100K (just only 1000 transactions)
patterns <- random.patterns(nItems = 1000)
summary(patterns)

trans2 <- random.transactions(nItems = 1000, nTrans = 1000, 
   method = "agrawal", patterns = patterns)
image(trans2) 

## plot data with items ordered by item frequency
image(trans2[,order(itemFrequency(trans2), decreasing=TRUE)])

}
\keyword{datagen}
