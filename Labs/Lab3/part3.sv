module part3(
    input logic clock, reset_b,
    input logic [3:0] Data,
    input logic [2:0] Function,
    output logic [7:0] ALU_reg_out);

    //A = Data, B = 4 least-significant bits from register output
    logic [3:0] A, B;
    assign A = Data;
    assign B = ALU_reg_out[7:4];

    // Init logic for ALU output for the register
    logic [7:0] ALU_out;

    always_comb begin
        case (Function)
            //0: A + B 
            2'b00: ALU_out = {3'b000, (A + B)}; // Concat zeroes + final carry + sum

            //1: A * B (no concat needed since 4x4 = 8 bits)
            2'b01: ALU_out = A * B;

            //2: Leftshift B by A using shift operator
            2'b10: ALU_out = ({4'b0000, B}) << A;

            //3: Hold current value in register
            2'b11: ALU_out = ALU_reg_out;

            default: ALU_out = 8'b0;
        endcase
    end

    // 8 Bit Register to store ALU output
    D_flip_flop reg0(.clk(clock), .reset_b(reset_b), .d(ALU_out[0]), .q(ALU_reg_out[0]));
    D_flip_flop reg1(.clk(clock), .reset_b(reset_b), .d(ALU_out[1]), .q(ALU_reg_out[1]));
    D_flip_flop reg2(.clk(clock), .reset_b(reset_b), .d(ALU_out[2]), .q(ALU_reg_out[2]));
    D_flip_flop reg3(.clk(clock), .reset_b(reset_b), .d(ALU_out[3]), .q(ALU_reg_out[3]));
    D_flip_flop reg4(.clk(clock), .reset_b(reset_b), .d(ALU_out[4]), .q(ALU_reg_out[4]));
    D_flip_flop reg5(.clk(clock), .reset_b(reset_b), .d(ALU_out[5]), .q(ALU_reg_out[5]));
    D_flip_flop reg6(.clk(clock), .reset_b(reset_b), .d(ALU_out[6]), .q(ALU_reg_out[6]));
    D_flip_flop reg7(.clk(clock), .reset_b(reset_b), .d(ALU_out[7]), .q(ALU_reg_out[7]));

endmodule

module D_flip_flop(
    input logic clk, 
    input logic reset_b,
    input logic d,
    output logic q
);
    always_ff @(posedge clk) begin
        if (reset_b) q <= 1'b0;
        else q <= d;
    end
endmodule