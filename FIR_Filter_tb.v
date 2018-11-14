`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:11:08 11/11/2018
// Design Name:   FIR_Filter
// Module Name:   C:/xilinx2/projects/VLSI_EE672/FIR_Filter_tb.v
// Project Name:  VLSI_EE672
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FIR_Filter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module FIR_Filter_tb;

	// Inputs
	reg clk;
	reg reset;
	reg Load_x;
	reg [8:0] x_in;
	reg [8:0] c_in;

	// Outputs
	wire [10:0] y_out;

	// Instantiate the Unit Under Test (UUT)
	FIR_Filter uut (
		.clk(clk), 
		.reset(reset), 
		.Load_x(Load_x), 
		.x_in(x_in), 
		.c_in(c_in), 
		.y_out(y_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		Load_x = 0;
		x_in = 0;
		c_in = 0;

		// Wait 100 ns for global reset to finish
		#10;
		Load_x = 1;
		x_in = 9'b001100111;
		c_in = 9'b010101010;

		#10;
		Load_x = 0;
		x_in = 9'b001110111;
		c_in = 9'b010111010;
		
		#10;
		Load_x = 1;
		x_in = 9'b001100001;
		c_in = 9'b010101000;

        
		// Add stimulus here

	end
	
	always
 #10 clk = ~clk;
      
endmodule

