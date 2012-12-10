`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// 
// Module Name:    LineDraw 
// Description: 
//
//////////////////////////////////////////////////////////////////////////////////
module LineDraw(cclk,rstb,start_x,start_y,x,y,width,height,tft_value);
	//port definitions
	input  wire cclk, rstb;
	input  wire [9:0] start_x;
	input  wire [8:0] start_y;
	input  wire [9:0] x;
	input  wire [8:0] y;
	input  wire [9:0] width;
	input  wire [8:0] height;
	output reg [7:0] tft_value;

	always @(posedge cclk) begin
		if (~rstb) begin
			tft_value <= 8'd0;
		end
		else begin	
			if (x >= start_x && x < start_x + width && y >= start_y && y < start_y) begin
				tft_value <= 8'd255;
			end
			else begin
				tft_value <= 8'd0;
			end
		end
	end

endmodule
`default_nettype wire
