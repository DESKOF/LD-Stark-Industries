//=============================================
// DFF w/enable
//=============================================
module EnableDFF(enable, clk,in,out, reset);
  parameter n=1;//width
  input enable;
  input clk;
  input [n-1:0] in;
  output [n-1:0] out;
  reg [n-1:0] out;
  input reset;
  
  
  always @((posedge clk)
  if(reset) out = 1;
  if(enable) out = in;
 endmodule
 //End DFF
 
 //Half adder for use in full adder
 module Add_half(input a, input b,output cout,output sum);

    xor ( sum , a ,b);
    and (cout, a, b);
endmodule
 
 //Full adder with 1 bit inputs
 module Add_full( input a,input b,input cin,output cout,output  sum);
	
	wire w1, w2, w3;   //   
	
	// instantiation half adders
	Add_half M1 (a, b, w1, w2);
	Add_half M0 (w2, cin, w3, sum);    
	
	or (cout, w1,w3);
endmodule

//Preforms an xor of x and y and outputs result as xxory
module SimpleXor(x,y,xxory);
	input x;
	input y;
	output xxory;
	reg xxory;
	always @(*) begin
	xxory= x ^ y;
	end
endmodule

 
 //Takes in 2 eight bit numbers and will subtract b from a if cin is one, adds together otherwise 
module EightBitAdderSubtractor(input [7:0] a,input [7:0] b, input cin, output cout,output [7:0] sum);
	wire carry[6:0];
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
 
 //Takes in 2 six bit numbers and will subtract b from a if cin is one, adds together otherwise 
 module SixBitAdderSubtractor(input [5:0] a,input [5:0] b, input cin, output cout,output [5:0] sum);
	wire carry[5:0];
	wire xoredB [5:0];
	SimpleXor firstBit (cin, b[0], xoredB[0]);
	SimpleXor secondBit (cin, b[1], xoredB[1]);
	SimpleXor thirdBit (cin, b[2], xoredB[2]);
	SimpleXor fourthBit (cin, b[3], xoredB[3]);
	SimpleXor fifthbit (cin, b[4], xoredB[4]);
	SimpleXor sixthbit (cin, b[5], xoredB[5]);

	
	 Add_full M0 (a[0], xoredB[0], cin,  carry[0], sum[0]);
	 Add_full M1 (a[1], xoredB[1], carry[0],  carry[1], sum[1]);
	 Add_full M2 (a[2], xoredB[2], carry[1],  carry[2], sum[2]);
	 Add_full M3 (a[3], xoredB[3], carry[2],  carry[3], sum[3]);
	 Add_full M4 (a[4], xoredB[4], carry[3],  carry[4], sum[4]);
	 Add_full M5 (a[5], xoredB[5], carry[4],  cout, sum[5]);
	
endmodule

//Takes in 2 four bit numbers and will subtract b from a if cin is one, adds together otherwise 
module FourBitAdderSubtractor(input [3:0] a, input[3:0] b, input cin, output cout,output [3:0] sum);
	wire carry[3:0];
	wire xoredB [3:0];
	SimpleXor firstBit (cin, b[0], xoredB[0]);
	SimpleXor secondBit (cin, b[1], xoredB[1]);
	SimpleXor thirdBit (cin, b[2], xoredB[2]);
	SimpleXor fourthBit (cin, b[3], xoredB[3]);
	
	
	 Add_full M0 (a[0], xoredB[0], cin,  carry[0], sum[0]);
	 Add_full M1 (a[1], xoredB[1], carry[0],  carry[1], sum[1]);
	 Add_full M2 (a[2], xoredB[2], carry[1],  carry[2], sum[2]);
	 Add_full M3 (a[3], xoredB[3], carry[2],  cout, sum[3]);
	
	
endmodule
 
  //Stores 4 bits by using DFF's, with first being low and eighthbit being the highest
 module Energy(input enable, input clk, input load[7:0], output out[7:0], input reset);
     EndableDFF firstBit (enable, clk, load[0], out[0], reset);
	 EnableDFF secondBit (enable, clk, load[1] out[1], reset);
	 EnableDFF thirdBit (enable, clk, load[2], out[2], reset);
	 EnableDFF fourthBit (enable, clk, load[3], out[3], reset);
	 EnableDFF fifthBit (enable, clk, load[4], out[4], reset);
	 EnableDFF sixthBit (enable, clk, load[5], out[5], reset);
	 EnableDFF seventhbit (enable, clk, load[6], out[6], reset);
	 EnableDFF eighthBit (enable, clk, load[5], out[7], reset);
		
 endmodule
 
  //Stores 4 bits by using DFF's, with first being low and sixth being the highest
 module SpiderTracer(input enable, input clk, input load[5:0], output out[5:0]);
    EnableDFF firstBit (enable, clk, load[0], out[0], reset);
	EnableDFF secondBit (enable, clk, load[1] out[1], reset);
	EnableDFF thirdBit (enable, clk, load[2], out[2], reset);
	EnableDFF fourthBit (enable, clk, load[3], out[3], reset);
	EnableDFF fifthBit (enable, clk, load[4], out[4], reset);
	EnableDFF sixthBit (enable, clk, load[5], out[5], reset);
 endmodule
 
 //Stores 4 bits by using DFF's, with first being low and fourth being the highest
 module Fluid(input enable, input clk, input load[3:0], output out[3:0]);
     EnableDFF firstBit (enable, clk, load[0], out[0], reset);
	 EnableDFF secondBit (enable, clk, load[1] out[1], reset);
	 EnableDFF thirdBit (enable, clk, load[2], out[2], reset);
	 EnableDFF fourthBit (enable, clk, load[3], out[3], reset);
	   
 endmodule

	   
	   
	   
	   
	   
	   
//=============================================================================================
// Decoder to take the user's choice and determine which web type to use.
// The select[0] is the lsb, while the select[2] is the msb. The out[0]
// is the lsb, and the out[7] is the msb. Output out will be one-hot.
module Decoder(input [2:0] select, enable, output [7:0] out);
	reg [7:0] out_temp;
	
	always @*
		case (select)
			3'b000: out_temp = 7'b1000000; // 0
			3'b100: out_temp = 7'b0100000; // 1
			3'b010: out_temp = 7'b0010000; // 2
			3'b110: out_temp = 7'b1000000; // 3
			3'b001: out_temp = 7'b0100000; // 4
			3'b101: out_temp = 7'b0010000; // 5
			3'b011: out_temp = 7'b1000000; // 6
			3'b111: out_temp = 7'b0100000; // 7
		endcase
	
	// if the enable is 0 then all bits of the output will be zero
	assign out = enable ? out_temp : 7'b0000000;
endmodule
