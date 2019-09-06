`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2018 11:16:19 PM
// Design Name: 
// Module Name: datapath
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


module datapath(mclk, reset, startaddr, n, max, addra, douta, count, limit, sreset);

	// Input
	input mclk, reset;
	input [7:0] n;
	input [15:0] startaddr;
	input [15:0] douta;
	
	// Output
	output [7:0] addra;
	output [15:0] max;
    output [7:0] count;
    output limit;
    output sreset;
	
	compare find(
	   .mclk(mclk), 
	   .reset(reset), 
	   .startaddr(startaddr), 
	   .count(count), 
	   .addra(addra), 
	   .douta(douta), 
	   .max(max),
	   .sreset(sreset)
	   );
	
	next val(
	   .n(n),
	   .reset(reset),
	   .mclk(mclk),
	   .count(count),
	   .limit(limit),
	   .sreset(sreset)
	   );
	   
  

endmodule
