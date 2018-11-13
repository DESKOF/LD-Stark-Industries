
//==================================================================================
// Decoder to take the user's choice and determine which bit to output a one on.
// The select[0] is the lsb, while the select[2] is the msb. The out[0]is the lsb,
// and the out[7] is the msb. Output out will be one-hot.
module Decoder(input [2:0] select, input enable, output [7:0] out);
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
// of web that the user wants to use.
module DecChoice(input [7:0] energy, input [5:0] tracers, input [3:0] fluidtemp, input [2:0] select, input enable, clk);
	wire [7:0] choice; // will hold the one-hot binary bit string from the decoder
	wire [3:0] fluid;
	
	Decoder dec (select, enable, choice); //determine the web that the user wants
	
	always @(select)
		case (choice)
			8'b10000000: ; // call swing line web resource checker
			8'b01000000: ; // call ricochet web resource checker
			8'b00100000: ; // call splitter web resource checker
			8'b00010000: ; // call web grenade resource checker
			8'b00001000: ; // call taser web resource checker
			8'b00000100: ; // call rapid fire web resource checker
			8'b00000010: ; // call spider-tracer web resource checker
			8'b00000001: ; // call reload fluid cartridge
			default: $display("You did something wrong");
		endcase
	
endmodule


//==================================================================================
// 




//==================================================================================
// 
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
// 
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
// 
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
// 
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
// 
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
// 
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
