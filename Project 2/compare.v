`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2018 02:52:11 PM
// Design Name: 
// Module Name: compare
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


module compare(mclk, reset, startaddr, count, addra, douta, max, sreset);
    
    // Input
    input mclk, reset, sreset;
    input [15:0] startaddr;
    input [15:0] douta;
    
    // Output
    output reg [7:0] addra;
    output reg [15:0] max;
    output [7:0] count;
    
    always @(posedge mclk)
    begin
        if(reset || sreset)
        begin
            addra <= 0;
            max <= 0;
        end
        
        else
        begin
            addra <= startaddr + count;
            if(douta > max)
            begin
                max <= douta;
            end
            else
                max <= max;
        end
    
    end
endmodule
