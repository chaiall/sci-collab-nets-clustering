data<-read.table('subset.txt');
n=max(data[,1:2])

A = matrix(0,n,n);
for( i in 1:n )
    A[data[i,1],data[i,2]]=data[i,3]
A = A+t(A)

#remove the lines where all elements are 0
ind=which(rowSums(A)>0)
A = A[ind,ind]
n=nrow(A)
