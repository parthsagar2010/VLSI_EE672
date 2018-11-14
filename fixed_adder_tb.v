`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:22:36 11/07/2018 
// Design Name: 
// Module Name:    fixed_adder_tb 
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
module fixed_adder_tb;
parameter WI1 = 4, WF1 = 3, WI2 = 6, WF2 = 2, WIO = 9, WFO = 5;
reg signed [WI1+WF1-1:0]in1;
reg signed [WI2+WF2-1:0] in2;
/*
reg signed [9 : 0] RAM1 [0 : 34];
reg signed [11 : 0] RAM2 [0 : 34];
*/

reg rst;
reg clk;
wire [WIO+WFO-1:0] out;
wire ovf;
Fixed_adder #(.WI1(WI1), .WF1(WF1), .WI2(WI2), .WF2(WF2), .WIO(WIO), .WFO(WFO)) UUT ( .in1(in1), .in2(in2), .rst(rst), .clk(clk), .out(out), .ovf(ovf));

integer i;
initial begin
/*5.4
		01111_1111 - largest positive
		00000_0001 - smallest positive
		11111_1111 - largest negative
		10000_0000 - smallest negative

		7.3 
		0111111_111 - largest positive
		0000000_001 - smallest positive
		1111111_111 - largest negative
		1000000_000 - smallest negative
		*/
		
		
		clk = 0;
		rst = 1;
		#20;
		rst = 0;
		in1 = 7'b  0111_111;
		in2 = 8'b 011111_11;
		#40;
		in1 = 7'b  1111_111;
		in2 = 8'b 111111_11;
		
	   #40;
		in1 = 7'b  0111_111;
		in2 = 8'b 111111_11;		
		
		/*5.4
		01111_1111 - largest positive
		00000_0001 - smallest positive
		11111_1111 - largest negative
		10000_0000 - smallest negative

		7.3 
		0111111_111 - largest positive
		0000000_001 - smallest positive
		1111111_111 - largest negative
		1000000_000 - smallest negative
		*/
		
		#40;
		in1 = 7'b  0111_111;
		in2 = 8'b 000000_01;		
		
		#40;
		in1 = 7'b  1111_111;
		in2 = 8'b 100000_00;		
			
		#40;
		in1 = 7'b  0111_111;
		in2 = 8'b 100000_00;
		
		/*5.4
		01111_1111 - largest positive
		00000_0001 - smallest positive
		11111_1111 - largest negative
		10000_0000 - smallest negative

		7.3 
		0111111_111 - largest positive
		0000000_001 - smallest positive
		1111111_111 - largest negative
		1000000_000 - smallest negative
		*/
		
		#40;
		in1 = 7'b  0000_001;
		in2 = 8'b 011111_11;		
		
		#40;
		in1 = 7'b  1000_000;
		in2 = 8'b 111111_11;		
			
		#40;
		in1 = 7'b  0000_001;
		in2 = 8'b 111111_11;
		
		/*5.4
		01111_1111 - largest positive
		00000_0001 - smallest positive
		11111_1111 - largest negative
		10000_0000 - smallest negative

		7.3 
		0111111_111 - largest positive
		0000000_001 - smallest positive
		1111111_111 - largest negative
		1000000_000 - smallest negative
		*/
		
		#40;
		in1 = 7'b  0000_001;
		in2 = 8'b 000000_01;		
		
		#40;
		in1 = 7'b  1000_000;
		in2 = 8'b 000000_01;		
			
		#40;
		in1 = 7'b  0000_001;
		in2 = 8'b 100000_00;
/*
$readmemb("C:/xilinx2/projects/VLSI_EE672/randomData_1.txt",RAM1);
$readmemb("C:/xilinx2/projects/VLSI_EE672/randomData_2.txt",RAM2);

	for(i = 0; i < 35; i = i + 1) begin
		in1 <= RAM1[i];
		in2 <= RAM2[i];
		@(posedge clk);
	end
	@(posedge clk);
	$stop;
end
*/
/*
initial 
begin
    clk = 0; rst = 1;
    //#10 rst = 0; in1 = 2'sb10; in2 = 2'sb0101;
    //#30 in1 = 2'sb00; in2 = 2'sb0111;
    //#10 in1 = 2'sb10; in2 = 2'sb1111;
	     #10 rst = 0; in1 = 5'sb10111; in2 = 5'sb10111;
    //#30 in1 = 2'sb00; in2 = 2'sb0111;
	 #10 rst = 0; in1 = 5'sb01101; in2 = 5'sb00000;
    #10 rst = 0; in1 = 5'sb01011; in2 = 5'sb01110;
    #10 rst = 0; in1 = 5'sb01110; in2 = 5'sb01011;
    #30 $finish;
end
*/
end
always
 #10 clk = ~clk;

always @in1 inf1 = fixedToFloat(in1, 4, 3);
always @in2 inf2 = fixedToFloat(in2, 6, 2);
always @out outf = fixedToFloat(out, 9, 5);

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
