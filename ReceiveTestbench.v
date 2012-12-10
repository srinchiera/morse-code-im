`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:54:41 12/01/2012
// Design Name:   touchpad_controller
// Module Name:   C:/Documents and Settings/student/Desktop/lat3-submission/visual2test/visual2/ReceiveTestbench.v
// Project Name:  visual2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: touchpad_controller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ReceiveTestbench;

	// Inputs
	reg cclk;
	reg rstb;
	reg char;
	reg touch_busy;
	reg data_in;

	// Outputs
	wire touch_clk;
	wire data_out;
	wire touch_csb;
	wire [11:0] x;
	wire [11:0] y;
	wire [11:0] z;

	// Instantiate the Unit Under Test (UUT)
	touchpad_controller uut (
		.cclk(cclk), 
		.rstb(rstb), 
		.char(char), 
		.touch_busy(touch_busy), 
		.data_in(data_in), 
		.touch_clk(touch_clk), 
		.data_out(data_out), 
		.touch_csb(touch_csb), 
		.x(x), 
		.y(y), 
		.z(z)
	);

	initial begin
		// Initialize Inputs
		cclk = 0;
		rstb = 0;
		char = 0;
		touch_busy = 0;
		data_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

