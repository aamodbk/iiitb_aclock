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