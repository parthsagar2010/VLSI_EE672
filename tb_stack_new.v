`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:23:48 11/07/2018
// Design Name:   stack_new
// Module Name:   C:/xilinx2/projects/VLSI_EE672/tb_stack_new.v
// Project Name:  VLSI_EE672
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: stack_new
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_stack_new;
 reg [3:0] dataIn;
 reg PUSH;
 reg POP;
 reg EN;
 reg Rst;
 reg Clk;
 // Outputs
 wire [3:0] dataOut;
 wire EMPTY;
 wire FULL;
 // Instantiate the Unit Under Test (UUT)
 stack_new uut (
                 .dataIn(dataIn), 
                 .dataOut(dataOut), 
                 .PUSH(PUSH),
					  .POP(POP),
                 .EN(EN), 
                 .Rst(Rst), 
                 .EMPTY(EMPTY), 
                 .FULL(FULL), 
                 .Clk(Clk)
                );
 initial begin
  // Initialize Inputs
  dataIn  = 4'h0;
  PUSH  = 1'b0;
  POP   = 1'b0;
  EN  = 1'b0;
  Rst  = 1'b1;
  Clk  = 1'b0;
  // Wait 100 ns for global reset to finish
  #100;      
  // Add stimulus here
  EN   = 1'b1;
  Rst  = 1'b1;
  #40;
  Rst     = 1'b0;
  PUSH      = 1'b1;
  dataIn  = 4'h1;
  #20;
  dataIn = 4'h2;
  #20;
  dataIn = 4'h4;
  #20;
  dataIn = 4'h5;
  #20;
  dataIn = 4'h7;
  #20;
  dataIn = 4'h4;
  #20;
  POP  = 1'b1;
   #20;
	  PUSH      = 1'b1;
  dataIn = 4'h3;
  #20;
  dataIn = 4'h1; 
  #20;
  POP  = 1'b1;
#20;
#20;
#20;
#20;
	  PUSH      = 1'b1;
  dataIn = 4'h2;


 end 
   always #10 Clk = ~Clk;
endmodule
