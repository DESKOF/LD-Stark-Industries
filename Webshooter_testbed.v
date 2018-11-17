//L.D. Stark Industries
//Compiled via Icarus Verilog. http://iverilog.icarus.com/



//ALL CAP COMMENTS ARE FOR INTERNAL COMMUNICATIONS AND SHOULD BE REMOVED BEFORE TURN IN

//PLACE ALL THE MODULE DEFINITIONS BELOW THIS LINE
module TargetDFF(enable, rst, clk, D, Q);
	input rst;
	input enable;
	input clk;
	input D;
	output Q;
	reg Q;

	always @(posedge clk or rst)
	begin
	if(rst)
		Q = 0;
	else
		Q = D;
	end
endmodule

//Decoder determines which target's location is updated
module Telem_Decoder(in, enable, out);
	input [3:0] in;
	input enable;
	output [15:0] out;
	reg [15:0] out;

	always @ (in)
	begin
		//default output if case statement is not reached i.e. enable = 0
		out = 16'b0000000000000000;
		if(enable)
		case(in)
			4'b0000 : out = 16'b0000000000000001; //target 1
			4'b0001 : out = 16'b0000000000000010; //target 2
			4'b0010 : out = 16'b0000000000000100; //target 3
			4'b0011 : out = 16'b0000000000001000; //target 4
			4'b0100 : out = 16'b0000000000010000; //target 5
			4'b0101 : out = 16'b0000000000100000; //target 6
			4'b1011 : out = 16'b0000000001000000; //target 7
			4'b0111 : out = 16'b0000000010000000; //target 8
			4'b1000 : out = 16'b0000000100000000; //target 9
			4'b1001 : out = 16'b0000001000000000; //target 10
			4'b1010 : out = 16'b0000010000000000; //target 11
			4'b1011 : out = 16'b0000100000000000; //target 12
			4'b1100 : out = 16'b0001000000000000; //target 13
			4'b1101 : out = 16'b0010000000000000; //target 14
			4'b1110 : out = 16'b0100000000000000; //target 15
			4'b1111 : out = 16'b1000000000000000; //target 16
		endcase
	end
endmodule
//Coordinate module bundles DFF bits together 
module Coord(clk, rst, enable, Coordin, Coordout);
	input clk, rst;
	input enable;
	input [7:0] Coordin;	
	output [7:0] Coordout;
	wire [7:0] Coordout;
	
	//Instantiates each register bit
	TargetDFF eigth(enable, rst, clk, Coordin[7], Coordout[7]);
	TargetDFF seventh(enable, rst, clk, Coordin[6], Coordout[6]);
	TargetDFF sixth(enable, rst, clk, Coordin[5], Coordout[5]);
	TargetDFF fifth(enable, rst, clk, Coordin[4], Coordout[4]);
	TargetDFF fourth(enable, rst, clk, Coordin[3], Coordout[3]);
	TargetDFF third(enable, rst, clk, Coordin[2], Coordout[2]);
	TargetDFF second(enable, rst, clk, Coordin[1], Coordout[1]);
	TargetDFF first(enable, rst, clk, Coordin[0], Coordout[0]);
	
endmodule
//Target Register bundles 4 8-bit registers as each individual coordinate register
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
	
	//instantiates coordinates
	Coord X(clk, rst, enable, XCoordinate, XOut);
	Coord Y(clk, rst, enable, YCoordinate, YOut);
	Coord Z(clk, rst, enable, ZCoordinate, ZOut);
	Coord T(clk, rst, enable, TimeCoordinate, TOut);
	
endmodule

