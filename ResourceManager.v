//=============================================
// DFF w/enable
//=============================================
module EnableDFF(input enable, clk, D, output Q, input reset);
	reg Q;
	
	// when the clock encounters a positive edge
	always @(posedge clk)
		begin
			if(reset)
				Q = 1; // if reset was triggered, set Q to one
			if(enable)
				Q = D; // if reset wasn't triggered & enable is 1, set Q to the value of D
		end
endmodule
//End DFF
 
 
//=============================================
//Half adder for use in full adder
module Add_half(input a, input b,output cout,output sum);
    xor ( sum, a, b);
    and (cout, a, b);
endmodule
 
//=============================================
//Full adder with 1 bit inputs
module Add_full( input a,input b,input cin,output cout,output  sum);
	
	wire w1, w2, w3;
	
	// instantiation half adders
	Add_half M1 (a, b, w1, w2);
	Add_half M0 (w2, cin, w3, sum);    
	
	or (cout, w1,w3);
endmodule

//=============================================
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

//==================================================================================
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
 
//=============================================
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

//=============================================
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
 

 
//==================================================================================
//Stores 8 bits by using DFF's, with first being low and eighthbit being the highest
module Energy(input enable, input clk, input [7:0] load, output [7:0] out, input reset);
    wire [7:0] out;
	
	EnableDFF firstBit (enable, clk, load[0], out[0], reset);
	EnableDFF secondBit (enable, clk, load[1], out[1], reset);
	EnableDFF thirdBit (enable, clk, load[2], out[2], reset);
	EnableDFF fourthBit (enable, clk, load[3], out[3], reset);
	EnableDFF fifthBit (enable, clk, load[4], out[4], reset);
	EnableDFF sixthBit (enable, clk, load[5], out[5], reset);
	EnableDFF seventhbit (enable, clk, load[6], out[6], reset);
	EnableDFF eighthBit (enable, clk, load[7], out[7], reset);
endmodule
 
 //=============================================
//Stores 6 bits by using DFF's, with first being low and sixth being the highest
module SpiderTracer(input enable, input clk, input [5:0] load, output [5:0] out, input reset);
	wire [5:0] out;
	
	EnableDFF firstBit (enable, clk, load[0], out[0], reset);
	EnableDFF secondBit (enable, clk, load[1], out[1], reset);
	EnableDFF thirdBit (enable, clk, load[2], out[2], reset);
	EnableDFF fourthBit (enable, clk, load[3], out[3], reset);
	EnableDFF fifthBit (enable, clk, load[4], out[4], reset);
	EnableDFF sixthBit (enable, clk, load[5], out[5], reset);
endmodule
 
 //=============================================
//Stores 4 bits by using DFF's, with first being low and fourth being the highest
module Fluid(input enable, input clk, input [3:0] load, output [3:0] out, input reset);
    wire [3:0] out;
	
	EnableDFF firstBit (enable, clk, load[0], out[0], reset);
	EnableDFF secondBit (enable, clk, load[1], out[1], reset);
	EnableDFF thirdBit (enable, clk, load[2], out[2], reset);
	EnableDFF fourthBit (enable, clk, load[3], out[3], reset);   
endmodule










//==================================================================================
// Loads the initial 256 (11111111) energy units
module LoadEnergy(input enable, reset, clk, output [7:0] out);
	wire [7:0] out;
	reg [7:0] load;
	initial begin
		load[0] = 1;
		load[1] = 1;
		load[2] = 1;
		load[3] = 1;
		load[4] = 1;
		load[5] = 1;
		load[6] = 1;
		load[7] = 1;
	end
	
	Energy en (enable, clk, load, out, reset);
endmodule


//=============================================
// Loads the initial 64 (111111) tracers
module LoadTracers(input enable, clk, output [5:0] out);
	wire [5:0] out;
	wire zero = 0;
	reg [5:0] load;
	initial begin
		load[0] = 1;
		load[1] = 1;
		load[2] = 1;
		load[3] = 1;
		load[4] = 1;
		load[5] = 1;
	end
	
	SpiderTracer st (enable, clk, load, out, zero);
endmodule


//=============================================
// Loads the initial 16 (1111) doses of fluid
module LoadFluid(input enable, clk, output [3:0] out);
	wire [3:0] out;
	wire zero = 0;
	reg [3:0] load;
	initial begin
		load[0] = 1;
		load[1] = 1;
		load[2] = 1;
		load[3] = 1;
	end
	
	Fluid fl (enable, clk, load, out, zero);
endmodule
