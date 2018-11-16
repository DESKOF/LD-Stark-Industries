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
		Q = 0;
	else
		Q = D;
	end
endmodule

//determines the target for each
module Telem_Decoder(in, enable, out);
	input [3:0] in;
	input enable;
	output [15:0] out;
	wire [15:0] out;

	always @ (posedge clk)
	begin
	if(enable)
		case(in)
			4'b0000 : out = 16'b0000000000000001;
			4'b0001 : out = 16'b0000000000000010;
			4'b0010 : out = 16'b0000000000000100;
			4'b0011 : out = 16'b0000000000001000;
			4'b0100 : out = 16'b0000000000010000;
			4'b0101 : out = 16'b0000000000100000;
			4'b1011 : out = 16'b0000000001000000;
			4'b0111 : out = 16'b0000000010000000;
			4'b1000 : out = 16'b0000000100000000;
			4'b1001 : out = 16'b0000001000000000;
			4'b1010 : out = 16'b0000010000000000;
			4'b1011 : out = 16'b0000100000000000;
			4'b1100 : out = 16'b0001000000000000;
			4'b1101 : out = 16'b0010000000000000;
			4'b1110 : out = 16'b0100000000000000;
			4'b1111 : out = 16'b1000000000000000;
		endcase
	end
endmodule

//selector for each individual dff
module T_Mux(nochange, rst, load, sel, out);
	//In and Outs
	input nochange;
	input rst;
	input load;
	input [1:0] sel;
	output out;

	//Internal Vars
	wire out;
	
	always @ (sel)
	begin
 	case(sel) 
		0 : out = nochange;
		1 : out = load;
		2 : out = 1'b0;
		3 : out = 1'bx; //default, error
 	endcase 
end

//Module that holds 8-bits for each coordinate and time
module Coord(clk, select, Coordin, Coordout);
	input clk;
	input [1:0] select;
	input [7:0] Coordin;
	output [7:0] Coordout;
	reg [7:0] Muxout;

	T_Mux T_eighth(Coordout[7], rst, Coordin[7], select, Muxout[7]);
	T_Mux T_seventh(Coordout[6], rst, Coordin[6], select, Muxout[6]);
	T_Mux T_sixth(Coordout[5], rst, Coordin[5], select, Muxout[5]);
	T_Mux T_fifth(Coordout[4], rst, Coordin[4], select, Muxout[4]);
	T_Mux T_fourth(Coordout[3], rst, Coordin[3], select, Muxout[3]);
	T_Mux T_third(Coordout[2], rst, Coordin[2], select, Muxout[2]);
	T_Mux T_second(Coordout[1], rst, Coordin[1], select, Muxout[1]);
	T_Mux T_first(Coordout[0], rst, Coordin[0], select, Muxout[0]);

	TargetDFF eigth(clk, rst, Muxout[7], Coordout[7]);
	TargetDFF seventh(clk, rst, Muxout[6], Coordout[6]);
	TargetDFF sixth(clk, rst, Muxout[5], Coordout[5]);
	TargetDFF fifth(clk, rst, Muxout[4], Coordout[4]);
	TargetDFF fourth(clk, rst, Muxout[3], Coordout[3]);
	TargetDFF third(clk, rst, Muxout[2], Coordout[2]);
	TargetDFF second(clk, rst, Muxout[1], Coordout[1]);
	TargetDFF first(clk, rst, Muxout[0], Coordout[0]);
	
endmodule
//Creates the register holding and outputting target coordinates and time
module TargetReg(select, clk, XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	input clk, select;
	input [7:0] XCoordinate;
	input [7:0] YCoordinate;
	input [7:0] ZCoordinate;
	input [7:0] TimeCoordinate;
	output [7:0] XOut;
	output [7:0] YOut;
	output [7:0] ZOut;
	output [7:0] TOut;
	
	Coord X(clk, select, XCoordinate, XOut);
	Coord Y(clk, select, YCoordinate, YOut);
	Coord Z(clk, select, ZCoordinate, ZOut);
	Coord T(clk, select, TCoordinate, TOut);

endmodule

//Telemetry target selection module
module Target_Select(rst, clk, targetSelection, enable);
	input clk, rst;
	input enable;
	input [3:0] targetSelection;
	reg [15:0] target;
	reg [1:0] select;

	Telem_Decoder TSelect(targetSelection, enable, target);

	TargetReg t1(select, clk, XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t2(select, clk, XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t3(select, clk, XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t4(select, clk, XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t5(select, clk, XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t6(select, clk, XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t7(select, clk, XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t8(select, clk, XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t9(select, clk, XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t10(select, clk, XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t11(select, clk, XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t12(select, clk, XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t13(select, clk, XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t14(select, clk, XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t15(select, clk, XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);
	TargetReg t16(select, clk, XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XOut, YOut, ZOut, TOut);

	always @ (posedge clk)
	repeat (1) @(posedge clk)
	begin
		select = 2'b00;
		if(rst)
		select = 2'b10;
	end
	begin
		case(target)
			target[15] : t1()//target1
			target[14] : t2()//target2
			target[13] : t3()//target3
			target[12] : t4()//target4
			target[11] : t5()//target5
			target[10] : t6()//target6
			target[9] : t7()//target7
			target[8] : t8()//target8
			target[7] : t9()//target9
			target[6] : t10()//target10
			target[5] : t11()//target11
			target[4] : t12()//target12
			target[3] : t13()//target13
			target[2] : t14()//target14
			target[1] : t15()//target15
			target[0] : t16()//target16
		endcase
	end
endmodule