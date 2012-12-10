`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:09:58 12/09/2012
// Design Name:   morse_decoder
// Module Name:   C:/Documents and Settings/student/Desktop/final/test_morse_decoder.v
// Project Name:  visual2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: morse_decoder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_morse_decoder;

	// Inputs
	reg cclk;
	reg rstb;
	reg tap;
	reg space;
	reg send;

	// Outputs
	wire [7:0] red;
	wire [7:0] green;
	wire [7:0] blue;

	wire [10:0] state;
	wire [30:0] touch_cycles;
	wire dot, dash;
	
	reg done_reading;
	wire send_ena;
	wire [7:0] send_byte;
	
	// Instantiate the Unit Under Test (UUT)
	morse_decoder uut (
		.cclk(cclk), 
		.rstb(rstb), 
		.tap(tap), 
		.space(space), 
		.send(send), 
		.red(red), 
		.green(green), 
		.blue(blue),
		
		.state(state),
		.touch_cycles(touch_cycles),
		.dot(dot),
		.dash(dash),
		.send_byte(send_byte),
		.send_ena(send_ena),
		.done_reading(done_reading)
	);

	initial begin
		// Initialize Inputs
		cclk = 0;
		rstb = 0;
		tap = 0;
		space = 0;
		send = 0;

		// Wait 100 ns for global reset to finish
		#100;
			rstb = 1;

        tap = 1;
		#1000000;
		  tap = 0;
		#10000000;
        tap = 1;
		#1000000;
		  tap = 0;
		#10000000;
        tap = 1;
		#10000000;
		  tap = 0;
		#10000000;
	        tap = 1;
		#20000000;
		  tap = 0;
		#10000000;
        tap = 1;
		#10000000;
		  tap = 0;
		#10000000;
        tap = 1;
		#10000000;
		  tap = 0;
		#10000000;
			send = 1;
		#10000000
			send = 0;
			done_reading = 1;
		#10000000
			space = 1;
		#10000000
			space = 0;
			done_reading = 1;
		#10000000;

	end
    
	// Add stimulus here
	always begin	
		cclk = ~cclk;
		#10;
	end	 
endmodule

