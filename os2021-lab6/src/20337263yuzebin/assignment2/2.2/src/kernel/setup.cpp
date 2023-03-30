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

Semaphore semaphore;

int product;

void producer(void *arg)
{
    semaphore.P();
    for(int i=0;i<10;++i){
    	product += 1;
    	printf("producer:No.%d  produce successfully  ,there are  %d products now\n",i+1, product);
    	int delay;
    	delay = 0xffffff;
    	while (delay)
        	--delay;
    }
    semaphore.V();

}

void consumer(void *arg)
{
    semaphore.P();
    for(int i=0;i<10;++i){
    	if(product>0){
    		product -=1;
    		printf("consumer: use one product,there are %d products now\n",product);
    	}
    	else{
    		printf("no products, consume failed\n");
    	}
    	
    }
    semaphore.V();
}

void first_thread(void *arg)
{
    // 第1个线程不可以返回
    stdio.moveCursor(0);
    for (int i = 0; i < 25 * 80; ++i)
    {
        stdio.print(' ');
    }
    stdio.moveCursor(0);

    product = 0;
    semaphore.initialize(1);

    programManager.executeThread(producer, nullptr, "second thread", 1);
    programManager.executeThread(consumer, nullptr, "third thread", 1);

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
