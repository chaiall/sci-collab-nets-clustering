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
require(flexclust)

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

#modularity matrix
B=A-1/(2*m)*K%*%t(K)
evv = eigen(B,symmetric=TRUE)
#print(modularity(A,cl$cluster))

#eigenvector corresp. largest eigenvalue
c=2

computeClusters <- function(A,v,c)
{
    cl <- kmeans(v,c)
    print(modularity(A,cl$cluster))
    showGraph(A,g,l,cl$cluster,'Spectral Clustering')
}

computeClusters(A,evv$vectors[,1],c)



