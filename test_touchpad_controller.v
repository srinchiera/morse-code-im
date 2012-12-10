`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:43:28 10/26/2012
// Design Name:   touchpad_controller
// Module Name:   C:/Documents and Settings/student/Desktop/visual2/visual2/test_touchpad_controller.v
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

module test_touchpad_controller;

	// Inputs
	reg cclk;
	reg rstb;
	reg touch_busy;
	reg data_in;

	// Outputs
	wire touch_clk;
	wire data_out;
	wire touch_csb;
	wire [8:0] x;
	wire [8:0] y;
	wire [8:0] z;

	// Instantiate the Unit Under Test (UUT)
	touchpad_controller uut (
		.cclk(cclk), 
		.rstb(rstb), 
		.touch_busy(touch_busy), 
		.data_in(data_in), 
		.touch_clk(touch_clk), 
		.data_out(data_out), 
		.touch_csb(touch_csb), 
		.x(x), 
		.y(y), 
		.z(z)
	);

	always #5 cclk = ~cclk;
	
		always @(posedge touch_clk) begin
		if (counter == 0) begin
			if (data_out == 0) begin
				counter <= 1;
			end
			else begin
				counter <=0;
			end
			data_in <= 0;
		end
		else if (counter == 1) begin
			if (data_out == 0) begin
				counter <= 2;
			end
			else begin
				counter <=0;
			end
		end
		else if (counter == 2) begin
			if (data_out == 1) begin
				counter <= 3;
			end
			else begin
				counter <=0;
			end		
		end
		else if (counter == 3) begin
			if (data_out == 1) begin
				counter <= 4;
			end
			else begin
				counter <=0;
			end	
		end
		else if (counter == 4) begin
			data_in <= 0;
			counter <= counter + 1;
		end
		else if (counter == 5) begin
			data_in <= 1;
			counter <= counter + 1;
		end
		else if (counter == 6) begin
			data_in <= 1;
			counter <= counter + 1;
		end
		else if (counter == 7) begin
			data_in <= 1;
			counter <= counter + 1;
		end
		else if (counter == 8) begin
			data_in <= 1;
			counter <= counter + 1;
		end
		else if (counter == 9) begin
			data_in <= 1;
			counter <= counter + 1;
		end
		else if (counter == 10) begin
			data_in <= 1;
			counter <= counter + 1;
		end
		else if (counter == 11) begin
			data_in <= 1;
			counter <= counter + 1;
		end
		else if (counter == 12) begin
			data_in <= 0;
			counter <= counter + 1;
		end
		else if (counter == 13) begin
			data_in <= 1;
			counter <= counter + 1;
		end
		else if (counter == 14) begin
			data_in <= 1;
			counter <= 0;
		end
		end
	
	reg [7:0] counter;
	
	initial begin
		// Initialize Inputs
		cclk = 0;
		rstb = 0;
		data_in = 0;
		counter = 0;
		// Wait 100 ns for global reset to finish
		#100;
		
		rstb = 1;
		
    	end
      
endmodule

