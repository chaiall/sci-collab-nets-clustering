library('Matrix')
#svd for large matrices
#library('irlba')

#Jie:#data<-read.table("/home/jie/work/out3.txt");
data<-read.table('out3.txt');

#read authors
#source('read-authors.R')
#load tictoc
#source('tictoc.R')

n = nrow(data);

#max_num:1030712
max_num = max(data[,1:2]);
#tic()
A = sparseMatrix(i=c(data[,1],data[,2]),j=c(data[,2],data[,1]),x=c(data[,3],data[,3]))
#toc()

