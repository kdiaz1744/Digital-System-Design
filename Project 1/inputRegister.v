`timescale 1ns / 1ps

//Module for inpug Register
module inputRegister(ld, clr, clk, D, Q);
//inputs
input clr, clk, ld;
input [3:0] D;
//outputs
output reg [3:0] Q;

//Fired on CLK
always @ (posedge clk)
       //if clear is on, them output is 0
    if(clr)
        Q <= 0;
        //if Load/ld is on, then the output will be the input
    else if(ld)
        Q <= D;
    
endmodule
