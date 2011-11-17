#option 1: read the whole matrix
#source('readfile_sparse.R')
#source('read-authors.R')

#option 2: read subset matrix
#source('read-subset.R')
#source('read-authors.R')

#option 3: read cs umass matrix
source('read-csumass.R')
#source('read-authors.R')

#additional libraries
source('plot-graph.R')

ret <- initGraph(A>0)
g <<- ret$g
l <<- ret$l
gplot(g,layout=l,main="UMASS CS Collaboration Graph 2011")

#option 0: A is weighted (default, comment make-unweighted.R)
#option 1: A is unweighted (binary)
source('make-unweighted.R')

#option 2: A is normalized
#D=rowSums(A)
#n=nrow(A)
#A = diag(as.vector(1/D),n)%*%A

source('modularity.R')

K = rowSums(A)
Dinv = diag(1/K)
D= diag(K)
n = nrow(A)
m = sum(K)/2;

#edge betweenness algorithm
#TODO: if we use this, we probably want to calculate betweenness in an
#approximate way and also to limit the number of splits
ebc <- edge.betweenness.community(g)

#eigenvector corresp. largest eigenvalue
c=2

computeClusters <- function(A,c)
{
    memb = community.to.membership(g,ebc$merges,n-c)$membership + 1

    print(modularity(A,memb))
    showGraph(A,g,l,memb,'Edge Betweenness')
}

computeClusters(A,c)



