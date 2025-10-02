module part2(
    input logic [3:0] A, B,
    input logic [1:0] Function,
    output logic [7:0] ALUout);

    // Construct part 1 full adder
    logic [3:0] sum;
    logic [3:0] c_out;
    part1 adder(.a(A), .b(B), .c_in(1'b0), .s(sum), .c_out(c_out));

    // Get the final carry out to put in ALUout[4]
    logic c_out_final;
    assign c_out_final = c_out[3];

    always_comb begin
        unique case (Function)
            //0: A + B
            2'b00: ALUout = {3'b000, c_out_final, sum}; // Concat zeroes + final carry + sum

            //1: Output 1 if at least one of the 8 bits across A||B is 1
            2'b01: ALUout = (|{A, B}) ? 8'b00000001 : 8'b00000000; //Reduction OR to collapse A||B to 1 bit to check for 0 or 1

            //2: Output 1 if all 8 bits across A||B are 1
            2'b10: ALUout = (&{A, B}) ? 8'b00000001 : 8'b00000000; //Reduction AND to collapse A||B to 1 bit to check for 0 and 1

            //3: A = 4 most significant bits, B = 4 least significant bits
            2'b11: ALUout = {A, B};

            default: ALUout = 8'b0;
        endcase
    end
endmodule

module part1(
    input logic [3:0] a, b,
    input logic c_in,
    output logic [3:0] s, c_out
);
    //4-bit ripple-carry adder circuit
    FA fa0 (a[0], b[0], c_in, s[0], c_out[0]);
    FA fa1 (a[1], b[1], c_out[0], s[1], c_out[1]);
    FA fa2 (a[2], b[2], c_out[1], s[2], c_out[2]);
    FA fa3 (a[3], b[3], c_out[2], s[3], c_out[3]);

endmodule