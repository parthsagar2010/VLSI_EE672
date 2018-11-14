`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:49:03 11/06/2018 
// Design Name: 
// Module Name:    lifo_stack 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module lifo_stack #(parameter Wl = 6,
	parameter N = 3)
(	input clk,
	input reset,
	input [Wl - 1:0] dio,
	output reg [Wl - 1:0] q,
	input  push,
	input  pop,
	output reg error,
	output reg full,
	output reg empty );

	
	reg [N - 1:0] ptr;
	reg [Wl - 1:0] stack [0:6];
	

	always @(posedge clk)begin
		if (reset)
			ptr = 0;
		else if (push & ptr<3'b111)
			ptr = ptr + 1;
		else if (pop & ptr>3'b000)
			ptr = ptr - 1;
			else
			error = 1'b1;
			
		$display("ptr =%b",ptr );
		$display("full =%b",full );
		$display("empty =%b",empty );
				$display("Pointer=%b",ptr);
			  $display("Stack=%b",stack);		
		end
	always @(ptr)begin
		if(ptr==3'b111)
		full = 1'b1;
		else if(ptr==3'b000)begin
		empty = 1'b1;
		end
		$display("ptr =%b",ptr );
		$display("full =%b",full );
		$display("empty =%b",empty );
				$display("Pointer=%b",ptr);
			  $display("Stack=%b",stack);				
	end
	
	always @(posedge clk) begin
			
			if(push == 1'b1)
			begin
				stack[ptr] = dio;
				q = 5'b00000;
				end
				else
				q = stack[ptr - 1];	
	
				
		$display("ptr =%b",ptr );
		$display("full =%b",full );
		$display("empty =%b",empty );
				$display("Pointer=%b",ptr);
			  $display("Stack=%b",stack);		
		     end
			  
endmodule
