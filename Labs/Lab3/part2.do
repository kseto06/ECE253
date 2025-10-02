# set the working dir, where all compiled verilog goes
vlib work

# compile SystemVerilog sources
vlog -sv part2.sv

# load simulation using part2 as the top-level module
vsim part2

# log all signals and add them to waveform window
radix -bin
log {/*}
add wave {/*}

# Function = 00 : A + B via ripple adder
# A=0011 (3), B=0101 (5) -> sum=1000, final carry=0
# Expected ALUout = 00001000
force {Function} 2'b00
force {A} 4'b0011
force {B} 4'b0101
run 10ns

# Function = 01 : Output 1 if ANY of A||B bits are 1  (reduction OR)
# A=0000, B=0000 -> expected ALUout = 00000000
force {Function} 2'b01
force {A} 4'b0000
force {B} 4'b0000
run 10ns

# A=0101, B=0000 -> expected ALUout = 00000001
force {Function} 2'b01
force {A} 4'b0101
force {B} 4'b0000
run 10ns

# Function = 10 : Output 1 if ALL of A||B bits are 1  (reduction AND)
# A=1111, B=1111 -> expected ALUout = 00000001
force {Function} 2'b10
force {A} 4'b1111
force {B} 4'b1111
run 10ns

# A=1111, B=1110 -> expected ALUout = 00000000
force {Function} 2'b10
force {A} 4'b1111
force {B} 4'b1110
run 10ns

# Function = 11 : Pack A in most significant, B in least significant
# A=1010, B=1100 -> expected ALUout = 10101100
force {Function} 2'b11
force {A} 4'b1010
force {B} 4'b1100
run 10ns
