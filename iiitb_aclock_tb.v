`timescale 1ms/10us
module test;
// fpga4student.com FPGA projects, VHDL projects, Verilog project
 // Inputs
 reg reset;
 reg clk;
 reg [3:0] a;
 reg [1:0] H_in1;
 reg [3:0] H_in0;
 reg [3:0] M_in1;
 reg [3:0] M_in0;
 reg LD_time;
 reg LD_alarm;
 reg STOP_al;
 reg AL_ON;

 // Outputs
 wire Alarm;
 wire [1:0] H_out1;
 wire [3:0] H_out0;
 wire [3:0] M_out1;
 wire [3:0] M_out0;
 wire [3:0] S_out1;
 wire [3:0] S_out0;
// fpga4student.com FPGA projects, VHDL projects, Verilog project
 // Instantiate the Unit Under Test (UUT)
 aclock uut (
 .reset(reset), 
 .clk(clk), 
 .H_in1(H_in1), 
 .H_in0(H_in0), 
 .M_in1(M_in1), 
  .M_in0(M_in0), 
 .LD_time(LD_time), 
 .LD_alarm(LD_alarm), 
 .STOP_al(STOP_al), 
 .AL_ON(AL_ON), 
 .Alarm(Alarm), 
 .H_out1(H_out1), 
 .H_out0(H_out0), 
 .M_out1(M_out1), 
 .M_out0(M_out0), 
 .S_out1(S_out1), 
 .S_out0(S_out0)
 );

 initial
 begin
    $dumpfile("test.vcd");
    $dumpvars(0,test);
    $printtimescale;
 end
 // clock 10Hz
 initial begin 
  clk = 0;
  forever #50 clk = ~clk;
 end
 initial begin
 // Initialize Inputs
 reset = 1;
 H_in1 = 1;
 H_in0 = 0;
 M_in1 = 1;
 M_in0 = 4;
 LD_time = 0;
 LD_alarm = 0;
 STOP_al = 0;
 AL_ON = 0; // set clock time to 11h26, alarm time to 00h00 when reset
 // Wait 100 ns for global reset to finish
  #1000;
 reset = 0;
 H_in1 = 1;
 H_in0 = 0;
 M_in1 = 2;
 M_in0 = 0;
 LD_time = 0;
 LD_alarm = 1;
 STOP_al = 0;
 AL_ON = 1; // turn on Alarm and set the alarm time to 11h30
 #1000; 
 reset = 0;
 H_in1 = 1;
 H_in0 = 0;
 M_in1 = 2;
 M_in0 = 0;
 LD_time = 0;
 LD_alarm = 0;
 STOP_al = 0;
 AL_ON = 1; 
 wait(Alarm); // wait until Alarm signal is high when the alarm time equals clock time
 #1000
 STOP_al = 1; // pulse high the STOP_al to push low the Alarm signal
 #1000
 STOP_al = 0;
 H_in1 = 0;
 H_in0 = 4;
 M_in1 = 4;
 M_in0 = 5;
 LD_time = 1; // set clock time to 11h25
  LD_alarm = 0;
 #1000
 STOP_al = 0;
 H_in1 = 0;
 H_in0 = 4;
 M_in1 = 5;
 M_in0 = 5;
 LD_alarm = 1; // set alarm time to 11h35
 LD_time = 0;
 wait(Alarm); // wait until Alarm signal is high when the alarm time equals clock time
 #1000
 STOP_al = 1;// pulse high the STOP_al to push low the Alarm signal
 // fpga4student.com FPGA projects, VHDL projects, Verilog project
 end
      
endmodule