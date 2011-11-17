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
#source('make-unweighted.R')

#option 2: A is normalized
#D=rowSums(A)
#n=nrow(A)
#A = diag(as.vector(1/D),n)%*%A

#base option 1: e$vectors
#e=eigen(A)
#B = A%*%e$vectors;

#base option 2: random projection E
r=10
E=matrix(rnorm(n*r,0,1),n,r)
B = A%*%E;

computeClusters <- function(A,method,c)
{
    K=kcca(A,c,family=kccaFamily(method))
    showGraph(A,g,l,clusters(K),method)
}

computeClusters(B,'kmedians',2)



#kcca
#kmedians: 1 big cluster and other small clusters
#angle: jim and don in different clusters!
#jaccard: 1 big  cluster
#ejaccard: jim and don in diff clusters




#regular kmeans
#It does not work very well
#Possible explanations:
#A) I may be using a bad representation of authors, I may need to use more singular
#values or it is just wrong to use the vectors u (from SVD)
#B) k-means does not work in high dimensional datasets
#C) Euclidean distance is not a good distance metric

#[1]      27 1030685
#[1]      13 1030686      13
#[1]      12       6       8 1030686
#[1]       5 1030686      11       5       5
