//Target DFFs hold single bits for each coordinate

module TargetDFF(rst, clk, D, Q);
	input rst;
	input clk;
	input D;
	output Q;
	reg Q;

	always @(posedge clk)
	begin
	if(rst)
		#2 
		Q = 0;
	else
		#2 
		Q = D;
	end
endmodule

//determines the target for each
module TargetDFF(enable, rst, clk, D, Q);
	input rst;
	input enable;
	input clk;
	input D;
	output Q;
	reg Q;

	always @(posedge clk)
	begin
	if(rst)
		#2 
		Q = 0;
	else if(enable)
		#2 
		Q = D;
	end
endmodule

//Decoder determines which target's location is updated
module Telem_Decoder(in, enable, out);
	input [3:0] in;
	input enable;
	output [15:0] out;
	reg [15:0] out;

	always @ (enable or in)
	begin
		out = 16'b0000000000000000;
		if(enable)
		case(in)
			4'b0000 : out = 16'b0000000000000001; //target 1
			4'b0001 : out = 16'b0000000000000010; //target 
			4'b0010 : out = 16'b0000000000000100; //target 
			4'b0011 : out = 16'b0000000000001000; //target 
			4'b0100 : out = 16'b0000000000010000; //target 
			4'b0101 : out = 16'b0000000000100000; //target 
			4'b1011 : out = 16'b0000000001000000; //target 
			4'b0111 : out = 16'b0000000010000000; //target 
			4'b1000 : out = 16'b0000000100000000; //target 
			4'b1001 : out = 16'b0000001000000000; //target 
			4'b1010 : out = 16'b0000010000000000; //target 
			4'b1011 : out = 16'b0000100000000000; //target 
			4'b1100 : out = 16'b0001000000000000; //target 
			4'b1101 : out = 16'b0010000000000000; //target 
			4'b1110 : out = 16'b0100000000000000; //target 
			4'b1111 : out = 16'b1000000000000000; //target 
		endcase
	end
endmodule


module Coord(clk, rst, enable, Coordin, Coordout);
	input clk, rst;
	input enable;
	input [7:0] Coordin;
	output [7:0] Coordout;
	wire [7:0] Coordout;

	TargetDFF eigth(enable, rst, clk, Coordin[7], Coordout[7]);
	TargetDFF seventh(enable, rst, clk, Coordin[6], Coordout[6]);
	TargetDFF sixth(enable, rst, clk, Coordin[5], Coordout[5]);
	TargetDFF fifth(enable, rst, clk, Coordin[4], Coordout[4]);
	TargetDFF fourth(enable, rst, clk, Coordin[3], Coordout[3]);
	TargetDFF third(enable, rst, clk, Coordin[2], Coordout[2]);
	TargetDFF second(enable, rst, clk, Coordin[1], Coordout[1]);
	TargetDFF first(enable, rst, clk, Coordin[0], Coordout[0]);
	
endmodule

module TargetReg(clk, rst, enable, XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	input clk, rst, enable;
	input [7:0] XCoordinate;
	input [7:0] YCoordinate;
	input [7:0] ZCoordinate;
	input [7:0] TimeCoordinate;
	output [7:0] XOut;
	output [7:0] YOut;
	output [7:0] ZOut;
	output [7:0] TOut;
	
	Coord X(clk, rst, enable, XCoordinate, XOut);
	Coord Y(clk, rst, enable, YCoordinate, YOut);
	Coord Z(clk, rst, enable, ZCoordinate, ZOut);
	Coord T(clk, rst, enable, TimeCoordinate, TOut);
	
endmodule

module Target_Select(rst, clk, enable, targetSelection, XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	input clk, rst;
	input enable;
	input [3:0] targetSelection;
	input [7:0] XCoordinate;
	input [7:0] YCoordinate;
	input [7:0] ZCoordinate;
	input [7:0] TimeCoordinate;
	output [7:0] XOut;
	output [7:0] YOut;
	output [7:0] ZOut;
	output [7:0] TOut;

	wire [15:0] target;
	wire [7:0] XOut;
	wire [7:0] YOut;
	wire [7:0] ZOut;
	wire [7:0] TOut;

	Telem_Decoder TSelect(targetSelection, enable, target);

	//Creates the module for each individual target holding XYZ coordinates and time T.
	//Passes the clk, rst, and target enable value along with inputs and outputs
	TargetReg sp(clk, rst, target[15], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t2(clk, rst, target[14], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t3(clk, rst, target[13], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t4(clk, rst, target[12], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t5(clk, rst, target[11], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t6(clk, rst, target[10], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t7(clk, rst, target[9], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t8(clk, rst, target[8], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t9(clk, rst, target[7], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t10(clk, rst, target[6], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t11(clk, rst, target[5], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t12(clk, rst, target[4], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t13(clk, rst, target[3], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t14(clk, rst, target[2], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t15(clk, rst, target[1], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t16(clk, rst, target[0], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);

endmodule