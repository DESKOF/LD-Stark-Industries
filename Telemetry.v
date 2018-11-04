
module DFF(clk, D, Q);
	parameter n=1;
	input clk;
	input [n-1:0] D;
	output [n-1:0] Q;
	reg [n-1:0] Q;

	always @(posedge clk)
	Q = D;
endmodule


module CoordX(clk, in, out);
	input [7:0] in;
	output [7:0] out;
	
	DFF eigth(clk, in[7], out[7]);
	DFF seventh(clk, in[6], out[6]);
	DFF sixth(clk, in[5], out[5]);
	DFF fifth(clk, in[4], out[4]);
	DFF fourth(clk, in[3], out[3]);
	DFF third(clk, in[2], out[2]);
	DFF second(clk, in[1], out[1]);
	DFF first(clk, in[0], out[0]);
	
endmodule

module CoordY(clk, in, out);
	input [7:0] in;
	output [7:0] out;
	
	DFF eigth(clk, in[7], out[7]);
	DFF seventh(clk, in[6], out[6]);
	DFF sixth(clk, in[5], out[5]);
	DFF fifth(clk, in[4], out[4]);
	DFF fourth(clk, in[3], out[3]);
	DFF third(clk, in[2], out[2]);
	DFF second(clk, in[1], out[1]);
	DFF first(clk, in[0], out[0]);
	
endmodule

module CoordZ(clk, in, out);
	input [7:0] in;
	output [7:0] out;
	
	DFF eigth(clk, in[7], out[7]);
	DFF seventh(clk, in[6], out[6]);
	DFF sixth(clk, in[5], out[5]);
	DFF fifth(clk, in[4], out[4]);
	DFF fourth(clk, in[3], out[3]);
	DFF third(clk, in[2], out[2]);
	DFF second(clk, in[1], out[1]);
	DFF first(clk, in[0], out[0]);
	
endmodule

module Counter();
endmodule


module Velocity();
endmodule