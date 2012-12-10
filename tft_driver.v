`timescale 1ns / 1ps
`default_nettype none

`define TFT_X_RES 480 //pixel clock periods
`define TFT_Y_RES 272 //frame lines
`define TFT_X_BLANKING 45 //pixel clock periods
`define TFT_Y_BLANKING 16 //frame lines
`define TFT_CLK_DIV_COUNT 5 
`define TFT_BITS_PER_COLOR 3  //512 colors
`define TFT_BITS_PER_PIXEL 9
`define TFT_X_NUM_BITS 10
`define TFT_Y_NUM_BITS 9
`define TFT_Z_NUM_BITS 9
`define RECT_SIZE 25

module tft_driver(
	input wire cclk, rstb,
	input wire tft_clk,
	input wire [7:0] switch,
	output wire tft_backlight, tft_data_ena,
	output reg tft_display,tft_vdd,
	output wire [7:0] tft_red, tft_green, tft_blue,
	input wire [11:0] touch_x,
	input wire [11:0] touch_y,
	input wire [11:0] touch_z,
	input wire [(`TFT_BITS_PER_PIXEL-1):0] wr_data,
	output reg [(`TFT_X_NUM_BITS-1):0] x,
	output reg [(`TFT_Y_NUM_BITS-1):0] y,
	output reg [(`TFT_Z_NUM_BITS-1):0] z,
	output wire new_frame,
	input wire [7:0] in_red, in_green, in_blue
);

wire [11:0] lower_x, lower_y;
assign lower_x = touch_x < 50 ? 0 : touch_x - 50;
assign lower_y = touch_y < 50 ? 0 : touch_y - 50;

wire [7:0] redPig, bluePig, greenPig;

assign tft_red = in_red;
assign tft_green = in_green;
assign tft_blue = in_blue;

/*
assign redPig = (touch_z[11:4] == 0 ? 255 : 
							(touch_z[11:7] == 0 ? 255 - touch_z[6:4] << 5 : 
							(touch_z[11:10] == 0 ? 0 : touch_z[9:0] >> 3)));

assign greenPig = (touch_z[11:4] == 0 ? touch_z[3:0] >> 4 : 
							(touch_z[11:7] == 0 ? 255 : 
							(touch_z[11:10] == 0 ? 255 - touch_z[9:7] << 5 : 0)));
							
assign bluePig = (touch_z[11:4] == 0 ? touch_z[3:0] >> 0 : 
							(touch_z[11:7] == 0 ? 0 : 
							(touch_z[11:10] == 0 ?touch_z[9:7] << 5 : 255)));
*/
pwm_module PWM (.cclk(cclk), .rstb(rstb), .duty_cycle(switch), .base_frequency(1), .pwm_out(tft_backlight));

/*
assign tft_red = tft_data_ena ? (x >= lower_x && x < (touch_x+50) && y >= lower_y &&  y < (touch_y+50)) ? redPig : 8'h00
										: 8'b0;
assign tft_green = tft_data_ena ? (x >= lower_x &&  x < (touch_x+50) && y >= lower_y &&  y < (touch_y+50)) ? greenPig : 8'h00
										: 8'b0;
assign tft_blue = tft_data_ena ? (x >= lower_x  &&  x < (touch_x+50) && y >= lower_y &&  y < (touch_y+50)) ? bluePig : 8'h00
										: 8'b0;
*/
assign tft_data_ena = (x > `TFT_X_RES || y > `TFT_Y_RES) ? 0 : 1;

assign new_frame = (x == 0 && y == 0) ? 1 : 0;

always @(posedge tft_clk) begin
  if(~rstb) begin // reset active on low
    x <= 0;
	 y <= 0;
	 tft_vdd <= 0;
	 tft_display <= 0;
  end
  else begin //out of reset
  	 tft_vdd <= 1;
	 tft_display <= 1;
	 if (x == (`TFT_X_RES + `TFT_X_BLANKING)) begin
	   x <= 0;
		if (y == (`TFT_Y_RES+ `TFT_Y_BLANKING)) begin
			y <= 0;
		end
		else begin
			y <= y + 1;
		end
	 end
	 else begin
	     x <= x + 1;
	 end
  end
end

endmodule
`default_nettype wire