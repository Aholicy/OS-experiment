# OS2021-Lab6 并发与锁机制

### 介绍

2021学年春季学期 操作系统原理实验课程 实验六

### 开发环境及工具

- Ubuntu

- qemu
- gdb

### 实验任务

1. 复现自旋锁和信号量机制。
1. 实现自定义的锁机制。
2. 掌握几种经典的同步互斥问题解决方法。
4. 撰写实验报告。

### 实验教程

见`/tutorial`文件夹

### 验收要点

1.  自定义锁机制。
2.  几种经典同步互斥问题的解决方法。

**【TA check】** 5月17 日实验课或提前

**【DEADLINE】** 5 月 22日 23:59

### 提交内容

1. 实验报告：markdown 格式和 PDF 格式。模版见`/tutorial/report.md`文件。
2. 源代码文件及可执行代码程序文件
3. （若有）测试输入数据文件和输出数据文件
4. 实验截图，可以在实验报告中展示

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

**【PS】** clone项目后，不能删除或修改项目原有的所有目录和文件，否则PR项目会出错。