//Main module for the telemetry system, passing all inputs and outputs.
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
	reg [7:0] XOut; reg [7:0] YOut; reg [7:0] ZOut; reg [7:0] TOut; 
	wire [15:0] target;

	wire [7:0] X1Out; wire [7:0] X2Out; wire [7:0] X3Out; wire [7:0] X4Out; 
	wire [7:0] X5Out; wire [7:0] X6Out; wire [7:0] X7Out; wire [7:0] X8Out; 
	wire [7:0] X9Out; wire [7:0] X10Out; wire [7:0] X11Out; wire [7:0] X12Out; 
	wire [7:0] X13Out; wire [7:0] X14Out; wire [7:0] X15Out; wire [7:0] X16Out; 
	
	wire [7:0] Y1Out; wire [7:0] Y2Out; wire [7:0] Y3Out; wire [7:0] Y4Out;
	wire [7:0] Y5Out; wire [7:0] Y6Out; wire [7:0] Y7Out; wire [7:0] Y8Out;
	wire [7:0] Y9Out; wire [7:0] Y10Out; wire [7:0] Y11Out; wire [7:0] Y12Out;
	wire [7:0] Y13Out; wire [7:0] Y14Out; wire [7:0] Y15Out; wire [7:0] Y16Out;
	
	wire [7:0] Z1Out; wire [7:0] Z2Out; wire [7:0] Z3Out; wire [7:0] Z4Out; 
	wire [7:0] Z5Out; wire [7:0] Z6Out; wire [7:0] Z7Out; wire [7:0] Z8Out; 
	wire [7:0] Z9Out; wire [7:0] Z10Out; wire [7:0] Z11Out; wire [7:0] Z12Out; 
	wire [7:0] Z13Out; wire [7:0] Z14Out; wire [7:0] Z15Out; wire [7:0] Z16Out; 
	
	wire [7:0] T1Out; wire [7:0] T2Out; wire [7:0] T3Out; wire [7:0] T4Out; 
	wire [7:0] T5Out; wire [7:0] T6Out; wire [7:0] T7Out; wire [7:0] T8Out; 
	wire [7:0] T9Out; wire [7:0] T10Out; wire [7:0] T11Out; wire [7:0] T12Out; 
	wire [7:0] T13Out; wire [7:0] T14Out; wire [7:0] T15Out; wire [7:0] T16Out; 

	//Decoder checks target selection
	Telem_Decoder TSelect(targetSelection, enable, target);

	//Creates the module for each individual target holding XYZ coordinates and time T.
	//Passes the clk, rst, and target enable value along with inputs and outputs
	TargetReg sp(clk, rst, target[15], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, X1Out, Y1Out, Z1Out, T1Out);
	TargetReg t2(clk, rst, target[14], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, X2Out, Y2Out, Z2Out, T2Out);
	TargetReg t3(clk, rst, target[13], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, X3Out, Y3Out, Z3Out, T3Out);
	TargetReg t4(clk, rst, target[12], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, X4Out, Y4Out, Z4Out, T4Out);
	TargetReg t5(clk, rst, target[11], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, X5Out, Y5Out, Z5Out, T5Out);
	TargetReg t6(clk, rst, target[10], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, X6Out, Y6Out, Z6Out, T6Out);
	TargetReg t7(clk, rst, target[9], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, X7Out, Y7Out, Z7Out, T7Out);
	TargetReg t8(clk, rst, target[8], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, X8Out, Y8Out, Z8Out, T8Out);
	TargetReg t9(clk, rst, target[7], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, X9Out, Y9Out, Z9Out, T9Out);
	TargetReg t10(clk, rst, target[6], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, X10Out, Y10Out, Z10Out, T10Out);
	TargetReg t11(clk, rst, target[5], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, X11Out, Y11Out, Z11Out, T11Out);
	TargetReg t12(clk, rst, target[4], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, X12Out, Y12Out, Z12Out, T12Out);
	TargetReg t13(clk, rst, target[3], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, X13Out, Y13Out, Z13Out, T13Out);
	TargetReg t14(clk, rst, target[2], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, X14Out, Y14Out, Z14Out, T14Out);
	TargetReg t15(clk, rst, target[1], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, X15Out, Y15Out, Z15Out, T15Out);
	TargetReg t16(clk, rst, target[0], XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, X16Out, Y16Out, Z16Out, T16Out);

	always @ *
		case(target)
		target[15]: begin
			XOut = X1Out;
			YOut = Y1Out;
			ZOut = Z1Out;
			TOut = T1Out;
		end
		target[14]: begin
			XOut = X2Out;
			YOut = Y2Out;
			ZOut = Z2Out;
			TOut = T2Out;
		end
		target[13]: begin 
			XOut = X3Out;
			YOut = Y3Out;
			ZOut = Z3Out;
			TOut = T3Out;
		end
		target[12]: begin
			XOut = X4Out;
			YOut = Y4Out;
			ZOut = Z4Out;
			TOut = T4Out;
		end
		target[11]: begin
			XOut = X5Out;
			YOut = Y5Out;
			ZOut = Z5Out;
			TOut = T5Out;
		end
		target[10]: begin
			XOut = X6Out;
			YOut = Y6Out;
			ZOut = Z6Out;
			TOut = T6Out; 
		end
		target[9]: begin
			XOut = X7Out;
			YOut = Y7Out;
			ZOut = Z7Out;
			TOut = T7Out;
		end
		target[8]: begin
			XOut = X8Out;
			YOut = Y8Out;
			ZOut = Z8Out;
			TOut = T8Out;
		end
		target[7]: begin
			XOut = X9Out;
			YOut = Y9Out;
			ZOut = Z9Out;
			TOut = T9Out;
		end
		target[6]: begin
			XOut = X10Out;
			YOut = Y10Out;
			ZOut = Z10Out;
			TOut = T10Out;
		end
		target[5]: begin
			XOut = X11Out;
			YOut = Y11Out;
			ZOut = Z11Out;
			TOut = T11Out;
		end
		target[4]: begin
			XOut = X12Out;
			YOut = Y12Out;
			ZOut = Z12Out;
			TOut = T12Out;
		end
		target[3]: begin
			XOut = X13Out;
			YOut = Y13Out;
			ZOut = Z13Out;
			TOut = T13Out;
		end
		target[2]: begin
			XOut = X14Out;
			YOut = Y14Out;
			ZOut = Z14Out;
			TOut = T14Out;
		end
		target[1]: begin
			XOut = X15Out;
			YOut = Y15Out;
			ZOut = Z15Out;
			TOut = T15Out;
		end
		target[0]: begin
			XOut = X16Out;
			YOut = Y16Out;
			ZOut = Z16Out;
			TOut = T16Out;
		end
	default: begin
		XOut = 8'bx;
		YOut = 8'bx;
		ZOut = 8'bx;
		TOut = 8'bx;
	end
	endcase
