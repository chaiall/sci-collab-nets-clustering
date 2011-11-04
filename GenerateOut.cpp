#include<iostream>
#include<fstream>
#include <strstream>
#include <stdlib.h>
using namespace std;

typedef struct
{
 long NumberQuantity;
 long Numbers[100000];
}TOneLine;

TOneLine ReadNumber;


int main() {
	ifstream File("out.txt");
	char Buffer[100000];
	long col,row=0;

	long max_num = 0;
	FILE * fp = fopen("out2.txt","w");
	while(File.getline(Buffer,sizeof(Buffer)/sizeof(Buffer[0])))
	{
		istrstream LineStream(Buffer);
		col=0;
		do
		{
			LineStream>>ReadNumber.Numbers[col];
			if(row == 2792415) {
				break;
			}
			if(ReadNumber.Numbers[col] > max_num) {
				max_num = ReadNumber.Numbers[col];
			}
			col++;
		}while(LineStream.eof()==false);
		if(col > 1) {
			for(long i = 0; i < col; i++) {
				for(long j = i+1; j< col; j++) {
					fprintf(fp,"%ld\t%ld\t",ReadNumber.Numbers[i],ReadNumber.Numbers[j]);
					fprintf(fp,"%f\n",1.0 / col);
				}
			}
		}
		row++;
		if(row == 2792415) {
			break;
		}
	}
	fclose(fp);
	printf("%ld",max_num);
	getchar();
	return 0;
}
