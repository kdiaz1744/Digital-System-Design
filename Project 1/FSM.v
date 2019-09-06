`timescale 1ns / 1ps

//FSM Module for ASM 
module FSM( clk, reset,opCodeIn ,opCodeOut, ld_number, clr_number,
            ld_opcode,clr_opCode, sel_muxAlu, ld_result, clr_result,
            sel_muxDisplay, E0, E1, E2, E3);

//inputs
input clk, reset;

//FSM OpCode
input [2:0] opCodeIn;

//outputs
output reg ld_number, clr_number, ld_opcode, ld_result,
           clr_result, sel_muxAlu, sel_muxDisplay, clr_opCode;

//dataPath Operation Code i/e the one it receives 
output reg [2:0] opCodeOut;

//State outputs
output reg E0,E1,E2,E3;

//Storing states
reg [2:0]state;
//Assigning states
reg [2:0] nextstate;

parameter S0 = 0; //when clear | Display the input Reg
parameter S1 = 1; //State 1
parameter S2 = 2; //State 2
parameter S3 = 3; //State 3


//Fire on positive Clk
always @(posedge clk)
    //if reset pressed, go to first state
    if(reset)
        state = S0;
     
    else //if not, continue in the other states
    state = nextstate;
      
always @ (*)begin
    //If opCodeIn changes, a change will also happen in opCodeOut
   opCodeOut = opCodeIn;
   
   //Verifying States
    case(state)
    //--------------------------------------state 0----------------------------------
    S0:begin
        //So I can see which state I am currently
        E0 = 1; E1 = 0; E2 = 0; E3 = 0;
        
        //Start everything in 0
        ld_number <= 0;
        clr_number <= 0;
        ld_opcode <= 0;
        ld_result <= 0;
        clr_result <= 0;
        sel_muxAlu <= 0;
        sel_muxDisplay <= 0;
        clr_opCode <= 0;
        
        //If opcode doesn't change, it stays the same
        if(opCodeOut == 3'b000)
             nextstate <= S0; 
        //if user enters a number
        else if(opCodeOut == 3'b001) 
            begin
                //load the number enter
                ld_number <= 1;
                   //go to the next state
                nextstate = S1;
                //close state 0 
                E0 = 0;                        
            end
        end
            
        //------------------state 1------------------------------
        S1:begin
     
            //display the current state
            E1 <= 1;

            //display the value enter (Si el este esta en 0 va a display lo que el usuario ingrese)
            sel_muxDisplay <= 0;
            
            //if user press enter cargarmos el numero en memorio (input register)
            if(opCodeOut == 3'b010);
            begin
                ld_number = 0; //load the new number into input reg
                ld_result = 1; //cargamos el numero dentro de AccRegister
            end        
            //si el usuario preciona un simbolo   
                if(opCodeOut == 3'b100 || opCodeOut == 3'b101 || opCodeOut == 3'b110 || opCodeOut == 3'b111)
                begin
                    ld_result <= 0; //va a dejar de cargar dentro de ACC register
                    sel_muxAlu <= 1; //El multiplexer al lado del ALU va a cargar lo que salga del ALu
                    ld_opcode <= 1; //Cargamos el opCode dentro del Multiplexer
                    nextstate = S2; //vamos al siguiente estado
                    E1 <= 0; // apagamos la visualizacion de este estado (S1)
                end
          
           
        end
        //--------------------state 2------------------------------
       S2:begin
            
            //prendemos la visualizacion 
            E2 <= 1;
            
            //display value of accRegister
            sel_muxDisplay <= 1;
            
            //if user press enter
            if(opCodeOut == 3'b010);   
                ld_opcode = 0; //Turn off the current OpCode
             
             //After user presses a number
              if(opCodeOut == 3'b001)
                 begin
                   ld_number <= 1; //cargamos ese numero dentro de input Register
                    sel_muxAlu = 1; //turn mux of the ALu on 1
                    clr_number = 1;#15; //Remove current number input while we load new one
                    clr_number = 0; //Turn off clear
                    nextstate = S3; //Go to state 3
                    E2 <= 0; //Shut off state
                 end
            
        end 
        //----------------------------state 3-----------------------------------------
       S3:begin
            
            //turn on this state
            E3 <= 1;
            
            //display the input reg
            sel_muxDisplay <= 0;
            
           //if user press enter
           if(opCodeOut == 3'b010)
              begin
                ld_number = 0; //dejamos de carga el numero              
                ld_result = 1; // cargamos el numero dentro de AccRegister
              end
               //if user press a simbol
               else if(opCodeOut == 3'b100 || opCodeOut == 3'b101 || opCodeOut == 3'b110 || opCodeOut == 3'b111)
                begin
                   ld_opcode <= 1; //load code inside OpReg
                   ld_result = 0; // Turn off so accRegister can save numbers
                   nextstate = S2; //Go to the next state
                   E3 <= 0; // Turn off current state
                end
           
          end
           
        endcase 
    end
endmodule