endmodule

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
// Loads the initial 255 (11111111) energy units
module LoadEnergy(input enable, input reset, input clk, input [7:0] previous, output [7:0] out);
	wire [7:0] out;
	reg [7:0] load;
	always @ (posedge clk) begin
	if(reset)
		load[0] = 1;
		if(reset)
		load[1] = 1;
		if(reset)
		load[2] = 1;
		if(reset)
		load[3] = 1;
		if(reset)
		load[4] = 1;
		if(reset)
		load[5] = 1;
		if(reset)
		load[6] = 1;
		if(reset)
		load[7] = 1;
		
	
	if(reset == 0)
		load[0] <= previous[0];
		if(reset == 0)
		load[1] <= previous[1];
		if(reset == 0)
		load[2] <= previous[2];
		if(reset == 0)
		load[3] <= previous[3];
		load[4] <= previous[4];
		if(reset == 0)
		load[5] <= previous[5];
		if(reset == 0)
		load[6] <= previous[6];
		if(reset == 0)
		load[7] <= previous[7];
	end	

	
	Energy en (enable, clk, load, out, reset);
endmodule


//=============================================
// Loads the initial 63 (111111) tracers
module LoadTracers(input reset, input enable, input clk, input [5:0] previous, output [5:0] out);
	wire [5:0] out;
	wire zero = 0;
	reg [5:0] load;
	always @ (posedge clk) begin
	if(reset)
		load[0] = 1;
		if(reset)
		load[1] = 1;
		if(reset)
		load[2] = 1;
		if(reset)
		load[3] = 1;
		if(reset)
		load[4] = 1;
		if(reset)
		load[5] = 1;
	
	if(!reset)
		load[0] = previous[0];
		if(!reset)
		load[1] = previous[1];
		if(!reset)
		load[2] = previous[2];
		if(!reset)
		load[3] = previous[3];
		if(!reset)
		load[4] = previous[4];
		if(!reset)
		load[5] = previous[5];
		
	end
	
	SpiderTracer st (enable, clk, load, out, zero);
endmodule


//=============================================
// Loads the initial 15 (1111) doses of fluid
module LoadFluid(input enable, input reset, input clk, input [3:0] previous, output [3:0] out);
	wire [3:0] out;
	wire zero = 0;
	reg [3:0] load;
	always @ (posedge clk) begin
	if(reset)
		load[0] = 1;
		if(reset)
		load[1] = 1;
		if(reset)
		load[2] = 1;
		if(reset)
		load[3] = 1;
		
	if(!reset)
		load[0] = previous[0];
		if(!reset)
		load[1] = previous[1];
		if(!reset)
		load[2] = previous[2];
		if(!reset)
		load[3] = previous[3];
		
	end
	
	Fluid fl (enable, clk, load, out, zero);
endmodule



