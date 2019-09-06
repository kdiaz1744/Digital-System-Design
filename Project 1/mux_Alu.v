`timescale 1ns / 1ps

//Module Mux al lado del ALU
module mux_Alu(inReg, inAlu, inSelect, outputMux);

//Input from the Input Register
input [3:0] inReg;

//input From ALU
input [15:0] inAlu;

//Selector for what is gonna be the output
input inSelect;

//the output that enter on ACCRegister
output reg [15:0] outputMux;

//fire when somenthing of the inputs change
always @ (*)
    
    //if select = 0, then the output will be the input reg
    if(inSelect == 0)
        outputMux <= inReg;
        //else, the output will be the Alu output
    else 
        outputMux <= inAlu;

endmodule
