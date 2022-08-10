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
$   iverilog iiitb_pwm_gen.v iiitb_pwm_gen_tb.v
$   ./a.out
$   gtkwave pwm.vcd
```

## Simulation Results
