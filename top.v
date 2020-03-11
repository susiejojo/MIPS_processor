`timescale 1ns / 1ps
module top;

	// Inputs
	reg clk;
    reg get;
	// Outputs
	wire [31:0] reg_memory;
    wire [31:0] main_memory;
	wire [31:0] instr;
//	reg [31:0] memreg;

	// Instantiate the Unit Under Test (UUT)
	CPU uut (
		.clk(clk), 
		.reg_memory(reg_memory), 
		.main_memory(main_memory),
		.instr(instr),
		.get(get)
	);
	always #5 clk = ~clk;
	initial begin
		// Initialize Inputs
		get = 0;
		clk = 1;
		//memreg = 0;
		
	end
      
endmodule
