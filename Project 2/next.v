`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2018 02:52:11 PM
// Design Name: 
// Module Name: next
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


module next(n, reset, mclk, count, limit, sreset);

	// Input
	input mclk, reset, sreset;
	input [7:0] n;
	
    // Output
    output reg [7:0] count;
    output reg limit;
    
    always @(posedge mclk)
    begin

        if(reset || sreset)
        begin
        count = 0;
        limit = 0;
        end
        
        else if(count == n || count > n)
        begin
        @(posedge mclk)
        limit = 1;
        end
        
        else 
        begin
        count = count + 1;
        end
    
    end
endmodule
