require('igraph')

#g <- read.graph(file='karate.gml',format='gml')
#g <- read.graph(file='polblogs.gml',format='gml')
#g <- read.graph(file='polbooks.gml',format='gml')
g <- read.graph(file='lesmis.gml',format='gml')

A <- get.adjacency(g);
n=nrow(A)
