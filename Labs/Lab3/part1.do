# set the working dir, where all compiled verilog goes
vlib work

# compile all SystemVerilog in fulladder.sv to working dir
vlog -sv fulladder.sv

# load simulation using fulladder as the top level simulation module
vsim fulladder

# log all signals and add them to waveform window
log {/*}
add wave {/*}

# first test case 
# a = 0011 (3), b = 0101 (5), c_in = 1  --> sum = 9
# expected: s = 1001, c_out = 0111
force {a}     4'b0011
force {b}     4'b0101
force {c_in}  1'b1
run 10ns

# second test case
# a = 1111 (15), b = 0001 (1), c_in = 0  --> sum = 16
# expected: s = 0000, c_out = 1111
force {a}     4'b1111
force {b}     4'b0001
force {c_in}  1'b0
run 10ns