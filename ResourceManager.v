//=============================================
// DFF w/enable
//=============================================
module EndableDFF(clk, enable,in,out);
  parameter n=1;//width
  input enable;
  input clk;
  input [n-1:0] in;
  output [n-1:0] out;
  reg [n-1:0] out;
  
  
  always @(enable and clk)
  out = in;
 endmodule
 //End DFF
 
 
 module Add_half(input a, input b,output cout,output sum);

xor ( sum , a ,b);
and (cout, a, b);
endmodule
 
 
 module Add_full( input a,input b,input cin,output cout,output  sum);
	
	wire w1, w2, w3;   //   
	
	// instantiation half adder
	Add_half M1 (a, b, w1, w2);
	Add_half M0 (w2, cin, w3, sum);    
	
	or (cout, w1,w3);
endmodule

module SimpleXor(x,y,xxory);
	input x;
	input y;
	output xxory;
	reg xxory;
	always @(*) begin
	xxory= x ^ y;
	end
endmodule

 
 
module EightBitAdderSubtractor(input [7:0] a, b, input cin, output cout,output [7:0] sum);
	wire carry[7:0];
	wire xoredB [7:0];
	SimpleXor firstBit (cin, b[0], xoredB[0]);
	SimpleXor secondBit (cin, b[1], xoredB[1]);
	SimpleXor thirdBit (cin, b[2], xoredB[2]);
	SimpleXor fourthBit (cin, b[3], xoredB[3]);
	SimpleXor fifthbit (cin, b[4], xoredB[4]);
	SimpleXor sixthbit (cin, b[5], xoredB[5]);
	SimpleXor seventhbit (cin, b[6], xoredB[6]);
	SimpleXor eighthbit (cin, b[7], xoredB[7]);
	
	 Add_full M0 (a[0], xoredB[0], cin,  carry[0], sum[0]);
	 Add_full M1 (a[1], xoredB[1], carry[0],  carry[1], sum[1]);
	 Add_full M2 (a[2], xoredB[2], carry[1],  carry[2], sum[2]);
	 Add_full M3 (a[3], xoredB[3], carry[2],  carry[3], sum[3]);
	 Add_full M4 (a[4], xoredB[4], carry[3],  carry[4], sum[4]);
	 Add_full M5 (a[5], xoredB[5], carry[4],  carry[5], sum[5]);
	 Add_full M6 (a[6], xoredB[6], carry[5],  carry[6], sum[6]);
	 Add_full M7 (a[7], xoredB[7], carry[6],  cout, sum[7]);
endmodule
 
 
 
 module Energy(input enable, input clk, input load[7:0], output out[7:0]);
 EndableDFF firstBit (enable, clk, load[0], out[0]);
	 EndableDFF secondBit (enable, clk, load[1] out[1]);
	 EndableDFF thirdBit (enable, clk, load[2], out[2]);
	 EndableDFF fourthBit (enable, clk, load[3], out[3]);
	 EndableDFF fifthBit (enable, clk, load[4], out[4]);
	 EndableDFF sixthBit (enable, clk, load[5], out[5]);
	 EndableDFF seventhbit (enable, clk, load[6], out[6]);
	 EndableDFF eigthBit (enable, clk, load[5], out[7]);
		
 endmodule
 
 module SpiderTracer(input enable, input clk, input load[5:0], output out[5:0]);
    EndableDFF firstBit (enable, clk, load[0], out[0]);
	EndableDFF secondBit (enable, clk, load[1] out[1]);
	EndableDFF thirdBit (enable, clk, load[2], out[2]);
	EndableDFF fourthBit (enable, clk, load[3], out[3]);
	EndableDFF fifthBit (enable, clk, load[4], out[4]);
	EndableDFF sixthBit (enable, clk, load[5], out[5]);
 endmodule
 
 module Fluid(input enable, input clk, input load[3:0], output out[3:0]);
 EndableDFF firstBit (enable, clk, load[0], out[0]);
	 EndableDFF secondBit (enable, clk, load[1] out[1]);
	 EndableDFF thirdBit (enable, clk, load[2], out[2]);
	  EndableDFF fourthBit (enable, clk, load[3], out[3]);
	   
 endmodule