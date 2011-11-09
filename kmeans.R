source('readfile_sparse.R')

for( c in 2:5)
{
    K=kmeans(B,centers=c)
    print(K$size)
}

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