//==================================================================================
// Decoder to take the user's choice and determine which bit to output a one on.
// The select[0] is the lsb, while the select[2] is the msb. The out[0]is the lsb,
// and the out[7] is the msb. Output out will be one-hot.
module DecChoice(input [2:0] select, input enable, output [7:0] out);
	reg [7:0] out_temp;
	
	always @*
		case (select)
			3'b000: out_temp = 8'b10000000; // choice 0
			3'b100: out_temp = 8'b01000000; // choice 1
			3'b010: out_temp = 8'b00100000; // choice 2
			3'b110: out_temp = 8'b00010000; // choice 3
			3'b001: out_temp = 8'b00001000; // choice 4
			3'b101: out_temp = 8'b00000100; // choice 5
			3'b011: out_temp = 8'b00000010; // choice 6
			3'b111: out_temp = 8'b00000001; // choice 7
		endcase
	
	// if the enable is 0 then all bits of the output will be zero
	assign out = enable ? out_temp : 8'b00000000;
endmodule



//==================================================================================
// This module interprets the output of the Decoder module and determines what kind
// of web the user wants to use. This module will also see if enough of the resources
// required for each option are available, and change them accordingly if they are.
// The module will output the adjusted resources as well.
module Decoder(input [7:0] energy, input [5:0] tracers, input [3:0] fluid, input [2:0] select, input enable, input clk, output [7:0] energyOut, output [5:0] tracersOut, output [3:0] fluidOut);
	wire [7:0] choice; // will hold the one-hot binary bit string from the decoder
	
	reg [7:0] energyOut; // will reflect the energy after the user choice executes
	reg [3:0] fluidOut; // will reflect the fluid after the user choice executes
	reg [5:0] tracersOut; // will reflect the tracers after the user choice executes
	
	reg one = 1; // holds a value of 1
	reg zero = 0; // holds a value of 0
	
	// these hold a value of 1 if there are enough resources for the user choice
	// otherwise will hold a value of 0 if there are not enough resources
	wire webNeededSLCheck;
	wire energyNeededSLCheck;
	wire webNeededRCCheck;
	wire energyNeededRCCheck;
	wire webNeededWGCheck;
	wire energyNeededWGCheck;
	wire webNeededTSCheck;
	wire energyNeededTSCheck;
	wire tracersNeededTSCheck;
	wire webNeededRFCheck;
	wire energyNeededRFCheck;
	wire webNeededTCCheck;
	wire energyNeededTCCheck;
	wire tracersNeededTCCheck;
	
	// these temporarily store any sum that comes from checking if there are enough resources
	wire [3:0] webCheckTemp;
	wire [5:0] tracersCheckTemp;
	wire [7:0] energyCheckTemp;
	
	// these hold a 1 if there were enough resources for the user's choice
	// otherwise these hold a 0 if there were not enough resources
	wire checkSL;
	wire checkRC;
	wire checkWG;
	wire checkTS;
	wire checkRF;
	wire checkTC;
	
	// these hold the respective values in binary of how many units of resources are needed for each option
	wire [3:0] webNeededSL;
	wire [7:0] energyNeededSL;
	wire [3:0] webNeededRC;
	wire [7:0] energyNeededRC;
	wire [3:0] webNeededWG;
	wire [7:0] energyNeededWG;
	wire [3:0] webNeededTS;
	wire [7:0] energyNeededTS;
	wire [5:0] tracersNeededTS;
	wire [3:0] webNeededRF;
	wire [7:0] energyNeededRF;
	wire [3:0] webNeededTC;
	wire [7:0] energyNeededTC;
	wire [5:0] tracersNeededTC;
	
	reg power = 1;
	reg ground = 0;

	
	//determine the web that the user wants based off of select bits
	DecChoice deC (select, enable, choice); 
	
	
	// determine how many units of resources are needed for each option
	LoadFluid LF (power, choice[0], ground, clk, fluid); // select bits mean that user choice is 0
	SwingLine sl1 (choice[1], clk, webNeededSL, energyNeededSL); // select bits mean that user choice is 1
	Ricochet r2 (choice[2], clk, webNeededRC, energyNeededRC); // select bits mean that user choice is 2
	Grenade g3 (choice[3], clk, webNeededWG, energyNeededWG); // select bits mean that user choice is 3
	Taser t4 (choice[4], clk, webNeededTS, energyNeededTS, tracersNeededTS); // select bits mean that user choice is 4
	RapidFire rf5 (choice[5], clk, webNeededRF, energyNeededRF); // select bits mean that user choice is 5
	Tracer t6 (choice[6], clk, webNeededTC, energyNeededTC, tracersNeededTC); // select bits mean that user choice is 6
	
	// use the Subtractor module to see if there are enough resources for each option
	FourBitAdderSubtractor fas1 (fluid, webNeededSL, one, webNeededSLCheck, webCheckTemp);
	EightBitAdderSubtractor eas1 (energy, energyNeededSL, one, energyNeededSLCheck, energyCheckTemp);
	FourBitAdderSubtractor fas2(fluid, webNeededRC, one, webNeededRCCheck, webCheckTemp);
	EightBitAdderSubtractor eas2 (energy, energyNeededRC, one, energyNeededRCCheck, energyCheckTemp);
	FourBitAdderSubtractor fas3 (fluid, webNeededWG, one, webNeededWGCheck, webCheckTemp);
	EightBitAdderSubtractor eas3 (energy, energyNeededWG, one, energyNeededWGCheck, energyCheckTemp);
	FourBitAdderSubtractor fas4 (fluid, webNeededTS, one, webNeededTSCheck, webCheckTemp);
	EightBitAdderSubtractor eas4 (energy, energyNeededTS, one, energyNeededTSCheck, energyCheckTemp);
	SixBitAdderSubtractor sas4 (tracers, tracersNeededTS, one, tracersNeededTSCheck, tracersCheckTemp);
	FourBitAdderSubtractor fas5 (fluid, webNeededRF, one, webNeededRFCheck, webCheckTemp);
	EightBitAdderSubtractor eas5 (energy, energyNeededRF, one, energyNeededRFCheck, energyCheckTemp);
	FourBitAdderSubtractor fas6 (fluid, webNeededTC, one, webNeededTCCheck, webCheckTemp);
	EightBitAdderSubtractor eas6 (energy, energyNeededTC, one, energyNeededTCCheck, energyCheckTemp);
	SixBitAdderSubtractor sas6 (tracers, tracersNeededTS, one, tracersNeededTSCheck, tracersCheckTemp);
	
	
	// check to see if there are enough resources to do the user specified choice
	Checker c1 (webNeededSLCheck, energyNeededSLCheck, one, checkSL); // checks for enough resources (no tracers)
	Checker c2 (webNeededRCCheck, energyNeededRCCheck, one, checkRC); // checks for enough resources
	Checker c3 (webNeededWGCheck, energyNeededWGCheck, one, checkWG); // checks for enough resources
	Checker c4 (webNeededTSCheck, energyNeededTSCheck, tracersNeededTSCheck, checkTS); // checks for enough resources
	Checker c5 (webNeededRFCheck, energyNeededRFCheck, one, checkRF); // checks for enough resources
	Checker c6 (webNeededTCCheck, energyNeededTCCheck, tracersNeededTCCheck, checkTC); // checks for enough resources
	
	
	
	// apply the changes to the resources for the user specified choice
	Fluid fl1 (checkSL, clk, webNeededSL, fluid, zero);
	Energy en1 (checkSL, clk, energyNeededSL, energy, zero);
	Fluid fl2 (checkRC, clk, webNeededRC, fluid, zero);
	Energy en2 (checkRC, clk, energyNeededRC, energy, zero);
	Fluid fl3 (checkWG, clk, webNeededWG, fluid, zero);
	Energy en3 (checkWG, clk, energyNeededWG, energy, zero);
	Fluid fl4 (checkTS, clk, webNeededTS, fluid, zero);
	Energy en4 (checkTS, clk, energyNeededTS, energy, zero);
	SpiderTracer st4 (checkTS, clk, tracersNeededTS, tracers, zero);
	Fluid fl5 (checkRF, clk, webNeededRF, fluid, zero);
	Energy en5 (checkRF, clk, energyNeededRF, energy, zero);
	Fluid fl6 (checkTC, clk, webNeededTC, fluid, zero);
	Energy en6 (checkTC, clk, energyNeededTC, energy, zero);
	SpiderTracer st6 (checkTC, clk, tracersNeededTC, tracers, zero);
	
	
	// show the changes for the resources by outputting/returning them
	always @ (posedge clk) begin
		assign energyOut = energy;
		assign fluidOut = fluid;
		assign tracersOut = tracers;
	end
