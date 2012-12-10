`timescale 1ns / 1ps
`default_nettype none

`define NUM_SUPER_PIXELS 15 // number of superpixels per box
`define SUPER_LEN 10        // side-length of superpixels
`define NUM_CHARS 7'd37     // number of defined characters

//////////////////////////////////////////////////////////////////////////////////
// 
// Module Name:    CharDraw 
// Description: 	 Draws a character within a given "box".
//
// A box is defined by its top-left x and y coordinates, and all boxes have the
// same height and width.
//
//	Characters are drawn by dividing up the given "box" into 15 sub-boxes, dubbed
// "super-pixels", each of which is 5 sub-boxes high and 3 sub-boxes wide. A 
// super-pixel can either be on (white color) or off (black  color), so the 
// combination of all the super-pixels and their value (on or off) determines 
// what character will be drawn.
//
// Since characters are defined by the values of the 15 super-pixels, each 
// super-pixel is represented by a vector, called a "super-vector". Each entry in 
// a super-vector corresponds to a character, so for example, the 1st entry in 
// each of the super-vectors represents the values for the character "A" in 
// super-pixels. To add support for a character, simply append a binary value to
// the end of each super-vector and increment the NUM_CHARS macro.
//
//////////////////////////////////////////////////////////////////////////////////
module CharDraw(clk,rstb,box_x,box_y,x,y,char,scale,tft_v);//tft_v,tft_g,tft_b);
	//port definitions
	input   wire clk, rstb;
	input   wire [9:0] box_x;  // top-left x-coordinate of the box
	input   wire [8:0] box_y;  // top-left y-coordinate of the box
	input   wire [9:0] x;      // current pixel's x-coordinate
	input   wire [8:0] y;      // current pixel's y-coordinate
	input   wire [7:0] char;   // char to draw
	input   wire [3:0] scale;  // percentage (out of 10) by which to scale characters ("8" = 80% scaling)	output  reg  [7:0] tft_v;  // screen output
	output  reg  [7:0] tft_v;  // grayscale output
	//output  reg  [7:0] tft_r, tft_g, tft_b;
	
	wire [6:0] idx;
	wire [8:0] row1, row2, row3, row4, row5, endr;
	wire [9:0] col1, col2, col3, endc;
	wire [(`NUM_CHARS-1):0] super1_vect, super2_vect, super3_vect, super4_vect,  super5_vect,  super6_vect;
	wire [(`NUM_CHARS-1):0] super7_vect, super8_vect, super9_vect, super10_vect, super11_vect, super12_vect;
	wire [(`NUM_CHARS-1):0] super13_vect, super14_vect, super15_vect;

	assign idx = `NUM_CHARS - char; // index into super pixel vectors
	
	// 5 rows of superpixels in a box
	assign row1 = box_y;
	assign row2 = box_y + (`SUPER_LEN * scale) / 10;
	assign row3 = box_y + (`SUPER_LEN * 2 * scale) / 10;
	assign row4 = box_y + (`SUPER_LEN * 3 * scale) / 10;
	assign row5 = box_y + (`SUPER_LEN * 4 * scale) / 10;
	assign endr = box_y + (`SUPER_LEN * 5 * scale) / 10;
	
	// 3 columns of superpixels in a box
	assign col1 = box_x;
	assign col2 = box_x + (`SUPER_LEN * scale) / 10;
	assign col3 = box_x + (`SUPER_LEN * 2 * scale) / 10;
	assign endc = box_x + (`SUPER_LEN * 3 * scale) / 10;
	
					           // A     B     C     D     E     F     G     H     I     J     K     L     M     N     O     P     Q     R     S     T     U     V     W     X     Y     Z  space    1     2     3     4     5     6     7     8     9   0  
	assign super1_vect  = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1};
	assign super2_vect  = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1};
	assign super3_vect  = {1'b1, 1'b0, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1};
	assign super4_vect  = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1};
	assign super5_vect  = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
	assign super6_vect  = {1'b1, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1};
	assign super7_vect  = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1};
	assign super8_vect  = {1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b0};
	assign super9_vect  = {1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1};
	assign super10_vect = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b1};
	assign super11_vect = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
	assign super12_vect = {1'b1, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1};
	assign super13_vect = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0, 1'b1};
	assign super14_vect = {1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0, 1'b1};
	assign super15_vect = {1'b1, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1};


	always @(posedge clk) begin
		if (~rstb) begin
			tft_v <= 8'd0;
		end
		else begin
			// 1st row of superpixels
			if (y >= row1 && y < row2 && x >= col1 && x < col2) begin
				tft_v <= super1_vect[idx] ? 8'd255 : 8'd0; end
			else if (y >= row1 && y < row2 && x >= col2 && x < col3) begin
				tft_v <= super2_vect[idx] ? 8'd255 : 8'd0; end
			else if (y >= row1 && y < row2 && x >= col3 && x < endc) begin
				tft_v <= super3_vect[idx] ? 8'd255 : 8'd0; end

			// 2nd row of superpixels
			else if (y >= row2 && y < row3 && x >= col1 && x < col2) begin
				tft_v <= super4_vect[idx] ? 8'd255 : 8'd0; end
			else if (y >= row2 && y < row3 && x >= col2 && x < col3) begin
				tft_v <= super5_vect[idx] ? 8'd255 : 8'd0; end
			else if (y >= row2 && y < row3 && x >= col3 && x < endc) begin
				tft_v <= super6_vect[idx] ? 8'd255 : 8'd0; end

			// 3rd row of superpixels
			else if (y >= row3 && y < row4 && x >= col1 && x < col2) begin
				tft_v <= super7_vect[idx] ? 8'd255 : 8'd0; end
			else if (y >= row3 && y < row4 && x >= col2 && x < col3) begin
				tft_v <= super8_vect[idx] ? 8'd255 : 8'd0; end
			else if (y >= row3 && y < row4 && x >= col3 && x < endc) begin
				tft_v <= super9_vect[idx] ? 8'd255 : 8'd0; end

			// 4th row of superpixels
			else if (y >= row4 && y < row5 && x >= col1 && x < col2) begin
				tft_v <= super10_vect[idx] ? 8'd255 : 8'd0; end
			else if (y >= row4 && y < row5 && x >= col2 && x < col3) begin
				tft_v <= super11_vect[idx] ? 8'd255 : 8'd0; end
			else if (y >= row4 && y < row5 && x >= col3 && x < endc) begin
				tft_v <= super12_vect[idx] ? 8'd255 : 8'd0; end

			// 5th row of superpixels
			else if (y >= row5 && y < endr && x >= col1 && x < col2) begin
				tft_v <= super13_vect[idx] ? 8'd255 : 8'd0; end
			else if (y >= row5 && y < endr && x >= col2 && x < col3) begin
				tft_v <= super14_vect[idx] ? 8'd255 : 8'd0; end
			else if (y >= row5 && y < endr && x >= col3 && x < endc) begin
				tft_v <= super15_vect[idx] ? 8'd255 : 8'd0; end

			else begin
				tft_v = 8'd0;
			end
		end // end rstb else
	end // end always

endmodule
`default_nettype wire
