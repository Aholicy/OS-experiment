#include "program.h"
#include "stdlib.h"
#include "interrupt.h"
#include "asm_utils.h"
#include "stdio.h"
#include "thread.h"
#include "os_modules.h"
class Pageswap{
public:
	int page[6];
	int size;
	void initialize(){
		for(int i=0;i<6;++i){
			page[i]=0;
		}
		size=0;
	}
	int findp(int x){
		for(int i=0;i<6;++i){
			if(page[i]==x){
				return i;
			}
		}
		return -1;
	}
	void LRU(int x){
		int pos=findp(x);
		if(pos==-1){
			if(size<6){
				page[size++]=x;
			}
			else{
				for(int i=0;i<6;i++){
					page[i]=page[i+1];
					page[6]=x;
				}
			}
		}
		else{
			for(int i=pos;i<5;++i){
				page[i]=page[i+1];				
			}
			page[5]=x;
		}
		printf("LRU: now pages in are  ");
		for(int i=0;i<6;++i){
			printf("%d",page[i]);	
		}
		printf("\n");
	}
	void FIFO(int x){
		int pos=findp(x);
		if(pos==-1){
			if(size<6){
				page[size++]=x;
			}
			else{
				for(int i=0;i<6;i++){
					page[i]=page[i+1];
					page[6]=x;
				}
			}
		}
		
		printf("FIFO: now pages in are  ");
		for(int i=0;i<6;++i){
			printf("%d",page[i]);	
		}
		printf("\n");
	}
};	
