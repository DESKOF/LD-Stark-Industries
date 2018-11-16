//L.D. Stark Industries
//Compiled via Icarus Verilog. http://iverilog.icarus.com/



//ALL CAP COMMENTS ARE FOR INTERNAL COMMUNICATIONS AND SHOULD BE REMOVED BEFORE TURN IN

//PLACE ALL THE MODULE DEFINITIONS BELOW THIS LINE

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
module LoadEnergy(input enable, reset, clk, output [7:0] out);
	wire [7:0] out;
	reg [7:0] load;
	initial begin
		load[0] = 1;
		load[1] = 1;
		load[2] = 1;
		load[3] = 1;
		load[4] = 1;
		load[5] = 1;
		load[6] = 1;
		load[7] = 1;
	end
	
	Energy en (enable, clk, load, out, reset);
endmodule


//=============================================
// Loads the initial 63 (111111) tracers
module LoadTracers(input enable, clk, output [5:0] out);
	wire [5:0] out;
	wire zero = 0;
	reg [5:0] load;
	initial begin
		load[0] = 1;
		load[1] = 1;
		load[2] = 1;
		load[3] = 1;
		load[4] = 1;
		load[5] = 1;
	end
	
	SpiderTracer st (enable, clk, load, out, zero);
endmodule


//=============================================
// Loads the initial 15 (1111) doses of fluid
module LoadFluid(input enable, clk, output [3:0] out);
	wire [3:0] out;
	wire zero = 0;
	reg [3:0] load;
	initial begin
		load[0] = 1;
		load[1] = 1;
		load[2] = 1;
		load[3] = 1;
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







//The "Breadboard" module, for use in piecing together the circuit
module WebShooter(input [3:0] TelemetryTargetSelect, input[2:0] WebFunctionSelect, input [7:0] XCoordinate, input [7:0] YCoordinate, input [7:0] ZCoordinate, input [7:0] TimeCoordinate, input clk, input reset, input [5:0] tracerCount, output [7:0] energyEmpty, output [3:0] fluidEmpty, output [7:0] XReturn, output [7:0] YReturn, output [7:0] ZReturn, output [7:0] TimeReturn);
                              
 //THIS WILL NEED TO HAVE ALL THE MODULES THEMSELVES SET UP AND PREPARED FOR USE
	wire [7:0] initialEnergy;
	wire [5:0] initialTracer;
	wire [3:0] initialFluid;
	
	wire [7:0] EnergyLevel;
	wire [5:0] TracerLevel;
	wire [3:0] FluidLevel;
	
	wire [7:0] finalEnergy;
	
	wire [3:0] finalFluid;
	
	reg power = 1; //For a default value of 1, equivalent to tying to power in a physical circuit
	reg ground = 0; //For a default value of 0, equivalent to tying to ground in a physical circuit
	
	LoadEnergy enLoader(reset, reset, clk, initialEnergy);
	
	LoadTracers tracerLoader(reset, clk, initialTracer);
	
	LoadFluid fluidLoader(reset, clk, initialFluid);
	
	
	
	Decoder webDec(initialEnergy, initialTracers, initialFluid, WebFunctionSelect, ground, clk, finalEnergy, tracerCount, finalFluid);
	
	
	//(input [7:0] energy, input [5:0] tracers, input [3:0] fluid, input [2:0] select, input enable, input clk, output [7:0] energyOut, output [5:0] tracersOut, output [3:0] fluidOut);
	
	
	
	
	

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


WebShooter Shooter(TelemetryTargetSelect, WebFunctionSelect, XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, clk, Reset, tracerCount, energy, fluid, XReturn, YReturn, ZReturn, TimeReturn);

 
 initial begin   
 
 //DISCUSS DESIGN OF OUTPUT, this current code below is just there so I can easily remember how to code it
 
 
 
  #1 //Delay a tick to avoid falling on edge

forever
	begin
	#10 //Double individual clock delay to get full length and keep on same frequency of updates
	
	$display ("Start of next cycle \n");
	$display ("======================================================================================================================================================\n");
	
	$display("Inputs : Clk = X \n TelemetryTargetSelect = XXXX \n WebFunctionSelect = XXX \n  XCoordinate = XXXXXXXX \n  YCoordinate = XXXXXXXX \n  ZCoordinate = XXXXXXXX \n",
                 "======================================================================================================================================================\n",
				);
	$display ("%b", clk);
	$display ("%4b", TelemetryTargetSelect);
	$display ("%3b", WebFunctionSelect);
	$display ("%8b", XCoordinate); 
	$display ("%8b", YCoordinate);
	$display ("%8b", ZCoordinate);
	$display ("======================================================================================================================================================\n");
	$display ("Outputs:\n tracerCount = XX \n XReturn = XXX \n YReturn = XXX \n ZReturn = XXX \n TimeReturn = XXX \n");
	$display ("%2d\n", tracerCount);
	$display ("%3d\n", XReturn);
	$display ("%3d\n", YReturn);
	$display ("%3d\n", ZReturn);
	$display ("%3d\n", TimeReturn);
	
	//$display ("Outputs: tracerCount = %2d | XReturn = %3d | YReturn = %3d | ZReturn = %3d | TimeReturn = %3d \n", tracerCount, XReturn, YReturn, ZReturn, TimeReturn);
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