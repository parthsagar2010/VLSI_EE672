`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:06:02 11/07/2018 
// Design Name: 
// Module Name:    fixed_mult_tb 
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
module fixed_mult_tb;
parameter WI1 = 3, WF1 = 2, WI2 = 4, WF2 = 2, WIO=7, WFO = 4;
   reg signed[WI1+WF1-1:0]in1;
	reg signed[WI2+WF2 - 1:0]in2;
	reg rst;
	reg clk;
	wire signed[WIO+WFO-1:0] out;
	wire ovf;
	reg signed [9 : 0] RAM1 [0 : 34];
reg signed [11 : 0] RAM2 [0 : 34];

//real qout
//always @(UUT1.tmp)fixedToFloat(UUT1.qout[])
//always @in1 inf1 = fixedToFloat(, 5, 4);
integer i;
Fixed_Multiplier #(.WI1(WI1), .WF1(WF1), .WI2(WI2), .WF2(WF2), .WIO(WIO), .WFO(WFO)) UUT1 ( .in1(in1), .in2(in2), .rst(rst), .clk(clk), .out(out), .ovf(ovf));
initial 
begin
    clk = 0; rst = 1;
    #10 rst = 0; in1 = 5'sb00000; in2 = 6'sb011101;
    //#30 in1 = 2'sb00; in2 = 2'sb0111;
	 #10 rst = 0; in1 = 5'sb01101; in2 = 6'sb010101;
    #10 rst = 0; in1 = 5'sb10101; in2 = 6'sb001101;
    //#10 rst = 0; in1 = 5'sb111; in2 = 4'sb0000;
    
    //#10 in1 = 2'sb10; in2 = 2'sb1111;
	 $readmemb("C:/xilinx2/projects/VLSI_EE672/randomData_1.txt",RAM1);
$readmemb("C:/xilinx2/projects/VLSI_EE672/randomData_2.txt",RAM2);

	for(i = 0; i < 35; i = i + 1) begin
		in1 <= RAM1[i];
		in2 <= RAM2[i];
		@(posedge clk);
	end
	@(posedge clk);
	$stop;
	 
    #30 $finish;
end
always
 #5 clk = ~clk;

always @in1 inf1 = fixedToFloat(in1, 3, 2);
always @in2 inf2 = fixedToFloat(in2, 4, 2);
always @out outf = fixedToFloat(out, 4, 2);

real inf1,inf2,outf;


function real fixedToFloat;
input [63:0] in;
input integer WI;
input integer WF;
integer idx;
real retVal;
begin
 retVal = 0;
 for (idx = 0; idx < WI+WF-1; idx = idx + 1) begin
if(in[idx] == 1'b1) begin
retVal = retVal + (2.0**(idx-WF));
end
 end
 fixedToFloat = retVal - (in[WI+WF-1] * (2.0**(WI-1)));
end
endfunction

endmodule
