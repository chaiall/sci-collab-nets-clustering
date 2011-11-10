#option 1: read the whole matrix
#source('readfile_sparse.R')
#source('readauthors.R')

#option 2: read subset matrix
#source('read-subset.R')
#source('readauthors.R')

#option 3: read cs umass matrix
source('read-csumass.R')
source('readauthors.R')

#additional libraries
library('flexclust')

print(1)

n=nrow(A)
for( c in 2:5 )
{
#    K=kmeans(B,c)
    K=kcca(A,c,family=kccaFamily('kmedians'))
}
c=3
K=kcca(A,c,family=kccaFamily('angle'))
sort(authors[ind[c(1:n)[clusters(K)==1]]])
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