endmodule


//==================================================================================
// 











//==================================================================================
// Determines whether the fluid, energy, and tracer resources are enough for the function
module Checker(input fluidCheck, energyCheck, tracerCheck, output out);
	wire out;
	
	and A (out, fluidCheck, energyCheck, tracerCheck); // out = fluidCheck & energyCheck & tracerCheck
endmodule



//==================================================================================
// This module loads the fluid, energy, and tracers needed for the Taser web
module Taser(input enable, input clk, output [3:0] webNeeded, output [7:0] energyNeeded, output [5:0] tracersNeeded);
	reg [3:0] webNeeded;
	reg [7:0] energyNeeded;
	reg [5:0] tracersNeeded;
	
	always @(posedge clk)
	begin
		//0001 if enable, 0 if not enable
		webNeeded[3] = 0;
		webNeeded[2] = 0;
		webNeeded[1] = 0;
		webNeeded[0] = enable;
	
		//00010000 in binary, 16 in decimal if enable, otherwise 0
		energyNeeded[7] = 0;
		energyNeeded[6] = 0;
		energyNeeded[5] = 0;
		energyNeeded[4] = enable;
		energyNeeded[3] = 0;
		energyNeeded[2] = 0;
		energyNeeded[1] = 0;
		energyNeeded[0] = 0;
	
		//001000 in binary, 8 in decimal if enable, otherwise 0
		tracersNeeded[5] = 0;
		tracersNeeded[4] = 0;
		tracersNeeded[3] = enable;
		tracersNeeded[2] = 0;
		tracersNeeded[1] = 0;
		tracersNeeded[0] = 0;
	end
