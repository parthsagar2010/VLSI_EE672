`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:50:57 11/11/2018 
// Design Name: 
// Module Name:    filter_2 
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
module filter_2
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

endmodule
