source('readfile_sparse.R')
source('tictoc.R')

for( i in 5:10 )
{
    tic()
    S = irlba(A,nu=i,nv=i)
    toc()
}
#elapsed 
# 38.091 
#elapsed 
# 36.728 
#elapsed 
# 46.678 
#elapsed 
# 55.591 
#elapsed 
#  76.22 
#elapsed 
# 96.602
#
#For now let's take the 10 largest singular values
#we will need to choose this number carefully later

#the largest eigenvalues and corresponding eigenvectors are in S
