`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:52:40 11/11/2018 
// Design Name: 
// Module Name:    FIR_Filter 
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
// This is a generic FIR filter generator
// It uses W1 bit data/coefficients bits
module FIR_Filter
#(parameter W1 = 9, // Input bit width
W2 = 18, // Multiplier bit width 2*W1
W3 = 19, // Adder width = W2+log2(L)-1
W4 = 11, // Output bit width
L = 4) // Filter length
(input clk, // System clock
input reset, // Asynchronous reset
input Load_x, // Load/run switch
input signed [W1-1:0] x_in, // System input
input signed [W1-1:0] c_in, //Coefficient data input
output signed [W4-1:0] y_out); // System output
// --------------------------------------------------------
reg signed [W1-1:0] x;
wire signed [W3-1:0] y;
// 1D array types i.e. memories supported by Quartus
// in Verilog 2001; first bit then vector size
reg signed [W1-1:0] c [0:3]; // Coefficient array
wire signed [W2-1:0] p [0:3]; // Product array
reg signed [W3-1:0] a [0:3]; // Adder array
//----> Load Data or Coefficient
always @(posedge clk or posedge reset)
begin: Loads
integer k; // loop variable
if (reset) begin // Asynchronous clear
for (k=0; k<=L-1; k=k+1) c[k] <= 0;
x <= 0;
end else if (! Load_x) begin
c[2] <= c_in; // Store coefficient in register
c[1] <= c[2]; // Coefficients shift one
c[0] <= c[1];
end else
//814 Verilog Code
x <= x_in; // Get one data sample at a time
end
//----> Compute sum-of-products
always @(posedge clk or posedge reset)
begin: SOP
// Compute the transposed filter additions
integer k; // loop variable
if (reset) // Asynchronous clear
for (k=0; k<=3; k=k+1) a[k] <= 0;
else begin
a[0] <= p[0] + a[1];
a[1] <= p[1] + a[2];
a[2] <= p[2]; // First TAP has only a register
end
end
assign y = a[0];
genvar I; //Define loop variable for generate statement
generate
for (I=0; I<L; I=I+1) begin : MulGen
// Instantiate L multipliers
assign p[I] = x * c[I];
end	
endgenerate
assign y_out = y[W3-1:W3-W4];
endmodule
