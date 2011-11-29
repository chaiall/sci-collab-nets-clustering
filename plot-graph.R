require(igraph)
require(Cairo)

gplot <- function(G,layout=layout.spring,add=FALSE,vertex.color="#ff0000",rescale=FALSE,main="") {

    if( vcount(G) < 50 )
	plot(G, layout=layout, vertex.size=3, vertex.label=V(G)$name,
		 vertex.color=vertex.color, vertex.frame.color=vertex.color, edge.color="#555555",
		 vertex.label.dist=0.25, vertex.label.cex=0.6, vertex.label.font=2,
		 edge.arrow.size=0.3, add=add, rescale=rescale,main=main)
    else
	plot(G, layout=layout, vertex.size=3, vertex.label=NA,
		 vertex.color=vertex.color, vertex.frame.color=vertex.color, edge.color="#555555",
		 vertex.label.dist=0.25, vertex.label.cex=0.6, vertex.label.font=2,
		 edge.arrow.size=0.3, add=add, rescale=rescale,main=main)
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

initGraph <- function(A)
{
    ret = c()
    g <- graph.adjacency(A)
    g <- as.undirected(g)
    l <- layout.fruchterman.reingold(g)
    l <- layout.norm(l, -1,1, -1,1)
    ret$g <- g
    ret$l <- l
    return(ret)
}

showGraph <- function(A,g,l,K,title)
{
    c = max(K)
    for( i in 1:c )
    {
        g_ev <- subgraph(g,which(K==i)-1)
        l_ev <- l[ which(K==i), ]

        gplot_faint(g,layout=l,main=paste(sep="", title))

        if( is.matrix(l_ev)==FALSE)
            gplot(g_ev,layout=t(as.matrix(l_ev)),add=TRUE,vertex.color="#ffa500")
        else
            gplot(g_ev,layout=l_ev,add=TRUE,vertex.color="#ffa500")

        if( i != c)
            pause()
    }
}
