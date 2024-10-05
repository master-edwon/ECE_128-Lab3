`timescale 1ns / 1ps

module Full_Ripple_Carry_Adder(
    input [1:0] A,
    input [1:0] B,  
    output [6:0] segt       
);
    wire COt;
    wire c;
    wire [1:0] S;
    wire [3:0] bcds;
    Adder2 uut1(A, B, S, COt);
    assign bcds = {1'b0, COt, S};
    BCD_Converter uut2(bcds, segt);
endmodule
         
module Adder2(
    input[1:0] A,
    input[1:0] B,
    output [1:0] S,
    output CO
    );
    
wire c;

OneBit_Full_Adder Bit0(A[0], B[0], 0, c, S[0]);
OneBit_Full_Adder Bit1(A[1], B[1], c, CO, S[1]);
endmodule         

module OneBit_Full_Adder(a,b,CI,CO,SUM);
    input a, b, CI;
    output SUM, CO;
    
assign SUM = a^b^CI;
assign CO = b&CI | a&CI | a&b;
endmodule

module BCD_Converter(
    input[3:0] num,
    output reg [6:0] seg
    );
    
    always @ (num)
    begin
        case(num)
            4'b0000 : seg = 7'b1000000; //abcdef
            4'b0001 : seg = 7'b1111001; //bc
            4'b0010 : seg = 7'b0100100; //abged
            4'b0011 : seg = 7'b0110000; //abcdg
            4'b0100 : seg = 7'b0011001; // bcfg
            4'b0101 : seg = 7'b0010010; // afgcd
            4'b0110 : seg = 7'b0000010; // acdefg
            4'b0111 : seg = 7'b1111000; // abc
            4'b1000 : seg = 7'b0000000; // abcdefg
            4'b1001 : seg = 7'b0010000; // abcdfg
         endcase
    end
endmodule
