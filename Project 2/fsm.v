`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2018 11:08:50 PM
// Design Name: 
// Module Name: fsm
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


module fsm(mclk, reset, start, done, sreset, state, limit);

	// Input Register
	input mclk, reset, start, limit;
	//input limit;
	
	// Output Register
	output reg done;
	output reg sreset = 0;
	
	output reg [2:0] state;
	reg [2:0] nstate;
	
	parameter S0 = 0;  //reset all and wait
	parameter S1 = 1;  //start
	parameter S2 = 2;  //done
	
	always @(posedge mclk)
	begin
	    if(reset == 1) //if a reset is thrown from the testbench, enter reset state
        begin
            state = S0;
        end
	    else if(start == 1) //Turning off all reset values
        begin
           state = S1;
        end        
        else if(limit == 1)
        begin
            state = S2; 
        end        	
        else
        begin
           state = nstate;
        end
        

    end



    always @(*)begin
        case(state)
        
        S0: begin
                sreset = 1;
                //nstate = S1;
                done = 0;     
                
                nstate = state;         
                
            end
        
        S1: begin
                sreset = 0;
                done = 0;                
                //if(limit == 1) nstate = S2;
                //else nstate = state;
                nstate = state;
                
            end
        
        S2: begin
                done = 1;
                sreset = 1;
                nstate = state;
            end
        
                
        endcase
    end
endmodule
