`timescale 1ns / 1ns

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:50:42 11/06/2018
// Design Name:   lifo_stack
// Module Name:   C:/xilinx2/projects/VLSI_EE672/lifo_tb.v
// Project Name:  VLSI_EE672
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: lifo_stack
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module lifo_tb;
	parameter Wl = 6;
	parameter N = 3;
	// Inputs
	reg clk,reset,push,pop;
	reg [Wl - 1:0] dio;
	 wire [Wl - 1:0] q;
	//wire error,full,empty;
lifo_stack #( .Wl(6), .N(3)) uut ( .clk(clk), .reset(reset), .dio(dio), .q(q), .push(push), .pop(pop));
	// Instantiate the Unit Under Test (UUT)

	
//clock signal
parameter clockperiod = 6;
initial clk = 1;
always #(clockperiod/2) clk = ~clk;
	
	initial begin
		// Initialize Inputs
		// Wait 100 ns for global reset to finish
		clk = 0;
		#10;
       reset = 1'b0;
		 
		// Add stimulus here
				#10;
		// Add stimulus here
		dio = 6'b000111;
		push = 1'b1;
		
		#10;
		//@(posedge clk);
		// Add stimulus here
		dio = 6'b000101;
		push = 1'b1;
		
		#10;
		clk = 0;
	//	@(posedge clk);
		// Add stimulus here
		dio = 6'b010111;
		push = 1'b1;
		
		#10;
		//	@(posedge clk);
		// Add stimulus here
		//dio = 6'b000111;
			push = 1'b0;
		pop = 1'b1;
				#10;
		pop = 1'b1;
				#10;
		pop = 1'b1;
				#10;
		pop = 1'b1;
	end
      
endmodule

