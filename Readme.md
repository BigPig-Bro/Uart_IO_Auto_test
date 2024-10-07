# Uart_IO_Auto_test

## 工程简介

工程的目的在于使每个IO以串口115200/38400/9600的协议输出该IO对应的字符串，例如将任意某IO接入CH340N的RX，在串口助手观察到字符串“ A21”，则该IO的Pin为A21，以此可以快速测试所有IO



注1：由于FPGA各个BANK不一定都是3.3V，因此需要一个带可调电平转换的USB串口

注2：该工程运行前提是有指定明确的时钟Pin输入（或是FPGA内部产生的时钟，自行修改top.sv代码）

注3：测试Altera、国产器件等FPGA时，可能需要在设置中将复用IO改为regular IO以通过布线（部分Pin不推荐复用，如reconfig_n等，测试文件未使用）

注4：Altera的部分IO为CLK_IN，不可输出，类似的GTP的IO、Xilinx ZYNQ的MIO、DDR等也无法通过串口输出

注5：部分FPGA型号PIN定义相同，采用下划线表示，如EP4CE6_10F17_U17代表EP4CE6F17\EP4CE6U17\EP4CE10F17\EP4CE10U17四种型号

注6：速度等级、温度范围等并不影响PIN定义，故选择文件时不给出具体后缀

## 仓库内容

##### 1-source：源代码（未公开）

##### 2-Auto_gen_VXX.exe：主程序

##### 3-Readme.md：本文件



## 使用流程

1-在各自测试软件中测试芯片型号的新建空白工程

2-打开Auto_gen.exe，选择测试的型号，生成对应测试文件top.sv和约束文件（各个厂商文件后缀不同）

3-将生成的top.sv文件和约束文件加入工程

4-编译下载

5-使用硬件串口挨个测试任意IO输出，观察电脑串口助手输出（注意IO电平（实际上是Bank电压）跟串口电平相匹配）



## 版本更新

**VX.X，第一位表示新型号加入更新，第二位表示UI和BUG修复**

240928：初始版本

241003：V1.0 初始版本V1.0发布，仅支持Xilinx 7A35T/50T/100T FGG484，其余型号等待更新

241003：修订Readme部分内容描述

241003：V2.0 添加Altera EP4CE6_10F17系列、EP4CE6_10E22系列、修订输出sv数组赋值语法

241003：V2.1 修订Altera手动输入CLK_PIN生成异常问题（都怪intel）

241003：V2.2 增加EP4CE6_10F17同定义的U17，Readme补充相关说明

241003：V3.0 添加Altera 10CL055Y_ZF484系列

241003：V4.0 添加Gowin GW2A_AR-LV18QN88系列，已上板测试

241003：V5.0 添加AGM AG1280Q48 、AG1280Q32、AG10KL144_H，并移除EP4CE6_10E22系列DCLK引脚

241007：V6.0 添加Xilinx 7010/20_CLG400/484系列，测试了7Z020CLG484、暂时关闭了时钟引脚输入验证