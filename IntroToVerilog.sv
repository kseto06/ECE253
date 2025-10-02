module max2tol2bits(input logic[1:0] x, y,
                     input logic s,
                     output logic [1:0] f);
    assign f[1] = (~s & x[1]) | (s & y[1]);
    assign f[0] = (~s & x[0]) | (s & y[0]);
endmodule

module halfadder(input logic a, b,
                 output logic [1:0]s);
    assign s[1] = a & b;
    assign s[0] = a ^ b;
endmodule

module fulladder(input logic a, b, c_in,
                 output logic s, c_out);
    // This is just one block, need to build and connect multiple modules to get 3-bit adder
    assign s = a ^ b ^ c_in;
    assign c_out = (a & b) | (c_in & a) | (c_in & b);
endmodule

module adder3(input logic [2:0] A, B,
              input logic c_in,
              output logic [2:0] s,
              output logic c3);
    logic c1, c2; //internal signals
    fulladder u0 (A[0], B[0], c_in, s[0], c1);
    fulladder u1 (A[1], B[1], c1, s[1], c2);
    fulladder u2 (A[2], B[2], c2, s[2], c3);
endmodule

// D-latch code:
module D_latch(input logic D, clk
               output logic Q);
    always_latch begin
        if (clk == 1)
            Q = D;
    end
endmodule

// FFs
module D_FF(input logic D, clk,
            output logic Q);
    always_ff @ (posedge clk) //Sensitivity test, use negedge for negatively triggered FF
        Q <= D; //Assignment operator for FF

endmodule

/*
posedge is a keyword used to create FFs
- Any signal assigned a vlaue inside an always block using posedge becomes Q output of FF

When code describes FFs, the assignments should use <= (non-blocking) instead of = (blocking)

Note: 
- Q can only store value of D
- positive clk edge vs latch above with "if clk == 1":
    - Q1 <= D1;
    - Q2 <= Q1;
*/

// Register
module reg8(input logic [7:0] D,
            input logic clk,
            output logic [7:0] Q);
    always_ff @ (posedge clk)
        Q <= D;

endmodule

//Reset
module D_FF(input logic D, clk, resetn
            output logic Q);
    always_ff @ (posedge clk) 
    begin
        if (resetn == 0) //active low reset
            Q <= 1'b0;
        else
            Q <= D; 
    end
endmodule

//Asynchronous
module D_FF(input logic D, clk, resetn
            output logic Q);
    always_ff @ (posedge clk, negedge resetn) 
    begin
        if (resetn == 0)
            Q <= 1'b0;
        else
            Q <= D; 
    end
endmodule