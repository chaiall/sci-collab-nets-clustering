library('Matrix')
library('irlba')

tic <- function(gcFirst = TRUE, type=c("elapsed", "user.self", "sys.self"))
{
   type <- match.arg(type)
   assign(".type", type, envir=baseenv())
   if(gcFirst) gc(FALSE)
   tic <- proc.time()[type]         
   assign(".tic", tic, envir=baseenv())
   invisible(tic)
}

toc <- function()
{
   type <- get(".type", envir=baseenv())
   toc <- proc.time()[type]
   tic <- get(".tic", envir=baseenv())
   print(toc - tic)
   invisible(toc)
}

data<-read.table('out3.txt');
authors<-read.table('authors.txt', sep='\n')
authors<-as.vector(authors$V1)

#Jie:#data<-read.table("/home/jie/work/out3.txt");
line_num = dim(data)[1];

#max_num:1030712
max_num = max(data);
tic()
A = sparseMatrix(i=c(data[,1],data[,2]),j=c(data[,2],data[,1]),x=c(data[,3],data[,3]))
toc()


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

B=S$u

