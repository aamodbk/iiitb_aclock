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
$   yosys -s yosys_run.sh
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
OpenLane is an open-source VLSI flow built around open-source tools. That is, it's a collection of scripts that run these tools, in the right order, transforming their inputs and outputs as appropriate, and organising the results. It is an automated RTL to GDSII flow based on several components including OpenROAD, Yosys, Magic, Netgen, CVC, SPEF-Extractor, CU-GR, Klayout and a number of custom scripts for design exploration and optimization. The flow performs full ASIC implementation steps from RTL all the way down to GDSII.

For installation of OpenLane, type the follow the below steps.

Installing python as it is a pre-requisite:
```
$   sudo apt install -y build-essential python3 python3-venv python3-pip
```
For installing Docker Engine on Ubuntu, use the following link -- https://docs.docker.com/engine/install/ubuntu/.

Next, go to the `iiitb_aclock` directory and type the following in the terminal:

```
$   git clone https://github.com/The-OpenROAD-Project/OpenLane.git
$   cd OpenLane
$   sudo make
```

Now, to check that OpenLane dependencies are succesfully installed, run the test command:

```
$   sudo make test
```
If the line `Basic test passed` is printed in the terminal, then the installation is successful.

#### Magic
Magic is an electronic design automation (EDA) layout tool for very-large-scale integration (VLSI) integrated circuit (IC) originally written by John Ousterhout and his graduate students at UC Berkeley. Due largely in part to its liberal Berkeley open-source license, magic has remained popular with universities and small companies. The open-source license has allowed VLSI engineers with a bent toward programming to implement clever ideas and help magic stay abreast of fabrication technology. However, it is the well thought-out core algorithms which lend to magic the greatest part of its popularity. Magic is widely cited as being the easiest tool to use for circuit layout, even for people who ultimately rely on commercial tools for their product design flow.

For installation of magic, type the following commands in your terminal in the `iiitb_aclock` directory to install dependencies:
```
$   sudo apt-get install m4
$   sudo apt-get install csh
$   sudo apt-get install tcsh
$   sudo apt-get install libx11-dev
$   sudo apt-get install tcl-dev tk-dev
$   sudo apt-get install libcairo2-dev
$   sudo apt-get install mesa-common-dev libglu1-mesa-dev
$   sudo apt-get install libncurses-dev
```

To install Magic, type the following in the terminal:
```
$   git clone https://github.com/RTimothyEdwards/magic
$   cd magic
$   ./configure
$   sudo make
$   sudo make install
```
To check if Magic has been successfully installed, type the command `magic` in the terminal.

### Generating Layout
#### Creating custom inverter cell
To design a custom inverter cell, include it in library and get it in the final layout, clone the following repo:
```
$   git clone https://github.com/nickson-jose/vsdstdcelldesign.git
$   cd vsdstdcelldesign
$   cp ./libs/sky130A.tech sky130A.tech
$   magic -T sky130A.tech sky130_inv.mag
```
The following Magic windows should appear:

![Alt text](asic_img/asic1.png?raw=true "Magic Viewport")
![Alt text](asic_img/asic2.png?raw=true "TCL console")

Now, to simulate the inverter, we need to generate a Spice netlist corresponding to the .mag file. We do this by typing the following commands into the newly opened TCL console.
```
%   extract all
%   ext2spice cthresh 0 rthresh 0
%   ext2spice
```
The generated .spice file should be edited to look as follows:
```
* SPICE3 file created from sky130_inv.ext - technology: sky130A

.option scale=0.01u

.include ./libs/pshort.lib
.include ./libs/nshort.lib

//.subckt sky130_inv A Y VPWR VGND

M1001 Y A VGND VGND nshort_model.0 w=35 l=23
+  ad=1435 pd=152 as=1365 ps=148
M1000 Y A VPWR VPWR pshort_model.0 w=37 l=23
+  ad=1443 pd=152 as=1517 ps=156

VDD VPWR 0 3.3V
VSS VGND 0 0V
Va A VGND PULSE(0V 3.3V 0 0.1ns 0.1ns 2ns 4ns)

C0 Y VPWR 0.08fF
C1 A Y 0.02fF
C2 A VPWR 0.08fF
C3 Y VGND 0.18fF
C4 VPWR VGND 0.74fF
//.ends

.tran 1n 20n
.control
run
.endc
.end
```

