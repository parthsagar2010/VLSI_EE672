`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:47:26 11/07/2018 
// Design Name: 
// Module Name:    Fixed_Multiplier 
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
module Fixed_Multiplier #(parameter WI1 = 3, WF1 = 2, WI2 = 4, WF2 = 2, WIO=7, WFO = 4)
(   input signed [WI1+WF1-1:0]in1,
	 input signed [WI2+WF2 - 1:0]in2,
	 input rst,
	 input clk,
	 output reg signed [WIO+WFO-1:0] out,
	 output reg ovf);
	 parameter temp_WI = WI1+WI2; 
	 parameter temp_WF = WF1+WF2;
	 parameter tmp_W = temp_WI + temp_WF;
	// parameter diff_Int = temp_WI-WIO;
	// parameter diff_fract = temp_WF-WFO;	 
	 reg signed [tmp_W-1:0]tmp;
	 
	 always @(posedge clk)
	 begin
		if(rst)
			begin
			out = 0;
			ovf = 0;
			end
		else
			$display("in1=%b",in1);
			$display("in2=%b",in2);
			tmp = in1*in2;
			$display("tmp=%b",tmp);
			begin
				if((WIO+WFO)==tmp_W)
					begin
					out = tmp;
					$display("tmp_W=%b",tmp_W);
					$display("Inside if");
					ovf = 0;
					end
				else if (WIO> (WI1 + WI2))	
					begin
					out = { {(WIO-WI1-WI2) {tmp[tmp_W-1]} } , tmp};					
					$display("Inside If else Sign Extension");
					$display("Out=%b",out);
					ovf = 0;
					end
			
		   	else if (WIO < (WI1 + WI2))	
					begin
					out = {{tmp[tmp_W-1]},{tmp[WF1+WF2+WIO-2:WF1+WF2]},{tmp[WF1+WF2-1:WF1+WF2-WFO]}};					
					$display("Inside If else Truncation");
					$display("Out=%b",out);
					ovf = 1;
					end	
					
			end
					$display("Out=%b",out);
			
	  end

endmodule
