#include "asm_utils.h"
#include "interrupt.h"
#include "stdio.h"
#include "program.h"
#include "thread.h"
#include "sync.h"

// 屏幕IO处理器
STDIO stdio;
// 中断管理器
InterruptManager interruptManager;
// 程序管理器
ProgramManager programManager;

Semaphore chopstick[5];
int ck[5];
void philosopher(void* arg)
{
    int num=*(int*)(arg);
    chopstick[num].P();
    if(ck[num]==0){
    	printf("Pilosopher %d is taking his left hand chopstick %d \n",num+1,num);
    	ck[num]=1;
    }
    else{
        printf(" left hand chopstick busy \n");
    }
    
    int delay=0x8ffffff;
    while(delay)
         delay--;
    chopstick[(num+1)%5].P();
    if(ck[(num+1)%5]==0){
    	printf("Pilosopher %d is taking his right hand chopstick %d \n",num+1,(num+1)%5);
    	printf("Pilosopher %d is eating.\n",num+1);
    	ck[(num+1)%5]=1;
    	ck[(num+1)%5]=0;
        ck[num]=0;
        chopstick[num].V();
    chopstick[(num+1)%5].V();
    }
    else{
        printf(" right hand chopstick busy \n");
    } 
    //printf("Pilosopher %d is taking his right hand chopstick %d \n",num+1,(num+1)%5);
    //printf("Pilosopher %d is eating.\n",num+1);
    printf("Pilosopher %d is thinking.\n",num+1);
    
    
}
void first_thread(void *arg)
{
    // 第1个线程不可以返回
    stdio.moveCursor(0);
    for (int i = 0; i < 25 * 80; ++i)
        stdio.print(' ');
    stdio.moveCursor(0);
    for(int i=0;i<5;i++){
        chopstick[i].initialize(1);
        ck[i]=0;
       }
    int a[5]={0,1,2,3,4};
    programManager.executeThread(philosopher, (void*)(a), "first thread", 1);
    programManager.executeThread(philosopher, (void*)(a+1), "second thread", 1);
    programManager.executeThread(philosopher, (void*)(a+2), "third thread", 1);
    programManager.executeThread(philosopher, (void*)(a+3), "fourth thread", 1);
    programManager.executeThread(philosopher, (void*)(a+4), "fifth thread", 1);
    asm_halt();
}

extern "C" void setup_kernel()
{

    // 中断管理器
    interruptManager.initialize();
    interruptManager.enableTimeInterrupt();
    interruptManager.setTimeInterrupt((void *)asm_time_interrupt_handler);

    // 输出管理器
    stdio.initialize();

    // 进程/线程管理器
    programManager.initialize();

    // 创建第一个线程
    int pid = programManager.executeThread(first_thread, nullptr, "first thread", 1);
    if (pid == -1)
    {
        printf("can not execute thread\n");
        asm_halt();
    }

    ListItem *item = programManager.readyPrograms.front();
    PCB *firstThread = ListItem2PCB(item, tagInGeneralList);
    firstThread->status = RUNNING;
    programManager.readyPrograms.pop_front();
    programManager.running = firstThread;
    asm_switch_thread(0, firstThread);

    asm_halt();
}