Now, install the ngspice tool if not already installed with the following command:
```
$   sudo apt-get install ngspice
```

Next, compile the .spice file using the ngspice tool:
```
$   ngspice sky130_inv.spice

```

![Alt text](asic_img/asic4.png?raw=true "Terminal commands")

And then type the following in the ngspice terminal to plot the inverter characteristics:
```
ngspice 1 -> plot y vs time a
```

![Alt text](asic_img/asic3.png?raw=true "Inverter plots")

To ensure the correct placement of ports and to check if they lie on the intersection of tracks of the corresponding metal, we need to draw a grid over the layout. To do this, use the below command in the TCL console.
```
%   grid 0.46um 0.34um 0.23um 0.17um
```

Then, the Magic viewport will look as follows:

![Alt text](asic_img/asic3.png?raw=true "Inverter plots")

Now to save the new .mag file, save it with a different name:
```
%   save sky130_vsdinv.mag
```
Then, in the TCL console type the following to generate the .lef file:
```
$   lef write
```

#### Preparation
Open the terminal in the `iiitb_aclock` directory and type the following:
```
$   cd OpenLane
$   cd designs
$   mkdir iiitb_aclock
$   cd iiitb_aclock
$   touch config.json
$   mkdir src
$   cd src
```
Into the `\src` folder, copy the following files:
* `iiitb_aclock.v`
* `sky130_fd_sc_hd__fast.lib`
* `sky130_fd_sc_hd__slow.lib`
* `sky130_fd_sc_hd__typical.lib`
* `sky130_vsdinv.lef`

Now, edit the created file `config.js` to look like:
```
{
    "DESIGN_NAME": "iiitb_aclock",
    "VERILOG_FILES": "dir::src/iiitb_aclock.v",
    "CLOCK_PORT": "clk",
    "CLOCK_NET": "clk",
    "GLB_RESIZER_TIMING_OPTIMIZATIONS": true,
    "CLOCK_PERIOD": 6,
    "PL_TARGET_DENSITY": 0.5,
    "FP_SIZING" : "relative",
    "pdk::sky130*": {
        "FP_CORE_UTIL": 5,
        "scl::sky130_fd_sc_hd": {
            "FP_CORE_UTIL": 5
        }
    },
    
    "LIB_SYNTH": "dir::src/sky130_fd_sc_hd__typical.lib",
    "LIB_FASTEST": "dir::src/sky130_fd_sc_hd__fast.lib",
    "LIB_SLOWEST": "dir::src/sky130_fd_sc_hd__slow.lib",
    "LIB_TYPICAL": "dir::src/sky130_fd_sc_hd__typical.lib",
    "TEST_EXTERNAL_GLOB": "dir::../iiitb_aclock/src/*",
    "SYNTH_DRIVING_CELL":"sky130_vsdinv"

}
```
Change current directory to `OpenLane` and run the following on the terminal:
```
$   sudo make mount
```
When the OpenLane container opens type the following to open the TCL console:
```
$   ./flow.tcl -interactive
```

Then run the below commands on the TCL console:
```
%   package require openlane 0.9
%   prep -design iiitb_aclock
```
Now type the following command to merge the .lef files into a new file named `merged.nom.lef` in the `designs/iiitb_aclock/runs/` folder:
```
%   set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
%   add_lefs -src $lefs
```

### Synthesis
Run the synthesis command on the TCL console:
```
%   run_synthesis
```
On running this command, check the `/runs` folder and search for the .stat.rpt file which reports the synthesis statistics.

![Alt text](asic_img/asic6.png?raw=true "Synthesis")

The Hold slack and statistics of used gates will be displayed in the `2-sta.log` file:

![Alt text](asic_img/asic7.png?raw=true "Slack")

### Floorplan


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
* Magic -- http://www.opencircuitdesign.com/magic/; https://en.wikipedia.org/wiki/Magic_(software)#:~:text=Magic%20is%20an%20electronic%20design,the%20project%20in%20February%201983.
* OpenLane -- https://github.com/The-OpenROAD-Project/OpenLane
