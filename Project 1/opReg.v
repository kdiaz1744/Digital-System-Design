`timescale 1ns / 1ps

//Operation Register
module opReg(ld, clr, clk, D, Q);
//inputs
input clr, clk, ld;

//operation Code
input [2:0] D;
//output operation COde
output reg [2:0] Q;

always @ (posedge clk)
    //if clear the output will be 0
    if(clr)
        Q <= 0;
        //if load the output will be the input
    else if(ld)
        Q <= D;
        
endmodule
