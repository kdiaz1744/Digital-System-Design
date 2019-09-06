`timescale 1ns / 1ps

module mux_Display(inReg, inAccReg, inSelect, outputMux);

//input from Input Register
input [3:0] inReg;
//input from Account Register
input [15:0] inAccReg;
//selector
input inSelect;
//Final Output, this is the output that we see in the simulation
output reg [15:0] outputMux;

//fire when something change
always @ (*)
    //if select is 0, then the output will be the input register
    if(inSelect == 0)
        outputMux <= inReg;
        //else the output will be the account register
    else 
        outputMux <= inAccReg;
endmodule
