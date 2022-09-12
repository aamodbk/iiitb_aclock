# iiitb_aclock -> Implementation of an Alarm Clock in Verilog
This project carries out the design and development of a fully implementable Verilog code of a working digital
alarm clock synthesizable for FPGA. Basic Verilog HDL syntax is
used for the implementation of this digital design and a testbench
file is also created for simulation using the Icarus Verilog compiler
and the GTKWave toolkit.

## Introduction
This design aims to apply the Verilog language into the
development of a simple mechanism of a digital alarm clock. The block diagram for the proposed design is shown below:

![Alt text](blockdiagram.png?raw=true "Block Diagram")

This implementation of a digital clock includes a multiple
features enabling resetting the clock, setting up an alarm for
a specific time and also stopping the alarm when it goes off.
Basic verilog language syntax and functions are used to realize
the required features. The created digital clock is capable of
displaying hours, minutes and seconds upto two significant
digits. Alarm can also be set upto the accuracy of minutes.

### Applications
* Can be used as a digital clock
* Allows setting of alarm at a decided time
* Allows option to turn off alarm when it goes off

## Instructions to Run
### IcarusVerilog and GTKWave
#### For Ubuntu
Open your terminal and type the following to install IcarusVerilog and GTKWave:
```
$   sudo apt-get update
$   sudo apt-get install iverilog gtkwave
```
To clone this repository and run the netlist and the testbench, execute the following commands in your terminal:
```
$   sudo apt install -y git
$   git clone https://github.com/aamodbk/iiitb_aclock
$   cd iiitb_aclock
$   iverilog iiitb_aclock.v iiitb_aclock_tb.v
$   ./a.out
$   gtkwave test.vcd
```
End the a.out process after the GTKWave window opens to avoid unnecessarily filling up memory.

## Functional Characteristics
In the testbench file, an Under Unit Test (UUT) is instantiated and variables for input and output are provided to the
test module. The clock variable is set to a frequency of 10 Hz.
The testing proceeds as follows – Initially, the time is set to
10 : 14. After 1 second, an alarm is set at the time 10 : 20.
The alarm goes off at the set time of 10 : 20 as seen from the
figure:

![Alt text](graph.png?raw=true "Graph")

The alarm is then turned off after 1 second and the
clock-time is reset to 04 : 45. Next, another alarm is set to
04 : 55, which functions as expected.

## Synthesis of Verilog Code
Synthesis is a process by which an abstract specification of desired circuit behavior, typically at register transfer level (RTL), is turned into a design implementation in terms of logic gates, typically by a computer program called a synthesis tool. The program we use is called Yosys.
### About Yosys
Yosys is an open-source framework for Verilog synthesis. It currently has extensive Verilog-2005 support and provides a basic set of synthesis algorithms for various application domains. Yosys can be adapted to perform any synthesis job by combining the existing passes (algorithms) using synthesis scripts and adding additional passes as needed by extending the Yosys C++ code base.

To install Yosys, follow the instructions given in the refered GitHub repository:
https://github.com/YosysHQ/yosys

### Instructions for Synthesis
Create a Yosys script yosys_run.sh in the cloned `/iiitb_aclock` directory and type in the following code into it:
```
# read design

read_liberty -lib lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog iiitb_aclock.v

# generic synthesis
synth -top iiitb_aclock

# mapping to mycells.lib
dfflibmap -liberty ./lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty ./lib/sky130_fd_sc_hd__tt_025C_1v80.lib

clean
flatten

# write synthesized design
write_verilog -noattr iiitb_aclock_synth.v

stat
show
```
Then run the above script by typing the following command into the terminal:
```
yosys -s yosys_run.sh
```
Upon entering this command, the synthesis procedure takes place and a new file `iiitb_aclock_synth.v` is created. Also, in the terminal the number and types of cells are printed and the schematic diagram for the design is generated and shown in the Dot Viewer. 

![Alt text](img1.png?raw=true "Statistics(1)")
![Alt text](img2.png?raw=true "Statistics(2)")

As the schematic is very detailed no image could be included to represent it accurately, therefore, the file `output.dot` is provided along with the code and can be viewed with the Dot Viewer.

## Gate Level Simulation (GLS)
Gate level Simulation(GLS) is done at the late level of Design cycle. This is run after the RTL code is synthesized into Netlist. Netlist is translation from RTL into Gates and connection wirings with full functional and timing behaviour.

Run the following commands in the terminal to do a gate level simulation of the design:
```
$ iverilog -DFUNCTIONAL -DUNIT_DELAY=#1 ./verilog_model/primitives.v ./verilog_model/sky130_fd_sc_hd.v iiitb_aclock_synth.v iiitb_aclock_tb.v
$ ./a.out
$ gtkwave test.vcd
```
![Alt text](graph2.png?raw=true "Statistics(2)")

## Layout
### Installation of required tools
#### OpenLane


## Contributors
* Aamod B K
* Kunal Ghosh

## Acknowledgments
* Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.

## Contact Information
* Aamod B K, IMtech 2020, International Institute of Information Technology, Bangalore Aamod.BK@iiitb.ac.in
* Kunal Ghosh, Director, VSD Corp. Pvt. Ltd. kunalghosh@gmail.com

## References
* fpga4student -- https://www.fpga4student.com/2016/11/verilog-code-for-alarm-clock-on-fpga.html
* Wikipedia -- https://en.wikipedia.org/wiki/Logic_synthesis
* Yosys Documentation -- https://yosyshq.net/yosys/
* Gate Level Simulation -- https://jerinjacobblog.wordpress.com/2020/07/20/gate-level-simulation-introduction/
