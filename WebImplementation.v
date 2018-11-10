
//===========================================================================================
// Decoder to take the user's choice and determine which web to use.
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
