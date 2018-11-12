module spiderTaser(input enable, input clk, output webNeeded[3:0], output energyNeeded[7:0], output tracersNeeded[5:0]);


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

module spiderTracer(input enable, input clk, output webNeeded[3:0], output energyNeeded[7:0], output tracersNeeded[5:0]);


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


module spiderTracer(input enable, input clk, output webNeeded[3:0], output energyNeeded[7:0]);


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