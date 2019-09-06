`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2018 01:36:44 PM
// Design Name: 
// Module Name: mem
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


module mem(clka, ena, addra, douta);

input [0:7]addra;
input clka, ena;
output [15:0]douta;

design_1 memo(
    .addra_0(addra),
    .clka_0(clka),
    .douta_0(douta),
    .ena_0(ena)
    );

endmodule
