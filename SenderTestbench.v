`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:49:52 12/06/2012
// Design Name:   CharSender
// Module Name:   C:/Documents and Settings/student/Desktop/TestSender/visual2test/visual2/SenderTestbench.v
// Project Name:  visual2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CharSender
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module SenderTestbench;

	// Inputs
	reg cclk;
	reg rstb;
	reg send_ena;
	reg [7:0] char;

	// Outputs
	wire done_reading;
	wire outputCharBit;

	// Instantiate the Unit Under Test (UUT)
	CharSender uut (
		.cclk(cclk), 
		.rstb(rstb),
		.send_ena(send_ena),
		.done_reading(done_reading),
		.char(char),
		.outputCharBit(outputCharBit)
	);
	
	always #5 cclk = ~cclk;

	initial begin
		// Initialize Inputs
		cclk = 0;
		rstb = 0;

		// Wait 100 ns for global reset to finish
		#10;
		
		rstb = 1;
        
		// Add stimulus here
		repeat (10000) begin
			#10;
		end
	
	
	end
      
endmodule