endmodule


//==================================================================================
// This module loads the fluid, energy, and tracers needed for the Tacer web
module Tracer(input enable, input clk, output [3:0] webNeeded, output [7:0] energyNeeded, output [5:0] tracersNeeded);
	reg [3:0] webNeeded;
	reg [7:0] energyNeeded;
	reg [5:0] tracersNeeded;
	
	always @(posedge clk)
	begin
		//0001 if enable, 0 if not enable
		webNeeded[3] = 0;
		webNeeded[2] = 0;
		webNeeded[1] = 0;
		webNeeded[0] = enable;
	
		//00000001 in binary, 1 in decimal if enable, otherwise 0
		energyNeeded[7] = 0;
		energyNeeded[6] = 0;
		energyNeeded[5] = 0;
		energyNeeded[4] = 0;
		energyNeeded[3] = 0;
		energyNeeded[2] = 0;
		energyNeeded[1] = 0;
		energyNeeded[0] = enable;
	
		//000100 in binary, 4 in decimal if enable, otherwise 0
		tracersNeeded[5] = 0;
		tracersNeeded[4] = 0;
		tracersNeeded[3] = 0;
		tracersNeeded[2] = enable;
		tracersNeeded[1] = 0;
		tracersNeeded[0] = 0;
	end
	
endmodule


//==================================================================================
// This module loads the fluid, and energy needed for the web Grenade
module Grenade(input enable, input clk, output [3:0] webNeeded, output [7:0] energyNeeded);
	reg [3:0] webNeeded;
	reg [7:0] energyNeeded;
	
	always @(posedge clk)
	begin
		//1111 if enable, 0 if not enable
		webNeeded[3] = enable;
		webNeeded[2] = enable;
		webNeeded[1] = enable;
		webNeeded[0] = enable;
	
		//00000100 in binary, 4 in decimal if enable, otherwise 0
		energyNeeded[7] = 0;
		energyNeeded[6] = 0;
		energyNeeded[5] = 0;
		energyNeeded[4] = 0;
		energyNeeded[3] = 0;
		energyNeeded[2] = enable;
		energyNeeded[1] = 0;
		energyNeeded[0] = 0;
	end
endmodule


//==================================================================================
// This module loads the fluid, and energy needed for the Swing Line web
module SwingLine(input enable, input clk, output [3:0] webNeeded, output [7:0] energyNeeded);
	reg [3:0] webNeeded;
	reg [7:0] energyNeeded;
	
	always @(posedge clk)
	begin
		//0001 if enable, 0 if not enable
		webNeeded[3] = 0;
		webNeeded[2] = 0;
		webNeeded[1] = 0;
		webNeeded[0] = enable;
	
		//00000001 in binary, 1 in decimal if enable, otherwise 0
		energyNeeded[7] = 0;
		energyNeeded[6] = 0;
		energyNeeded[5] = 0;
		energyNeeded[4] = 0;
		energyNeeded[3] = 0;
		energyNeeded[2] = 0;
		energyNeeded[1] = 0;
		energyNeeded[0] = enable;
	end
endmodule


