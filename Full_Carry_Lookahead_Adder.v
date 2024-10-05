`timescale 1ns / 1ps

module Full_Carry_Lookahead_Adder(
    input [1:0] A,
    input [1:0] B,
    output [6:0] segt
);
    wire CO;
    wire [1:0] SUM;
    wire [3:0] bcds;
    Carry_Lookahead_Adder uut1(A, B, SUM, CO);
    assign bcds = {1'b0, CO, SUM};
    BCD_Converter uut2(bcds, segt);
endmodule

module Carry_Lookahead_Adder(
    input [1:0] A, B,
    output [1:0] SUM,
    output CO
);
    wire [2:0] c;
    wire [1:0] g, p;
    
    assign g[0] = A[0] & B[0];
    assign g[1] = A[1] & B[1];
    
    assign p[0] = A[0] ^ B[0];
    assign p[1] = A[1] ^ B[1];
    
    assign c[0] = 1'b0; 
    assign c[1] = g[0] | (p[0] & c[0]);
    assign c[2] = g[1] | (p[1] & c[1]);
    OneBit_Full_Adder Bit0(.a(A[0]), .b(B[0]), .CI(c[0]), .SUM( SUM[0]));
    OneBit_Full_Adder Bit1(.a(A[1]), .b(B[1]), .CI(c[1]), .SUM( SUM[1]));
    assign CO = c[2];
endmodule

module OneBit_Full_Adder(
    input a, b, CI,
    output SUM
);
    assign SUM = a ^ b ^ CI;
    //assign CO = (b & CI) | (a & CI) | (a & b);
endmodule

module BCD_Converter(
    input [3:0] num,
    output reg [6:0] seg
);
    always @ (num) begin
        case(num)
            4'b0000 : seg = 7'b1000000; // abcdef
            4'b0001 : seg = 7'b1111001; // bc
            4'b0010 : seg = 7'b0100100; // abged
            4'b0011 : seg = 7'b0110000; // abcdg
            4'b0100 : seg = 7'b0011001; // bcfg
            4'b0101 : seg = 7'b0010010; // afgcd
            4'b0110 : seg = 7'b0000010; // acdefg
            4'b0111 : seg = 7'b1111000; // abc
            4'b1000 : seg = 7'b0000000; // abcdefg
            4'b1001 : seg = 7'b0010000; // abcdfg
        endcase
    end
endmodule
