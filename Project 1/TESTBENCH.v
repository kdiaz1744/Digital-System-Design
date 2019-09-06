`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2018 09:48:59 AM
// Design Name: 
// Module Name: TESTBENCH
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TESTBENCH;


//inputs
//El clk es igual para todos, el reset solo es para el FSM
reg clk, reset;
//Lo que entra en el FSM (opCOde)
reg [2:0] opCodeIn;
//lo que ingresa en el dataPath, (lo que ingresa el usuario)
reg [3:0] values;

//Cables que conectan el FSM con el datapath
wire ld_number, clr_number, ld_opcode, ld_result, clr_result, sel_muxAlu, sel_muxDisplay, clr_opCode;
wire [2:0] opCodeOut;

//ESTADOS (para mostarlos en la simulacion)
wire E0, E1, E2, E3;

//SALIDA FINAL, esta es donde vemos el valor que sale de nuestro datapath
wire [15:0] outValue;

//Instanciamos el FSM con los valores de las variables de arriba
FSM fsm
        (
          clk, reset,opCodeIn ,opCodeOut, ld_number, clr_number,
 
          ld_opcode,clr_opCode, sel_muxAlu, ld_result, clr_result,
 
          sel_muxDisplay,E0, E1, E2, E3
           );


//Todas las entradas del Datapath son Salidas del FSM
TopModule datapath
    (   //Input register
       ld_number, clr_number, clk, values,
        //MuxAlu
        sel_muxAlu,
        
        //ACC Register
        ld_result, clr_result,
        
        //Op Code
        ld_opcode, clr_opCode, opCodeOut,
        
        //display mux
        sel_muxDisplay, outValue
     );


//empazamos la simulacion
initial begin
    clk = 0;reset = 1;opCodeIn = 3'b000;values = 0;#100; //clear all #50;
    
    //reset OFF
    reset = 0;#10;
    
    //STATE 0
    opCodeIn = 3'b000;#100; //clear all
    
    //STATE 1
    opCodeIn = 3'b001; 
    values = 4'b0100;#100; // First Value (4)
    opCodeIn = 3'b010;#100; //press enter
    
    //STATE 2 
    opCodeIn = 3'b100;#100; //suma simbo 
    opCodeIn = 3'b010;#100;//press enter
    
    //STATE 3
    opCodeIn = 3'b001; 
    values = 4'b0101;#100; //Second Value
    opCodeIn = 3'b010;#100;//press enter
    opCodeIn = 3'b100;#100; //suma simbo
    opCodeIn = 3'b010;#100;//press enter

end

//run forever
initial forever #10 clk = ~clk;

endmodule

