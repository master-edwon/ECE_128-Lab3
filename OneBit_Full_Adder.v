module OneBit_Full_Adder(a,b,CI,CO,SUM);
    input a, b, CI;
    output SUM, CO;
    
  assign SUM = a^b^CI;
  assign CO = b&CI | a&CI | a&b;
endmodule
