#include "asm_utils.h"
#include "interrupt.h"
#include "stdio.h"
#include "program.h"
#include "thread.h"
#include "sync.h"
#include "memory.h"

// 屏幕IO处理器
STDIO stdio;
// 中断管理器
InterruptManager interruptManager;
// 程序管理器
ProgramManager programManager;
// 内存管理器
MemoryManager memoryManager;

void first_thread(void *arg)
{
    // 第1个线程不可以返回

    int p1 = memoryManager.allocatePhysicalPages(AddressPoolType::KERNEL, 10);
        printf("allocate first pages succeed, start_address is %d\n",p1);
    int p2 = memoryManager.allocatePhysicalPages(AddressPoolType::KERNEL, 40);
        printf("allocate second pages succeed, start_address is %d\n",p2);
    int p3 = memoryManager.allocatePhysicalPages(AddressPoolType::KERNEL, 10);
        printf("allocate third pages succeed, start_address is %d\n",p3);  
    int p4 = memoryManager.allocatePhysicalPages(AddressPoolType::KERNEL, 20);
        printf("allocate forth pages succeed, start_address is %d\n",p4);
    int p5 = memoryManager.allocatePhysicalPages(AddressPoolType::KERNEL, 10);
        printf("allocate fifth pages succeed, start_address is %d\n",p5); 
    memoryManager.releasePhysicalPages(AddressPoolType::KERNEL, p2, 40);
    memoryManager.releasePhysicalPages(AddressPoolType::KERNEL, p4, 20);
    int p6 = memoryManager.allocatePhysicalPages(AddressPoolType::KERNEL, 20);
        printf("allocate sixth pages succeed, start_address is %d\n",p6); 

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

    // 内存管理器
    memoryManager.openPageMechanism();
    memoryManager.initialize();

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
