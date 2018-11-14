`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:36:53 11/07/2018 
// Design Name: 
// Module Name:    FSM_three_always 
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
module FSM_three_always(
input x,clk,
output reg z);
localparam S0 = 0,S1 = 1, S2 = 2, S3 = 3;
reg [0:1] state, nextstate;
always @ (posedge clk)
state <= nextstate;

always @ (state,x)
case (state)
S0: begin
nextstate = x ? S1 : S0;
end;
S1: begin
nextstate = x ? S0 : S2;
end;
S2: begin
nextstate = x ? S3 : S0;
end;
S3: begin
nextstate = x ? S0 : S4;
end;
S4: begin
nextstate = x ? S0 : S0;
end;

endcase
//////////////////////////

always @ (state,x)
case (state)
S0: begin
z = x ? 0 : 0;
end;
S1: begin
z= x ? 0 : 0;
end;
S2: begin
z = x ? 0 : 0;
end;
S3: begin
z= x ? 0 : 0;
end;
S4: begin
z= x ? 0 : 1;
end;

endcase





endmodule
