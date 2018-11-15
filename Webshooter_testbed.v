//L.D. Stark Industries
//Compiled via Icarus Verilog. http://iverilog.icarus.com/



//ALL CAP COMMENTS ARE FOR INTERNAL COMMUNICATIONS AND SHOULD BE REMOVED BEFORE TURN IN

//PLACE ALL THE MODULE DEFINITIONS BELOW THIS LINE











module WebShooter(input [3:0] TelemetryTargetSelect, input[2:0] WebFunctionSelect, 
input [7:0] XCoordinate, input [7:0] YCoordinate, input [7:0] ZCoordinate, input [7:0] TimeCoordinate, input clk, 
 output [5:0] tracerCount, output energyEmpty);
 //THIS WILL NEED TO HAVE ALL THE MODULES THEMSELVES SET UP AND PREPARED FOR USE
 
 
 
 
 endmodule
//END MODULES




// Testbench
module WebShooterController ();


//Inputs
reg [3:0] TelemetryTargetSelect; //Input for target selection for the telemetry system
reg [2:0] WebFunctionSelect; //Input for selecting which web function to use
reg [7:0] XCoordinate //The position X of a target
reg [7:0] YCoordinate //The position Y of a target
reg [7:0] ZCoordinate //The position Z of a target
reg [7:0] TimeCoordinate //The value of Time associated with the target


reg clk; //The clock for the system as a whole



//outputs
wire [5:0] tracerCount //Number of tracers currently held in the WebShooter
wire energyEmpty; //If this is 1 then the system is out of power

//Should we have this? If removed, also remove close before $finish command
initial begin
	file = $fopen("L.D.Stark Industries.Output.txt", "w");
	end

//Create a WebShooter to test
//NEED DETAILS ON WHAT INPUTS AND OUTPUTS ARE NEEDED
WebShooter Shooter(TelemetryTargetSelect, WebFunctionSelect, 
XCoordinate, YCoordinate, ZCoordinate, TimeCoordinate, clk, 
tracerCount, energyEmpty);

 
 initial begin   
 
 //DISCUSS DESIGN OF OUTPUT, this current code below is just there so I can easily remember how to code it
 
 
 
  #1 //Delay a tick to avoid falling on edge
 $fdisplay(file, "000A 000B M 000S 000C \n",
           "==========================\n",
           "Begin \n",
		   
           "XXXX XXXX X  XXXX X \n",
		   "===========================\n",
		   
		   );
forever
	begin
	#10 //Double individual clock delay to get full length and keep on same frequency of updates
$fdisplay (file, "Addition example");
$fdisplay (file, "Set to addition");
$fdisplay (file, "XXXX XXXX ", "%b", m, "  XXXX X \n");
$fdisplay (file, "Set A= ",a);		   
$fdisplay (file, "%b",a," XXXX ", "%b", m, " XXXX X \n");


	end
end

initial begin

//Used the sample given as the default test case, adjust as desired, format of 1st input addition, second subtraction keeps the output consistent with labels
#5 
	clk=0;
#5 
	clk=1; 
	TelemetryTargetSelect = 4'b1011;
	WebFunctionSelect = 3'b011;
	XCoordinate = 8'b01010101;
	YCoordinate = 8'b11110000;
	ZCoordinate = 8'b10101010;
	TimeCoordinate = 8'b11001100;
#5 
	clk=0; 
#5 



end
 

initial begin
#30
$fclose(file); //Close output file
$finish; //Ends all loops
end 

 endmodule