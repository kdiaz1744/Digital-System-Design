`timescale 1ns / 1ps

// *** THIS MODULE IS INCOMPLETE ***********

module top(input mclk, input reset, input start, input [7:0] n,
           input [15:0] startaddr, output done, output [15:0] max);

wire [15:0] douta;
wire [7:0] addra;
wire [7:0] count;
wire sreset, limit;
wire [2:0] state;


// Instantiate HERE the fsm module
fsm main(
    .mclk(mclk), 
    .reset(reset), 
    .start(start), 
    .done(done),
    .sreset(sreset),
    .limit(limit),
    .state(state)
    );

// Instantiate HERE the datapath module
datapath data(
     .mclk(mclk), 
     .reset(reset), 
     .startaddr(startaddr), 
     .n(n), 
     .max(max), 
     .addra(addra), 
     .douta(douta),
     .count(count),
     .limit(limit),
     .sreset(sreset)
     );

//the memory module(CREATED FOR YOU) is instanced as follows:
mem imem (
	.clka(mclk),
	.ena(1'b1), // read 
	.addra(addra), // memory address 
	.douta(douta)); // data out 

//always @(posedge mclk)
//begin
//#500;
//done = 1;
//end

endmodule
