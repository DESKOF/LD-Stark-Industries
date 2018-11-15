//DFFs hold single bits for each coordinate
module DFF(rst, clk, D, Q);
	input clk;
	input D;
	input rst;
	output Q;
	reg Q;

	always @(posedge clk)
	begin
	if(rst)
		Q = 0;
	else 
		Q = D;
	end
endmodule

//determines the target for each
module Decoder(in, out, enable);
	input [7:0] in;
	input enable;
	output [31:0] out;
	wire [31:0] out;

	always @ (in)
	assign out = (enable) ? (1 << in): 32'b0;

endmodule

//selector for each dff
module Mux(nochange, load, sel, out);
	//In and Outs
	input nochange;
	input load;
	input sel;
	output out;

	//Internal Vars
	reg  out;
	
	always @ (sel)
	begin
 	case(sel) 
		1'b0 : out = nochange;
		1'b1 : out = load;
	default out = 1'bx;
 	endcase 
end

//Module that holds 8-bits for each coordinate and time
module Coord(clk, in, out);
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