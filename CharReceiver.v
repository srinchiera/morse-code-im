`timescale 1ns / 1ps
`default_nettype none

`define SPACE (7'd27)
`define LIMIT (10417)

//////////////////////////////////////////////////////////////////////////////////
// 
// Module Name:    CharReceiver 
// Description:    Receives a character from the RX pin and shifts the chars.
//
// Because we are reading from a UART interface on a single pin, we must read
// characters 1 bit at a time according to the Xbee interface specified in its
// datasheet.  The interface is as follows:
//  - the pin idles high
//  - the pin signals a start bit, which is low, when a byte is ready to be read
//  - the pin then presents the 8 data bits one at a time
//  - the pin signals an end bit, which is high, when the byte has been read
// 
// Given this interface, this module implements a FSM which checks the input pin
// for the start signal at every clock cycle. Once it receives the start signal,
// the FSM reads the 8 data bits, 1 per clock cycle. The FSM then reads the end 
// bit and changes modes.
//
// Once the byte has been fully received, this module then shifts each of the 
// English characters on the screen to the left. The leftmost char in the top row
// is removed, and the newly received char is written to the screen in bottom row
// on the right. One char is shifted per clock cycle.
//
//////////////////////////////////////////////////////////////////////////////////
module CharReceiver(cclk,rstb,inputCharBit,char0,char1,char2,char3,char4,char5,char6,char7,char8,char9,char10,char11,char12,
							char13,char14,char15,char16,char17,char18,char19,char20,char21,char22,char23,char24,char25);
	//port definitions
	input  wire cclk;
	input  wire rstb;
	input  wire inputCharBit;
	output reg  [7:0] char0,  char1,  char2,  char3,  char4,  char5,  char6,  char7,  char8,  char9,  char10, char11, char12;
	output reg  [7:0] char13, char14, char15, char16, char17, char18, char19, char20, char21, char22, char23, char24, char25;

	reg [7:0] counter;
	reg [7:0] currChar;
	reg [31:0] clkCounter;
	
	always @(posedge cclk) begin
		if (~rstb) begin
			// dummy values
			char0  <= 8'd0;
			char1  <= 8'd1;
			char2  <= 8'd2;
			char3  <= 8'd3;
			char4  <= 8'd4;
			char5  <= 8'd27;
			char6  <= 8'd31;
			char7  <= 8'd32;
			char8  <= 8'd33;
			char9  <= 8'd34;
			char10 <= 8'd35;
			char11 <= 8'd36;
			char12 <= 8'd37;
			char13 <= 8'd0;
			char14 <= 8'd1;
			char15 <= 8'd2;
			char16 <= 8'd3;
			char17 <= 8'd4;
			char18 <= 8'd27;
			char19 <= 8'd31;
			char20 <= 8'd32;
			char21 <= 8'd33;
			char22 <= 8'd34;
			char23 <= 8'd35;
			char24 <= 8'd36;
			char25 <= 8'd37;
			counter <= 4'd9;
			currChar <= `SPACE;
			clkCounter <= 32'd0;
		end
		else begin
			if (clkCounter == 1) begin
				// start bit - about to receive message
				if (inputCharBit == 1'b0 && counter == 8'd34) begin 
					counter <= 8'd0;
				end
				// data bit - receive message and store in cache, aka currChar
				else if (counter < 8'd8) begin 
					currChar[counter] <= inputCharBit;
					counter <= counter + 8'd1;
				end
			end
			// end bit and idle afterwards - shift characters to the left
			else if (counter >= 8'd8 && counter < 8'd34 && inputCharBit == 1'b1) begin
				case (counter)
					8  : begin char0  <= char1;  end
					9  : begin char1  <= char2;  end
					10 : begin char2  <= char3;  end
					11 : begin char3  <= char4;  end
					12 : begin char4  <= char5;  end
					13 : begin char5  <= char6;  end
					14 : begin char6  <= char7;  end
					15 : begin char7  <= char8;  end
					16 : begin char8  <= char9;  end
					17 : begin char9  <= char10; end
					18 : begin char10 <= char11; end
					19 : begin char11 <= char12; end
					20 : begin char12 <= char13; end
					21 : begin char13 <= char14; end
					22 : begin char14 <= char15; end
					23 : begin char15 <= char16; end
					24 : begin char16 <= char17; end
					25 : begin char17 <= char18; end
					26 : begin char18 <= char19; end
					27 : begin char19 <= char20; end
					28 : begin char20 <= char21; end
					29 : begin char21 <= char22; end
					30 : begin char22 <= char23; end
					31 : begin char23 <= char24; end
					32 : begin char24 <= char25; end
					33 : begin char25 <= currChar; end
				endcase
				counter <= counter + 8'd1;
			end // if shifting chars
			
			if (clkCounter == `LIMIT - 1) begin
				clkCounter <= 0;
			end
			else begin
				clkCounter <= clkCounter + 32'd1;
			end
		end // else rstb
	end // always

endmodule
`default_nettype wire
