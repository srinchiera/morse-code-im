`timescale 1ns / 1ps
`default_nettype none

`define SUPER_LEN        5   // size of smaller superpixels
`define Y_OFFSET			 120 // Morse character y-offset
`define Y_BOTTOM			 130 // Morse character bottom

//////////////////////////////////////////////////////////////////////////////////
// 
// Module Name:    MorseDraw 
// Description: 	 Draws a Morse code character in a box.
//
// This module is a variant of CharDraw and is specialized to support Morse code
// characters.  Like CharDraw, MorseDraw divides up a box into super-pixels, each
// of which is represented by a super-vector.  For more info on "boxes", 
// "super-pixels", and "super-vectors", please see the description in CharDraw.
//
//////////////////////////////////////////////////////////////////////////////////
module MorseDraw(clk, rstb, box_x, x, y, tap, tft_v);
	//port definitions
	input  wire clk, rstb;
	input  wire [9:0] box_x; // top-left x-coordinate of the box
	input  wire [9:0] x;     // curr pixel x-coordinate
	input  wire [8:0] y;     // curr pixel y-coordinate
	input  wire [1:0] tap;   // Morse input: dash = 2'd1, dot = 2'd2, space/nothing = 2'd0
	output reg  [7:0] tft_v; // screen output

	//wire [1:0] idx = ;
	wire [9:0] col1, col2, col3, endc;
	wire [1:0] super1, super2, super3;

	//assign idx = tap - 1'd1;

	assign col1 = box_x;
	assign col2 = box_x + `SUPER_LEN;
	assign col3 = box_x + `SUPER_LEN * 3;
	assign endc = box_x + `SUPER_LEN * 4;

					   // dot  dash
	assign super1 = {1'd0, 1'd1};
//	assign super2 = {1'd1, 1'd1};
	assign super3 = {1'd0, 1'd1};


always@(posedge clk) begin
	if (~rstb) begin
		tft_v <= 8'd0;
	end
	else begin
		if (tap >= 2'd1) begin
			// do nothing
		end
		else if (y >= `Y_OFFSET && y < `Y_BOTTOM) begin
			if (x >= col1 && x < col2) begin
				tft_v <= super1[tap] ? 8'd255 : 8'd0;
			end
			else if (x >= col2 && x < col3) begin
				tft_v <= super2[tap] ? 8'd255 : 8'd0;
			end
			else if (x >= col3 && x < endc) begin
				tft_v <= super3[tap] ? 8'd255 : 8'd0;
			end
			else begin
				tft_v <= 8'd0;
			end
		end
	end
end
	
endmodule
`default_nettype wire
