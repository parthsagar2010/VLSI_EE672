`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:07:10 11/07/2018 
// Design Name: 
// Module Name:    Fixed_adder 
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
module Fixed_adder #(parameter WI1 = 4, WF1 = 3, WI2 = 6, WF2 = 2, WIO = 9, WFO = 5) 
(   input signed [WI1+WF1-1:0]in1,
    input signed [WI2+WF2-1:0] in2,
    input rst,
    input clk,
    output reg signed [WIO+WFO-1:0] out,
    output reg ovf);
    parameter temp_WI = (WI2>WI1) ? WI2 : WI1;
    parameter temp_WF = (WF2>WF1) ? WF2 : WF1;
    reg signed [temp_WI+temp_WF:0]in1_final;
    reg signed [temp_WI+temp_WF:0]in2_final;
	 reg signed [temp_WI+temp_WF:0]out_final;
    reg signed [temp_WI-1:0]tmp;
    reg signed [temp_WI+temp_WF-1:0]in1_temp;
    reg signed [temp_WI+temp_WF-1:0]in2_temp;
    always @(posedge clk)
    begin
     if(rst)
		  begin
				 out = 0;
				 ovf = 0;
		  end
	  else
     begin
			  begin
					  if (WI1<WI2)
						  begin
								in1_temp = { {(WI2-WI1) {in1[WI1+WF1-1]} } , in1};
								in2_temp = in2;
								 $display("WI1<WI2"); 
						  end
					  else if (WI1>WI2)
						  begin
								in1_temp = in1;
								in2_temp = { { (WI1-WI2) {in2[WI2+WF2-1]} } ,in2};
								 $display("WI1>WI2"); 
						  end
					  else if (WI1==WI2)
						  begin
								 in1_temp = in1;
								 in2_temp = in2;
								  $display("WI1==WI2"); 
						  end
			  end
			  $display("in1_temp=%b",in1_temp);
			  $display("in2_temp=%b",in2_temp);
			  
			  //checking for fracional part
			  begin
				  if (WF1<WF2) begin
				  $display("WF1<WF2"); 
				  $display("First in1_temp=%b",in1_temp);
						 in1_temp = { in1_temp, {(WF2-WF1) {1'b0} } };
						 $display("Now in1_temp=%b",in1_temp);
						 end
					else if(WF2<WF1)
					$display("WF2<WF1"); 
						 in2_temp = { in2_temp, {(WF1-WF2) {1'b0} } };
				end   
				$display("After in1_temp=%b in2_emp =%b",in1_temp,in2_temp);       
			  
			  //sign exending both operands by one bit
			  in2_temp[temp_WI+temp_WF] = in2_temp[temp_WI+temp_WF-1];
			  in1_temp[temp_WI+temp_WF] = in1_temp[temp_WI+temp_WF-1];
			  $display("Finally in1_temp=%b in2_emp =%b",in1_temp,in2_temp);           
			  out_final = in1_temp + in2_temp;
				$display("out_final = %b",out_final);
			// Checking Overflow condition 1 When the WIO and WFO are greater than temp variables
			$display("temp_WI = %b",temp_WI);
			$display("temp_WF = %b",temp_WF);
			if ((WIO > (temp_WI+1)) && (WFO > (temp_WF+1)))
				begin
					$display("Condition 1"); 
					out = {{(WIO - (temp_WI+1)){out_final[temp_WI+temp_WF]}} , {out_final[temp_WI+temp_WF : 0]}};
					out = {out, {(WFO-temp_WF){1'b0}}};
					ovf = 0;
					$display("Out = %b",out); 
				end
			// Overflow Condition 2 [WIO=max(WI1,WI2), WFO=max(WF1,WF2);]
			if((WIO == temp_WI) && (WFO == temp_WF))
				begin
					$display("Condition 2"); 
					out = out_final[temp_WI+temp_WF-1 : 0];
					if ( ( in1[WI1+WF1-1] == in2[WI2+WF2-1] == ~out[WIO+WFO -1]) || (~in1[WI1+WF1-1]== ~in2[WI2+WF2 -1] == out[WIO+WFO -1]) )
						 ovf = 1; 
					else 
						 ovf = 0; 
			  end
		  else if (((WIO < temp_WI) && (WFO < temp_WF)))
			  begin
					$display("Condition 3"); 
					out = {out_final[temp_WI+temp_WF], out_final[WIO+WFO-2:temp_WF] , out_final[temp_WF:temp_WF-WFO]};
					//tmp = {{out_final[temp_WI+temp_WF]},{out_final[temp_WI+temp_WF:temp_WI+temp_WF-(temp_WI-WIO)]}};
					$display("Tmp = %b",tmp); 
				  if ( (in1[WI1+WF1-1] == in2[WI2+WF2 -1] == (&tmp) ) ||    (~in1[WI1+WF1-1]==~in2[WI2+WF2 -1]== (|tmp) ) ) 
						 ovf = 0; 
					else 
						 ovf = 1; 
			  end
     /************/
     /* //Checking for overflow
        if((WIO > (temp_WI+1)) && (WFO > (temp_WF+1)))
        begin
            out[WIO-1: WIO-temp_WI] = { temp_WI {out[temp_WI]} };
            //out[ : 0] = {  {1'b0}};
            ovf = 0;
        end    
        else if ((WIO == temp_WI) && (WFO == temp_WF)) 
        begin
            if ( ( in1[WI1+WF1-1] == in2[WI2+WF2-1] == ~out[WIO+WFO -1]) || (~in1[WI1+WF1-1]== ~in2[WI2+WF2 -1] == out[WIO+WFO -1]) )
                ovf = 1; 
            else 
                ovf = 0; 
        end
        else if ((WIO < temp_WI) && (WFO < temp_WF))
        begin
        
           // if ( (in1[WI1+WF1-1] == in2[WI2+WF2 -1] == (&tmp) ) ||    (~in1[WI1+WF1-1]==~in2[WI2+WF2 -1]== (|tmp) ) ) 
                ovf = 0; 
            else 
                ovf = 1; 
        end
        */
     end 
    end
endmodule
