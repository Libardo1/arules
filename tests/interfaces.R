library("arules")

data <- list(
    c("a","b","c"),
    c("a","b"),
    c("a","b","d"),
    c("b","e"),
    c("a","c"),
    c("c","e"),
    c("a","b","d","e"),
    )
names(data) <- paste("Tr",c(1:7), sep = "")
t <- as(data, "transactions")


##########################################################
# test the apriori interface

### rules
r <- apriori(t, parameter=list(supp=0.25, conf=0))
r
summary(r)
inspect(SORT(r, by = "lift")[1:2])

### test appearance
r <- apriori(t, parameter=list(supp=0.25, conf=0),
     appearance=list(rhs=c("a","b"), default= "lhs"))
inspect(r)

### test lhs.support
r <- apriori(t, parameter=list(supp=0.25, conf=0, originalSupp=FALSE, ext=TRUE))
inspect(r[1:2])




##########################################################
# test the eclat interface

f <- eclat(t)
f
summary(f)
inspect(f[1:2])
labels(f[1:2])


### test subset
f.sub <- subset(f, subset=items %in% "a")
labels(f.sub)

### test tidlists
f <- eclat(t, parameter = list(tidLists = TRUE))
f
summary(f)
tl <- tidLists(f)
tl
summary(tl)

as(tl[1:5], "list")


