`timescale 1ns / 1ps

module TopModule
    (   //Input register
       ld_number, clr_number, clk, inputRegD,
        //MuxAlu
         inSelect,
        
        //ACC Register
        ld_result, clr_result,
        
        //Op Code
        ld_code, clr_code, OpCode,
        
        //display mux
        sel_display, outValue
     );

//----------input Reg-------------
input ld_number, clr_number, clk;
input [3:0] inputRegD;
wire [3:0] outInputReg;
//------------------MuxAlu---------------
input inSelect;
wire [15:0] outMuxAlu;
//-----------------ACC Register-------------
input ld_result;
input clr_result;
wire [15:0] outaccReg;
//-------------Operation Code-------------------------
 input ld_code;
 input clr_code;
 input [2:0] OpCode;
 wire [2:0] outCode;
//-----------Mux Display------------------------
input sel_display;
output [15:0] outValue;


//-------------------ALu-------------------------------------
wire [15:0] outAlu;

//inputRegister
inputRegister  inReg    (ld_number, clr_number, clk, inputRegD, outInputReg);

//Mux Alu
mux_Alu        muxAlu   (outInputReg, outAlu, inSelect, outMuxAlu); 

//ACC REgister
accReg         acc_reg  (ld_result, clr_result, clk, outMuxAlu, outaccReg);

//Operation Register
opReg           opreg   (ld_code, clr_code, clk, OpCode, outCode);

//Alu
Alu             alu     (outAlu,outInputReg,outaccReg,outCode);

//Mux Display
mux_Display  mDisplay   (outInputReg, outaccReg, sel_display, outValue);

endmodule
