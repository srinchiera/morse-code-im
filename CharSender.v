`timescale 1ns / 1ps
`default_nettype none

`define LIMIT 10417

//////////////////////////////////////////////////////////////////////////////////
// 
// Module Name:    CharSender 
// Description: 
//
//////////////////////////////////////////////////////////////////////////////////
module CharSender(cclk,rstb,send_ena,done_reading,char,outputCharBit);
	//port definitions
	input  wire cclk;
	input  wire rstb;
	input  wire send_ena;
	output reg done_reading;
	input  wire [7:0] char;
	output reg outputCharBit;

	reg [31:0] counter;
	reg [7:0] currChar;
	reg first;
	reg [31:0] clkCounter;

	always @(posedge cclk) begin
		if (~rstb) begin
			outputCharBit <= 1'b1;
			counter <= 32'd0;
			currChar <= 8'd5;
			done_reading <= 1'b0;
			first <= 1'b1;
			clkCounter <= 0;
		end
		else begin
			if (clkCounter == 1) begin
				if (send_ena && counter == 32'd10) begin
					currChar <= char;
					counter <= 32'd0;
				end
				else if (counter < 32'd10) begin    // FSM
					if (counter == 32'd0) begin      // start bit
						outputCharBit <= 1'b0;
						done_reading <= 1'b1;
					end
					else if (counter == 32'd9) begin // end bit and idle
						outputCharBit <= 1'b1;
						done_reading <= 1'b0;
					end
					else begin                       // data bits
						outputCharBit <= currChar[counter-1];
					end
					counter <= (counter + 32'd1);
				end
			end

			if (clkCounter == `LIMIT - 1) begin
				clkCounter <= 0;
			end
			else begin
				clkCounter <= clkCounter + 32'd1;
			end

		end // end else
	end // end always


endmodule
`default_nettype wire