//==================================================================================
// This module loads the fluid, and energy needed for the Rapid Fire web
module RapidFire(input enable, input clk, output [3:0] webNeeded, output [7:0] energyNeeded);
	reg [3:0] webNeeded;
	reg [7:0] energyNeeded;
	
	always @(posedge clk)
	begin
		//0001 if enable, 0 if not enable
		webNeeded[3] = 0;
		webNeeded[2] = 0;
		webNeeded[1] = 0;
		webNeeded[0] = enable;
	
		//00000001 in binary, 1 in decimal if enable, otherwise 0
		energyNeeded[7] = 0;
		energyNeeded[6] = 0;
		energyNeeded[5] = 0;
		energyNeeded[4] = 0;
		energyNeeded[3] = 0;
		energyNeeded[2] = 0;
		energyNeeded[1] = 0;
		energyNeeded[0] = enable;
	end
endmodule


//==================================================================================
// This module loads the fluid, and energy needed for the Ricochet web
module Ricochet(input enable, input clk, output [3:0] webNeeded, output [7:0] energyNeeded);
	reg [3:0] webNeeded;
	reg [7:0] energyNeeded;
	
	always @(posedge clk)
	begin
		//0001 if enable, 0 if not enable
		webNeeded[3] = 0;
		webNeeded[2] = 0;
		webNeeded[1] = 0;
		webNeeded[0] = enable;
	
		//00000010 in binary, 2 in decimal if enable, otherwise 0
		energyNeeded[7] = 0;
		energyNeeded[6] = 0;
		energyNeeded[5] = 0;
		energyNeeded[4] = 0;
		energyNeeded[3] = 0;
		energyNeeded[2] = 0;
		energyNeeded[1] = enable;
		energyNeeded[0] = 0;
	end
endmodule







//The "Breadboard" module, for use in piecing together the circuit
module WebShooter(input [7:0] PreviousEnergy, input [3:0] PreviousFluid, input [5:0] PreviousTracer, input [3:0] TelemetryTargetSelect, input[2:0] WebFunctionSelect, input [7:0] XCoordinate, input [7:0] YCoordinate, input [7:0] ZCoordinate, input [7:0] TimeCoordinate, input clk, input reset, output[5:0] tracersOut, output [7:0] energyOut, output [3:0] fluidOut, output [7:0] XReturn, output [7:0] YReturn, output [7:0] ZReturn, output [7:0] TimeReturn);
    //THIS WILL NEED TO HAVE ALL THE MODULES THEMSELVES SET UP AND PREPARED FOR USE

	wire [7:0] energy;
	wire [5:0] tracers;
	wire [3:0] fluid;


	wire [7:0] EnergyLevel;
	wire [5:0] TracerLevel;
	wire [3:0] FluidLevel;

	wire [7:0] finalEnergy;

	wire [3:0] finalFluid;

	reg power = 1; //For a default value of 1, equivalent to tying to power in a physical circuit
	reg ground = 0; //For a default value of 0, equivalent to tying to ground in a physical circuit
	
	LoadEnergy enLoader(power, reset, clk, PreviousEnergy, energy);

	LoadTracers tracerLoader(power, reset, clk, PreviousTracer, tracers);

    LoadFluid fluidLoader(power, reset, clk, PreviousFluid, fluid);
	


	Decoder webDec(energy, tracers, fluid, WebFunctionSelect, power, clk, energyOut, tracersOut, fluidOut);
	//(input [7:0] energy, input [5:0] tracers, input [3:0] fluid, input [2:0] select, input enable, input clk, output [7:0] energyOut, output [5:0] tracersOut, output [3:0] fluidOut);
	
	
	Target_Select Telemetry(reset, clk, enable, TelemetryTargetSelect, XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, XReturn, YReturn, ZReturn, TimeReturn);
	

 endmodule
//END MODULES




// Testbench
module WebShooterController ();


//Inputs
reg [3:0] TelemetryTargetSelect; //Input for target selection for the telemetry system
reg [2:0] WebFunctionSelect; //Input for selecting which web function to use
reg [7:0] XCoordinate; //The position X of a target
reg [7:0] YCoordinate; //The position Y of a target
reg [7:0] ZCoordinate; //The position Z of a target
reg [7:0] TimeCoordinate; //The value of Time associated with the target
reg Reset;
//PASS IN RESET, ADJUST MODULES AS NECESSARY

reg clk; //The clock for the system as a whole



//outputs
wire [5:0] tracerCount; //Number of tracers currently held in the WebShooter
wire [7:0] energy; //If this is 1 then the system is out of power
wire [3:0] fluid;
wire [7:0] XReturn;
wire [7:0] YReturn;
wire [7:0] ZReturn;
wire [7:0] TimeReturn;

