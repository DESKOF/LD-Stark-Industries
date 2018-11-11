
//==================================================================================
// Decoder to take the user's choice and determine which bit to output a one on.
// The select[0] is the lsb, while the select[2] is the msb. The out[0]is the lsb,
// and the out[7] is the msb. Output out will be one-hot.
module Decoder(input [2:0] select, enable, output [7:0] out);
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
module DecChoice(input [7:0] energy, input [5:0] tracers, input [3:0] fluid, input [2:0] select, enable);
	wire [7:0] choice; // will hold the one-hot binary bit string from the decoder
	
	Decoder dec (select, enable, choice); //determine the web that the user wants
	
	always @*
		case (choice)
			8'b10000000: ;// call swing line web resource checker
			8'b01000000: ;// call ricochet web resource checker
			8'b00100000: ;// call splitter web resource checker
			8'b00010000: ;// call web grenade resource checker
			8'b00001000: ;// call taser web resource checker
			8'b00000100: ;// call rapid fire web resource checker
			8'b00000010: ;// call spider-tracer web resource checker
			8'b00000001: ;// call reload fluid cartridge
			default: $display("You did something wrong");
		endcase
	
endmodule


//==================================================================================
// 
