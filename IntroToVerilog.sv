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

