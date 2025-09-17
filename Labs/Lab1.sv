module part1(input logic x, y, s
             output logic f);
    assign f = (x & ~s) | (y & s);
endmodule

module part2(input logic a, b, c, d,
             output logic f);
    assign f = (~a & ~c) | (~b & d);
endmodule