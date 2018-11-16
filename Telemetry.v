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

	always @ (enable)
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
		case(enable)
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

module Testbench();
//Inputs
reg [3:0] TelemetryTargetSelect;
reg [7:0] XCoord;
reg [7:0] YCoord;
reg [7:0] ZCoord;
reg [7:0] TCoord;
reg reset; //system reset
reg clk; //system clock
reg enable;

//Outputs
wire [7:0] XOut;
wire [7:0] YOut;
wire [7:0] ZOut;
wire [7:0] TOut;

integer file;


Target_Select Telemetry(reset, clk, enable, TelemetryTargetSelect, XCoord, YCoord, ZCoord, TCoord, XOut, YOut, ZOut, TOut);


initial begin
	file = $fopen("L.D.Stark Industries Telemetry.Output.txt", "w");
end

//display
initial begin
	#1
	$fdisplay(file, "Inputs : Clk = X | TelemetryTargetSelect = XXXX | XCoordinate = XXXXXXXX |  YCoordinate = XXXXXXXX |  ZCoordinate = XXXXXXXX \n");
	$fdisplay(file, "=======================================================================================================================================\n");
	$fdisplay(file, "Outputs: TargetSelect = XXXX | XReturn = XXX | YReturn = XXX | ZReturn = XXX | TimeReturn = XXX \n");
	
	forever
	begin
	#10 //Double individual clock delay to get full length and keep on same frequency of updates
	$fdisplay(file, "Start of next cycle \n");
	$fdisplay(file, "====================================================================================================================================\n");
	$fdisplay(file, "Inputs : Clk = %b | TelemetryTargetSelect = %b | XCoordinate = %b |  YCoordinate = %b |  ZCoordinate = %b \n", clk,TelemetryTargetSelect, XCoord, TCoord, ZCoord);
	$fdisplay(file, "====================================================================================================================================\n");
	$fdisplay(file, "Outputs: XReturn = %b | YReturn = %b | ZReturn = %b | TimeReturn = %b \n", XOut, TOut, ZOut, TOut);

	end
end
//clock and inputs
initial begin
#5 
	clk = 0;
#5
	clk = 1;
#5
	clk = 0;
#5
	clk = 1;
	reset = 1;
#5
	clk = 0;
#5
	clk = 1;
	reset = 0;
	enable = 1;
	TelemetryTargetSelect = 4'b1011;
	XCoord = 8'b01010101;
	YCoord = 8'b11110000;
	ZCoord = 8'b10101010;
	TCoord = 8'b11001100;
#5
	clk = 0;
	enable = 0;

#5 //Web empty run, overwrite a target
	clk=1;
	reset = 0;
	enable = 1;
	TelemetryTargetSelect = 4'b1011;	
	XCoord = 8'b01010101;
	YCoord = 8'b11010000;
	ZCoord = 8'b10101111;
	TCoord = 8'b11011000;
#5
	clk = 0;
	reset = 0;
	enable = 0;
#5
	clk = 1;
	reset = 0;
	enable = 1;
	TelemetryTargetSelect = 4'b1001;	
	XCoord = 8'b01010111;
	YCoord = 8'b11011000;
	ZCoord = 8'b10101100;
	TCoord = 8'b01011000;
#5
	clk = 0;
	reset = 1;
	enable = 0;
end
initial begin
#60
$fclose(file);
$finish;
end
endmodule