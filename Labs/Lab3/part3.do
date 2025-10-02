# set the working dir, where all compiled verilog goes
vlib work

# compile SystemVerilog sources
vlog -sv part3.sv

# load simulation using part3 as the top-level module
vsim part3

# log all signals and add them to waveform window
radix -bin
log {/*}
add wave {/*}

# make a clock (10 ns period) and apply reset (active-high in D_flip_flop)
force -repeat 10ns {clock} 0 0ns, 1 5ns
force {reset_b} 1
run 2ns
force {reset_b} 0

# Function = 000 : A + B
# After reset ALU_reg_out = 00000000, so B = ALU_reg_out[7:4] = 0000.
# Data (A) = 0011 -> expected next registered value = 00000011
force {Function} 3'b000
force {Data}     4'b0011
run 20ns
