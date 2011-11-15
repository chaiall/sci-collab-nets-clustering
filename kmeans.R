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
require(igraph)
require(Cairo)
require(flexclust)

gplot <- function(G,layout=layout.spring,add=FALSE,vertex.color="#ff0000",rescale=FALSE,main="") {
	plot(G, layout=layout, vertex.size=3, vertex.label=V(G)$name,
		 vertex.color=vertex.color, vertex.frame.color=vertex.color, edge.color="#555555",
		 vertex.label.dist=0.25, vertex.label.cex=0.6, vertex.label.font=2,
		 edge.arrow.size=0.3, add=add, rescale=rescale,main=main)
# 	plot(G, vertex.label=V(G)$name,vertex.size=2,vertex.color="red",vertex.label.color="black",vertex.label.cex=0.6,layout=layout)
}

gplot_faint <- function(G,layout=layout.spring,main="") {
	plot(G, layout=l, vertex.size=3, vertex.label=NA, vertex.color="#ff000033",
		 vertex.frame.color="#ff000033", edge.color="#55555533", edge.arrow.size=0.3,
		 rescale=FALSE, xlim=range(layout[,1]), ylim=range(layout[,2]),
		 main=main)
}

pause <- function() {
	readline(prompt = "Pause. Press <Enter> to continue...") 
	cat("\n\n")
}

n=nrow(A)
D=as.matrix(A)%*%rep(1,n)
B=A+diag(1,n)

g <- graph.adjacency(A>0)
g <- as.undirected(g)
l <- layout.fruchterman.reingold(g)
l <- layout.norm(l, -1,1, -1,1)
gplot(g,layout=l,main="UMASS CS Collaboration Graph 2011")

#option 1: B is binary
B = (A>0)*1;
#option 2: B is weighted
B = as.matrix(A)
#option 3: B is normalized
B = as.matrix(A)%*%diag(as.vector(1/D),n)

#base option 1: e$vectors
e=eigen(B)
C = B%*%e$vectors;

#base option 2: random projection E
r=10
E=matrix(rnorm(n*r,0,1),n,r)
C = B%*%E;



showCluster <- function(A,g,l,method,c)
{
    K=kcca(A,c,family=kccaFamily(method))
    for( i in 1:c )
    {
#g_ev <- subgraph(g,which(K$cluster==i)-1)
#l_ev <- l[ which(K$cluster==i), ]
    g_ev <- subgraph(g,which(clusters(K)==i)-1)
    l_ev <- l[ which(clusters(K)==i), ]

    gplot_faint(g,layout=l,main=paste(sep="", "K-means"))

    if( is.matrix(l_ev)==FALSE)
        gplot(g_ev,layout=t(as.matrix(l_ev)),add=TRUE,vertex.color="#ffa500")
    else
        gplot(g_ev,layout=l_ev,add=TRUE,vertex.color="#ffa500")

    if( i != c)
        pause()
    }
}

showCluster(C,g,l,'kmeans',2)



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
