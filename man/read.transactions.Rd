\name{read.transactions}
\alias{read.transactions}
\title{Read Transaction Data}
\description{
  Reads a transaction data file from disk and creates a
  \code{\linkS4class{transactions}} object.
}
\usage{
read.transactions(file, format = c("basket", "single"), sep = NULL,
                  cols = NULL, rm.duplicates = FALSE, encoding = "unknown")
}
\arguments{
  \item{file}{the file name.}
  \item{format}{a character string indicating the format of the data
    set.  One of \code{"basket"} or \code{"single"}, can be
    abbreviated.}
  \item{sep}{a character string specifying how fields are separated in
    the data file, or \code{NULL} (default).  For basket format, this
    can be a regular expression; otherwise, a single character must be
    given.  The default corresponds to white space separators.}
\item{cols}{For the \sQuote{single} format, \code{cols} is a 
    numeric or character vector of length two giving the numbers or
    names of the columns (fields) with the transaction and item ids,
    respectively. If character, the first line of \code{file} is assumed
    to be a header with column names.
    For the \sQuote{basket} format, \code{cols} can be a numeric scalar
    giving the number of the column (field) with the transaction ids.
    If \code{cols = NULL}, the data do not contain transaction ids.}
\item{rm.duplicates}{a logical value specifying if duplicate items should
    be removed from the transactions.}
\item{encoding}{character string indicating the encoding which is passed to
\code{readlines} (see \code{Encoding}).}
}
\details{
  For \sQuote{basket} format, each line in the transaction data file
  represents a transaction where the items (item labels) are separated
  by the characters specified by \code{sep}.  For \sQuote{single}
  format, each line corresponds to a single item, containing at least
  ids for the transaction and the item.
}
\value{
  Returns an object of class
  \code{\linkS4class{transactions}}.
}
\seealso{
  \code{\link{transactions-class}}
}
\examples{
## create a demo file using basket format for the example
data <- paste("item1,item2","item1","item2,item3", sep="\n")
cat(data)
write(data, file = "demo_basket")

## read demo data
tr <- read.transactions("demo_basket", format = "basket", sep=",")
inspect(tr)


## create a demo file using single format for the example
## column 1 contains the transaction ID and column 2 contains one item
data <- paste("trans1 item1", "trans2 item1","trans2 item2", sep ="\n")
cat(data)
write(data, file = "demo_single")

## read demo data
tr <- read.transactions("demo_single", format = "single", cols = c(1,2))
inspect(tr)


## tidy up
unlink("demo_basket")
unlink("demo_single")

}
\keyword{file}
