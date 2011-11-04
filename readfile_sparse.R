data<-read.table("out2.txt");
line_num = dim(data)[1];

max_num = max(data);
#max_num:1030712
result <- matrix(data=0,max_num,max_num)
for (i in 1:line_num) {
	#data[i,1]; data[i,2]; data[i,3];
	result[data[i,1],data[i,2]] <- result[data[i,1],data[i,2]] + data[i,3];
	result[data[i,2],data[i,1]] <- result[data[i,2],data[i,1]] + data[i,3];
}
