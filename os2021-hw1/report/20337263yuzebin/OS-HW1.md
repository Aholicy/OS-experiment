# OS2021-理论作业一

20337263 俞泽斌

**1.10**

**有些计算机系统不支持硬件运行的特权模式。 能否为这些计算机系统构建一种安全操作系统？ 请给出行或不行的理由。**  



可以，因为首先这些计算机系统不支持硬件运行的特权模式，所以特权模式的实现只能通过软件

1、可以让每一步操作都要在软件的监控下进行，是在每一步操作的时候由软件来判断是否出现了硬件丢失等，判断没有危险的操作后再进行操作实现

2、可以让所有的特权指令都在通过操作系统来实现，然后将这些特权指令的实现都附加上特殊条件，只有满足了特殊的条件，也就相当于软件上的特权模式，才能进行特权指令的实现

3、可以通过对代码的附加的编译来使得代码里加上是否需要特权这一个特殊的位

**1.14**

**请描述一种机制以加强内存保护， 防止一个程序修改与其他程序相关的内存。**  

在程序运行前对于程序所需要的内存空间来进行计算和存储，然后当程序运行过程中有涉及内存空间的就判断一次，如果超出了这个固定的内存范围就由操作系统进行终止和报错。

**2.2**

**描述传递参数到操作系统的三种通用方法**  

1、直接通过寄存器来传递参数。

2、 参数数量比寄存器多的时候，将参数存在内存的块或表中，然后通过寄存器传递块或表的地址
3、用程序将参数放在或压入到堆栈, 并通过操作系统弹出。

**2.7**

**进程间通信的两个模型是什么？ 这两种方案有何长处和短处？**  

消息传递模型和共享内存模型  

消息传递模型：

优点：对少量数据的交换很有用， 因为没有冲突需要避免。 与用于计算机间的共享内存相比， 它也更容易实现。  

缺点：速度不如共享内存，便捷性也不如共享内存

共享内存模型：

优点：共享内存在通信方面具有高速和便捷的特点， 因为当通信发生在同一计算机内时， 它可以按内存传输速度来进行。  

缺点：进程在保护和同步方面有问题。 

**2.10**

**采用微内核法设计系统的主要优点是什么？ 用户程序和系统服务在微内核架构内如何交互？ 采用微内核设计的缺点是什么？**  

主要优点：1、对内核进行模块化。 可以从内核中删除所有不必要的部件， 而将它们当作系统级与用户级的程序来实现，使得内核较小。

2、同时便于扩展操作系统。 所有新服务可在用户空间内增加， 因而并不需要修改内核。 当内核确实需要修改时， 所做修改也会很小， 这是因为微内核本身就很小。     

3、很容易从一种硬件平台移植到另一种硬件平台  

4、提供了更好的安全性和可靠性， 这是由于大多数服务是作为用户进程而不是作为内核进程来运行的。  

做法：微内核的交互通过消息传递来实现，客户程序和服务器不会直接交互，而是通过微内核来进行间接通信

缺点：增加的系统功能的开销， 微内核的性能会受损 ，因为使用了太多消息传递，使得性能减少
