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
	
	wire [7:0] energyOut; // will reflect the energy after the user choice executes
	wire [3:0] fluidOut; // will reflect the fluid after the user choice executes
	wire [5:0] tracersOut; // will reflect the tracers after the user choice executes
	
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

	
	//determine the web that the user wants based off of select bits
	DecChoice deC (select, enable, choice); 
	
	
	// determine how many units of resources are needed for each option
	LoadFluid LF (choice[0], clk, fluid); // select bits mean that user choice is 0
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
	assign energyOut = energy;
	assign fluidOut = fluid;
	assign tracersOut = tracers;
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







//==================================================================================
// 
/* module Example ();
	wire one = 1; wire zero = 0; reg clk = 0;
	wire [7:0] energy;
	wire [5:0] tracers;
	wire [3:0] fluid;
	wire [7:0] energyNext;
	wire [5:0] tracersNext;
	wire [3:0] fluidNext;
	reg [2:0] selectBits;
	
	initial begin
		selectBits[0] = 0;
		selectBits[1] = 0;
		selectBits[2] = 0;
	end
	initial begin
		forever begin
			#5 clk = 1;
			#5 clk = 0;
		end
	end
	
	LoadEnergy le (one, zero, clk, energy);
	LoadTracers lt (one, clk, tracers);
	LoadFluid lf (one, clk, fluid);
	
	Decoder dec1 (energy, tracers, fluid, selectBits, one, clk, energyNext, tracersNext, fluidNext);
	assign fluid = fluidNext;
	assign energy = energyNext;
	assign tracers = tracersNext;
	// then new slect bits/user choice
	Decoder dec2 (energy, tracers, fluid, selectBits, one, clk, energyNext, tracersNext, fluidNext);
	assign fluid = fluidNext;
	assign energy = energyNext;
	assign tracers = tracersNext;
	// etc...
endmodule */
