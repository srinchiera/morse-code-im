`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:41:15 12/02/2012
// Design Name:   CharDraw
// Module Name:   C:/Documents and Settings/student/Desktop/lat3-submission/visual2test/visual2/DrawTestbench.v
// Project Name:  visual2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CharDraw
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module DrawTestbench;

	// Inputs
	reg clk;
	reg rstb;
	reg [9:0] box_x;
	reg [8:0] box_y;
	reg [9:0] x;
	reg [8:0] y;
	reg [7:0] char;

	// Outputs
	wire [7:0] tft_r;
	wire [7:0] tft_g;
	wire [7:0] tft_b;
	wire [6:0] idx;
	
	// Instantiate the Unit Under Test (UUT)
	CharDraw uut (
		.clk(clk), 
		.rstb(rstb), 
		.box_x(box_x), 
		.box_y(box_y), 
		.x(x), 
		.y(y), 
		.char(char), 
		.tft_r(tft_r), 
		.tft_g(tft_g), 
		.tft_b(tft_b),
		.idx(idx)
	);
	
	always #5 clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		rstb = 0;
		box_x = 0;
		box_y = 0;
		x = 0;
		y = 0;
		char = 8'd1;
		
		// Wait 100 ns for global reset to finish
		#10;
      rstb <= 1;
		  
		// Add stimulus here
		repeat (1410065408) begin
			#10;
			x <= (x + 1) % 480;
			if (x == 0) begin
				y <= (y + 1) % 272;
			end
		end

	end
      
endmodule

