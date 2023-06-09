# OS2021-Lab1

### 介绍

2021学年春季学期 操作系统原理实验课程 实验一

### 开发环境及工具

- Ubuntu

- qemu
- gdb
- Busybox

### 实验任务

1. 搭建OS内核开发环境包括：代码编辑环境、编译环境、运行环境、调试环境等。
2. 下载并编译i386（32位）内核，并利用qemu启动内核。
3. 熟悉制作initramfs的方法。
4. 编写简单应用程序随内核启动运行。
5. 编译i386版本的Busybox，随内核启动，构建简单的OS。
6. 开启远程调试功能，进行调试跟踪代码运行。
7. 撰写实验报告。

### 实验教程

见`/tutorial`文件夹

### 验收要点

1.  启动内核并在gdb中输出`lab1: Hello World\n`或其他字符串
2.  编译启动Busybox，能够通过`ls`命令查看当前文件夹

**【TA check】** 3 月 1 日实验课或提前

**【DEADLINE】** 3 月 6 日 23:59

### 提交内容

1. 实验报告：markdown 格式和 PDF 格式。模版见`/tutorial/report.md`文件。
2. 源代码文件及可执行代码程序文件
3. （若有）测试输入数据文件和输出数据文件
4. 实验截图，可以在实验报告中展示
5. 虚拟机映像文件

**【PS】**

1. 一系列基础实验项目必须连续完成，当前项目只能在前一个项目的基础上进行，体现出前后的进化关系，否则要被约谈，证明没有抄袭行为！
2. 一个项目可提交多个改进的版本，实现新功能和个性化特征都有利于提高相应项目的成绩。

### 提交要求及命名格式

**【提交路径】**

1. `/src `文件夹内存放项目文件
2. `/report` 存放项目报告

**【个人项目提交方式】**

- 布置的个人项目先 **fork** 到个人仓库下；
- **clone** 自己仓库的个人项目到本地目录；
- 在个人项目中，在`/src`、`/report` 目录下，新建个人目录，目录名为“学号+姓名”，例如“12345678WangXiaoMing”； 
- 在 `/src/12345678WangXiaoMing`目录下，保存**项目相关文件**，按要求完成作业;
- **实验报告**以markdown的格式，写在`/report/12345678WangXiaoMing`目录下；
- 完成任务需求后，**Pull Request回主项目的master分支**，PR标题为“学号+姓名”， 如“12345678王小明”；
- **一定要在deadline前PR**。因为批改后，PR将合并到主项目，所有同学都能看到合并的结果，所以此时是不允许再PR提交作业的。

**【PS】**clone项目后，不能删除或修改项目原有的所有目录和文件，否则PR项目会出错。