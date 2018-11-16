//L.D. Stark Industries
//Compiled via Icarus Verilog. http://iverilog.icarus.com/



//ALL CAP COMMENTS ARE FOR INTERNAL COMMUNICATIONS AND SHOULD BE REMOVED BEFORE TURN IN

//PLACE ALL THE MODULE DEFINITIONS BELOW THIS LINE











module WebShooter(input [3:0] TelemetryTargetSelect, input[2:0] WebFunctionSelect, 
input [7:0] XCoordinate, input [7:0] YCoordinate, input [7:0] ZCoordinate, input [7:0] TimeCoordinate, input clk, input reset
 output [5:0] tracerCount, output energyEmpty);
 //THIS WILL NEED TO HAVE ALL THE MODULES THEMSELVES SET UP AND PREPARED FOR USE
 
 
 
 
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
wire [5:0] tracerCount //Number of tracers currently held in the WebShooter
wire energyEmpty; //If this is 1 then the system is out of power
wire fluidEmpty;
wire [7:0] XReturn;
wire [7:0] YReturn;
wire [7:0] ZReturn;
wire [7:0] TimeReturn;


//Should we have this? If removed, also remove close before $finish command
initial begin
	file = $fopen("L.D.Stark Industries.Output.txt", "w");
	end

//Create a WebShooter to test
//NEED DETAILS ON WHAT INPUTS AND OUTPUTS ARE NEEDED
WebShooter Shooter(TelemetryTargetSelect, WebFunctionSelect, 
XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, clk, Reset, 
tracerCount, energyEmpty, XReturn, YReturn, ZReturn, TimeReturn);

 
 initial begin   
 
 //DISCUSS DESIGN OF OUTPUT, this current code below is just there so I can easily remember how to code it
 
 
 
  #1 //Delay a tick to avoid falling on edge
 $fdisplay(file, "Inputs : Clk = X | TelemetryTargetSelect = XXXX | WebFunctionSelect = XXX |  XCoordinate = XXXXXXXX |  YCoordinate = XXXXXXXX |  ZCoordinate = XXXXXXXX \n",
                 "======================================================================================================================================================\n",
				"Outputs: tracerCount = XX | XReturn = XXX | YReturn = XXX | ZReturn = XXX | TimeReturn = XXX \n"
		   );
forever
	begin
	#10 //Double individual clock delay to get full length and keep on same frequency of updates
	$fdisplay (file, "Start of next cycle \n");
	$fdisplay (file, "======================================================================================================================================================\n");
	$fdisplay (file, "Inputs : Clk = %b | TelemetryTargetSelect = %4b | WebFunctionSelect = %3b |  XCoordinate = %8b |  YCoordinate = %8b |  ZCoordinate = %8b \n");
	$fdisplay (file, "======================================================================================================================================================\n");
	$fdisplay (file, "Outputs: tracerCount = %2d | XReturn = %3d | YReturn = %3d | ZReturn = %3d | TimeReturn = %3d \n");
	if(fluidEmpty) $fdisplay (file, "Fluid is empty Spider-Man, you need to reload it \n");



	end
end



	

initial begin

//Used the sample given as the default test case, adjust as desired, format of 1st input addition, second subtraction keeps the output consistent with labels
#5
	clk = 0;
#5
	clk = 1;

#5 
	clk=0;

#5
	clk=1;
	Reset=1;

#5 
	clk=0;
	Reset = 1;
#5 
	clk=1;
	Reset = 0;
	
	TelemetryTargetSelect = 4'b1011;
	WebFunctionSelect = 3'b011;
	
	XCoordinate = 8'b01010101;
	YCoordinate = 8'b11110000;
	ZCoordinate = 8'b10101010;
	TimeCoordinate = 8'b11001100;
#5 
	clk=0;
	Reset = 1;
#5 
	clk=1;
	Reset = 0;
	
	TelemetryTargetSelect = 4'b1001;
	WebFunctionSelect = 3'b010;
	
	XCoordinate = 8'b01010001;
	YCoordinate = 8'b11010000;
	ZCoordinate = 8'b10101111;
	TimeCoordinate = 8'b11011000;
	
#5 
	clk=0;
	Reset = 1;
#5 
	clk=1;
	Reset = 0;
	
	TelemetryTargetSelect = 4'b1000;
	WebFunctionSelect = 3'b011;
	
	XCoordinate = 8'b01110101;
	YCoordinate = 8'b11100010;
	ZCoordinate = 8'b10111111;
	TimeCoordinate = 8'b11111111;
	
#5 
	clk=0;
	Reset = 0;
#5 
	clk = 1
	
	TelemetryTargetSelect = 4'b1000;
	WebFunctionSelect = 3'b010;
	
	XCoordinate = 8'b01110101;
	YCoordinate = 8'b11100010;
	ZCoordinate = 8'b10110001;
	TimeCoordinate = 8'b00000000;



end
 

initial begin
#30 //TO BE CHANGED
$fclose(file); //Close output file
$finish; //Ends all loops
end 

initial begin
	forever
	if (energyEmpty = 1){ 
	$fdisplay (file, "Energy empty, goodbye Spider-Man");
	$fclose(file);
	$finish;
	}
	end
end

 endmodule