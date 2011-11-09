#option 1: read the whole matrix
#source('readfile_sparse.R')
library('flexclust')

#option 2: read subset matrix
data<-read.table('subset.txt');
n=max(data[,1:2])
A = matrix(0,n,n);
for( i in 1:n )
    A[data[i,1],data[i,2]]=data[i,3]
A = A+t(A)

#remove the lines where all elements are 0
ind=c(1:n)[A%*%rep(1,n)>0]
B = A[ind,ind]


for( c in 2:5)
{
#    K=kmeans(B,c)
#    print(K$size)
    K=kcca(B,c,family=kccaFamily('angle'))
}
sort(authors[ind[c(1:718)[clusters(K)==1]]])
#kcca
#kmedians: nop
#angle: gets clusters approximately of the same size



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
