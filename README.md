# iiitb_aclock -> Implementation of an Alarm Clock in Verilog applicable in FPGA
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

## Instructions to Run
### For Ubuntu
Open your terminal and type the following to install IcarusVerilog and GTKWave:
```
$   sudo apt-get update
$   sudo apt-get install iverilog gtkwave
```
To clone this repository and run the netlist and the testbench, execute the following commands in your terminal:
```
$   sudo apt install -y git
$   git clone https://github.com/aamodbk/iiitb_aclock
$   iverilog iiitb_aclock.v iiitb_aclock_tb.v
$   ./a.out
$   gtkwave test.vcd
```

## Simulation Results
In the testbench file, an Under Unit Test (UUT) is instan-
tiated adn variables for input and output are provided to the
test module. The clock variable is set to a frequency of 10 Hz.
The testing proceeds as follows – Initially, the time is set to
10 : 14. After 1 second, an alarm is set at the time 10 : 20.
The alarm goes off at the set time of 10 : 20 as seen from the
figure:

![Alt text](graph.png?raw=true "Graph")

The alarm is then turned off after 1 second and the
clock-time is reset to 04 : 45. Next, another alarm is set to
04 : 55, which functions as expected.

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
