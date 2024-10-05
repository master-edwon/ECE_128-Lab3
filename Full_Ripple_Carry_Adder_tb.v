`timescale 1ns / 1ps

module Full_Ripple_Carry_Adder_tb;
//output
wire [6:0] segt;

//input
reg [1:0] A;
reg [1:0] B;  

Full_Ripple_Carry_Adder uut1 (A, B, segt);

initial begin
    #10 A=2'b00;B=2'b00;
    #10 A=2'b00;B=2'b01;
    #10 A=2'b00;B=2'b10;
    #10 A=2'b00;B=2'b11;
    
    #10 A=2'b01;B=2'b00;
    #10 A=2'b01;B=2'b01;
    #10 A=2'b01;B=2'b10;
    #10 A=2'b01;B=2'b11;
    
    #10 A=2'b10;B=2'b00;
    #10 A=2'b10;B=2'b01;
    #10 A=2'b10;B=2'b10;
    #10 A=2'b10;B=2'b11;
    
    #10 A=2'b11;B=2'b00;
    #10 A=2'b11;B=2'b01;
    #10 A=2'b11;B=2'b10;
    #10 A=2'b11;B=2'b11;
    
    #10 $stop;
end
endmodule
