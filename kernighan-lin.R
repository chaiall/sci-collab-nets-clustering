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
#print(modularity(A,cl$cluster))

c=2

approxModularityMax <- function (A,L)
{
    n = nrow(A)
    improvement = 1
    while( improvement == 1 )
    {
        moved = rep(0,n);
        bestMod = -Inf

        bestL = L
        Lm = L
        while( sum(moved==FALSE) > 0 )
        {
            #Moving vertices reflects in Lm
            #changes are cumulative

            currentMod = modularity(A,Lm)
            maxModDiff = -Inf
            bestMove = 0

            for( i in c(1:n)[moved==0] )
            {
                #Check each vertex individually
                #changes are not cumulative
                #recover Lm
                Lt=Lm
                if( Lt[i] == 1 )
                    Lt[i] = 2
                else
                    Lt[i] = 1

                modDiff = modularity(A,Lt)-currentMod
                if( modDiff > maxModDiff )
                {
                    maxModDiff = modDiff
                    bestMove = i
                }
            }
            #move best option
            if( Lm[bestMove] == 1 )
            {
                Lm[bestMove] = 2
            } else
            {
                Lm[bestMove] = 1
            }

            moved[bestMove] = 1
            print(c('bestMove',bestMove,Lm[bestMove]))

            #keep track of best configuration
            if( currentMod+maxModDiff > bestMod )
            {
                bestMod = currentMod+maxModDiff
                bestL = Lm
                print('better configuration found!')
                print(c('bestL',bestL))
            }
        }

        #improvement found
        currentMod = modularity(A,L)
        if( bestMod > currentMod )
        {
            print('got improved')
            improvement = 1
            L = bestL
        }
        else
        {
            print('didnt get improved!!!')
            improvement = 0
        }
    }
    print(currentMod)
    return(L)
}

#TODO: c is not implemented
#this function always divide in 2 clusters
computeClusters <- function(A,c)
{
    n = nrow(A)
    L0 = c(rep(1,floor(n/2)),rep(2,n-floor(n/2)))
    L <- approxModularityMax(A,L0)
    print(modularity(A,L))
    showGraph(A,g,l,L,'Spectral Clustering')
}

computeClusters(A,c)



