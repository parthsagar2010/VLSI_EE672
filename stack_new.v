`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:22:52 11/07/2018 
// Design Name: 
// Module Name:    stack_new 
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
module stack_new( dataIn,
                   dataOut,
                   PUSH,
						 POP,
                   EN,
                   Rst,
                   EMPTY,
                   FULL,
                   Clk
                  );
input [3:0]  dataIn;
input        PUSH,
				 POP,
             EN,
             Rst,
             Clk;
output  reg EMPTY,
            FULL;    
output reg [3:0] dataOut;
reg [3:0] stack_mem[0:3];
reg  [2:0] SP;
integer i;
always @ (posedge Clk)
begin
 if (EN==0);
 else begin
    if (Rst==1) begin
      SP       = 3'd4;
      EMPTY    = SP[2];
      dataOut  = 4'h0;
      for (i=0;i<4;i=i+1) begin
        stack_mem[i]= 0;
      end
     end
  else if (Rst==0) begin
    FULL = SP? 0:1;
    EMPTY  = SP[2];
    dataOut = 4'hx;
    if (FULL == 1'b0 && PUSH == 1'b1) begin
       SP            = SP-1'b1;
       FULL          = SP? 0:1;
       EMPTY         = SP[2];
       stack_mem[SP] = dataIn;
     end
   else if (EMPTY == 1'b0 && POP == 1'b1) begin
       dataOut  = stack_mem[SP];
       stack_mem[SP] = 0;
       SP  = SP+1;
       FULL  = SP? 0:1;
       EMPTY  = SP[2];
    end
   else;
  end
  else;
 end
end
endmodule
