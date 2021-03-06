#######################################################################
# arules - Mining Association Rules and Frequent Itemsets
# Copyright (C) 2011, 2012 Michael Hahsler, Christian Buchta, 
#			Bettina Gruen and Kurt Hornik
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.



##*******************************************************
## Virtual class associations
##
## vitual class which defines the (and implements some) common 
## functionality for associations (e.g., rules, itemsets)


##************************************************
## common methods

## accessors for quality and info
setMethod("quality", signature(x = "associations"),
  function(x) {
    x@quality
  })

setReplaceMethod("quality", signature(x = "associations"),
  function(x, value) {
    x@quality <- value
    validObject(x)
    x
  })

setMethod("info", signature(x = "associations"),
  function(x) {
    x@info
  })

setReplaceMethod("info", signature(x = "associations"),
  function(x, value) {
    x@info <- value
    ## no need validObject(x)
    x
  })


## sort + unique
## since R 2.4.0 sort is a generic
setMethod("sort", signature(x = "associations"),
  function (x, decreasing = TRUE, na.last = NA, by = "support", ...) {
    if(length(x) == 0) return(x)
    q <- x@quality[[by]]
    if(is.null(q)) stop("Unknown interest measure to sort by.")
    
    x[order(q, na.last = na.last, decreasing = decreasing, ...)]
  })

## SORT is just for backward compatibility and since 
## we want decreasing = TRUE   
setMethod("SORT", signature(x = "associations"),
  function (x, by = "support", na.last = NA, decreasing = TRUE) {
    warning("arules: SORT is deprecated use sort instead.")
    sort(x, decreasing, na.last, by)
  })


## this needs a working implementation of duplicated for the 
## type of associations
setMethod("unique", signature(x = "associations"),
  function(x,  incomparables = FALSE, ...) {
    x[!duplicated(x, incomparables = incomparables, ...)]
  })

## show
setMethod("show", signature(object = "associations"),
  function(object) {
    cat("set of",length(object),class(object),"\n")
    invisible(NULL)
  })

## no t for associations
setMethod("t", signature(x = "associations"),
  function(x) {
    stop("Object not transposable!")  
  })


##************************************************
## implementations of associations must provide minimal interface

setMethod("items", signature(x = "associations"),
  function(x) {
    stop(paste("Method items not implemented for class", class(x),"\n"))
  })

setMethod("length", signature(x = "associations"),
  function(x) {
    stop(paste("Method length not implemented for class", class(x),"\n"))
  })

setMethod("labels", signature(object = "associations"),
  function(object) {
    stop(paste("Method duplicated not implemented for class", class(object),"\n"))
  })