//Constant comparitors
	wire [7:0] zeroEnergyComparitor = 8'b00000000;
	wire [4:0] zeroFluidComparitor = 4'b0000;
	
//File Integer for outputing to File
	integer file;

//Should we have this? If removed, also remove close before $finish command
initial begin
	file = $fopen("L.D.Stark Industries.Output.txt", "w");
	end

//Create a WebShooter to test
//NEED DETAILS ON WHAT INPUTS AND OUTPUTS ARE NEEDED


WebShooter Shooter(energy, fluid, tracerCount, TelemetryTargetSelect, WebFunctionSelect, XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, clk, Reset, tracerCount, energy, fluid, XReturn, YReturn, ZReturn, TimeReturn);
 //WebShooter( TelemetryTargetSelect, WebFunctionSelect, XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, clk, reset, tracerCount, energyEmpty, fluidEmpty, XReturn, YReturn, ZReturn, TimeReturn)
 
 initial begin   
 
 //DISCUSS DESIGN OF OUTPUT, this current code below is just there so I can easily remember how to code it
 
 
 
  #1 //Delay a tick to avoid falling on edge

forever
	begin
	#10 //Double individual clock delay to get full length and keep on same frequency of updates
	$display ("==============================================================================================================================\n");
	$display ("Start of cycle \n");	
	$display("Inputs : \nClk = %b \nTelemetryTargetSelect = %4b \nWebFunctionSelect =     %3b \nXCoordinate =           %8b \nYCoordinate =           %8b \nZCoordinate =           %8b \n", clk, TelemetryTargetSelect, WebFunctionSelect, XCoordinate, YCoordinate, ZCoordinate);
	
	$display ("==============================================================================================================================\n");
	$display ("Outputs:\ntracerCount = %b \nXReturn =     %8b \nYReturn =     %8b \nZReturn =     %8b \nTimeReturn =  %8b \n", tracerCount, XReturn, YReturn, ZReturn, TimeReturn);

	
	//$display ("Outputs: tracerCount = %2d | XReturn = %3d | YReturn = %3d | ZReturn = %3d | TimeReturn =  %3d \n", tracerCount, XReturn, YReturn, ZReturn, TimeReturn);
	if(fluid == zeroFluidComparitor) $fdisplay (file, "Fluid is empty Spider-Man, you need to reload it \n");



	end
end





initial begin

//Used the sample given as the default test case, adjust as desired, format of 1st input addition, second subtraction keeps the output consistent with labels
#5 //Pre-reset output
	clk = 0;
#5
	clk = 1;

#5 
	clk=0;

#5 //Reset case
	clk=1;
	Reset=1;

#5  //Reset for fresh case
	clk=0;
	Reset = 1;
	
#5 //Use web grenade and load a target into the system
	clk=1;
	Reset = 0;
	
	TelemetryTargetSelect = 4'b1011;
	WebFunctionSelect = 3'b011;
	
	XCoordinate = 8'b01010101;
	YCoordinate = 8'b11110000;
	ZCoordinate = 8'b10101010;
	TimeCoordinate = 8'b11001100;
	
#5 //Don't reset to test empty fluid case
	clk=0;
	
#5 //Web empty run, overwrite a target
	clk=1;
	Reset = 0;
	
	TelemetryTargetSelect = 4'b1011;
	WebFunctionSelect = 3'b010;
	
	XCoordinate = 8'b01010001;
	YCoordinate = 8'b11010000;
	ZCoordinate = 8'b10101111;
	TimeCoordinate = 8'b11011000;
	
#5 //Reset for fresh case
	clk=0;
	Reset = 1;
#5 
	clk=1;
	Reset = 0;
	
	TelemetryTargetSelect = 4'b1000;
	WebFunctionSelect = 3'b101;
	
	XCoordinate = 8'b01110101;
	YCoordinate = 8'b11100010;
	ZCoordinate = 8'b10111111;
	TimeCoordinate = 8'b11111111;
	
#5 
	clk=0;
	Reset = 0;
#5 
	clk = 1;
	
	TelemetryTargetSelect = 4'b1000;
	WebFunctionSelect = 3'b010;
	
	XCoordinate = 8'b01110101;
	YCoordinate = 8'b11100010;
	ZCoordinate = 8'b10110001;
	TimeCoordinate = 8'b00000000;



end
 

initial begin
#62 //TO BE CHANGED
$fclose(file); //Close output file
$finish; //Ends all loops
end 




 endmodule