modularity <- function (A, Lt) {
n = nrow(A)
K = rowSums(A)
m = sum(K)/2
Q = 0
for( i in 1:n )
    for( j in 1:n )
    {
        Q = Q+ (A[i,j]-K[i]*K[j]/(2*m))*(Lt[i]==Lt[j])
    }
Q = Q/(2*m)
}
