`timescale 1ns / 1ps
`default_nettype none

`define OFFSET(i)       (10'd5 + 10'd35 * i)
`define MOR_OFFSET(i) (10'd180 + 10'd25 * i)

`define LINE_Y 136
`define END_Y  272
`define HLINE1 0
`define HLINE2 0

`define ROW1_Y 5
`define ROW2_Y 60
`define ROW3_Y 115
`define ROW4_Y 120
`define ROW5_Y 130


//////////////////////////////////////////////////////////////////////////////////
// 
// Module Name:    ScreenMux 
// Description: 	 Controls which wire is wired up to the current pixel.
//
// There are many things on the screen at any given time, but only 1 pixel is
// written at every clock cycle. This module routes the correct wire to the 
// current pixel based on the Cartesian coordinates of the pixel.
//
// Currently, the Screen mux routes wires for the following screen objects:
//  - English characters
//  - Morse code characters
//  - lines
//
// To save memory, each module only computes a gray scale value instead of a 
// color value. Thus, the red, green, and blue components of a given pixel have 
// the same value for the screen objects mentioned above.
//
//////////////////////////////////////////////////////////////////////////////////
module ScreenMux(cclk,rstb,inputCharBit,tap,x,y,tft_red,tft_green,tft_blue);
	//port definitions
	input  wire cclk, rstb, inputCharBit;
	input  wire [1:0] tap;
	input  wire [9:0] x;
	input  wire [8:0] y;
	output wire [7:0] tft_red, tft_green, tft_blue;
	
	wire [7:0] v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25;

	wire [7:0] mor0, mor1, mor2, mor3, mor4;

	wire [7:0] char0, char1, char2, char3, char4, char5, char6, char7, char8, char9, char10, char11, char12;
	wire [7:0] char13, char14, char15, char16, char17, char18, char19, char20, char21, char22, char23, char24, char25;

	// CharReceiver (populate characters from Xbee)
	CharReceiver receiver(cclk, rstb, inputCharBit, char0, char1, char2, char3, char4, char5, char6, char7, char8, char9, char10, char11, char12, 
									char13, char14, char15, char16, char17, char18, char19, char20, char21, char22, char23, char24, char25);

	// CharDraw (shows English characters) - first row
	CharDraw chardraw0(cclk,  rstb, `OFFSET(0),  `ROW1_Y, x, y, char0,  v0);
	CharDraw chardraw1(cclk,  rstb, `OFFSET(1),  `ROW1_Y, x, y, char1,  v1);
	CharDraw chardraw2(cclk,  rstb, `OFFSET(2),  `ROW1_Y, x, y, char2,  v2);
	CharDraw chardraw3(cclk,  rstb, `OFFSET(3),  `ROW1_Y, x, y, char3,  v3);
	CharDraw chardraw4(cclk,  rstb, `OFFSET(4),  `ROW1_Y, x, y, char4,  v4);
	CharDraw chardraw5(cclk,  rstb, `OFFSET(5),  `ROW1_Y, x, y, char5,  v5);
	CharDraw chardraw6(cclk,  rstb, `OFFSET(6),  `ROW1_Y, x, y, char6,  v6);
	CharDraw chardraw7(cclk,  rstb, `OFFSET(7),  `ROW1_Y, x, y, char7,  v7);
	CharDraw chardraw8(cclk,  rstb, `OFFSET(8),  `ROW1_Y, x, y, char8,  v8);
	CharDraw chardraw9(cclk,  rstb, `OFFSET(9),  `ROW1_Y, x, y, char9,  v9);
	CharDraw chardraw10(cclk, rstb, `OFFSET(10), `ROW1_Y, x, y, char10, v10);
	CharDraw chardraw11(cclk, rstb, `OFFSET(11), `ROW1_Y, x, y, char11, v11);
	CharDraw chardraw12(cclk, rstb, `OFFSET(12), `ROW1_Y, x, y, char12, v12);

	// CharDraw (shows English characters) - second row
	CharDraw chardraw13(cclk, rstb, `OFFSET(0),  `ROW2_Y, x, y, char13, v13);
	CharDraw chardraw14(cclk, rstb, `OFFSET(1),  `ROW2_Y, x, y, char14, v14);
	CharDraw chardraw15(cclk, rstb, `OFFSET(2),  `ROW2_Y, x, y, char15, v15);
	CharDraw chardraw16(cclk, rstb, `OFFSET(3),  `ROW2_Y, x, y, char16, v16);
	CharDraw chardraw17(cclk, rstb, `OFFSET(4),  `ROW2_Y, x, y, char17, v17);
	CharDraw chardraw18(cclk, rstb, `OFFSET(5),  `ROW2_Y, x, y, char18, v18);
	CharDraw chardraw19(cclk, rstb, `OFFSET(6),  `ROW2_Y, x, y, char19, v19);
	CharDraw chardraw20(cclk, rstb, `OFFSET(7),  `ROW2_Y, x, y, char20, v20);
	CharDraw chardraw21(cclk, rstb, `OFFSET(8),  `ROW2_Y, x, y, char21, v21);
	CharDraw chardraw22(cclk, rstb, `OFFSET(9),  `ROW2_Y, x, y, char22, v22);
	CharDraw chardraw23(cclk, rstb, `OFFSET(10), `ROW2_Y, x, y, char23, v23);
	CharDraw chardraw24(cclk, rstb, `OFFSET(11), `ROW2_Y, x, y, char24, v24);
	CharDraw chardraw25(cclk, rstb, `OFFSET(12), `ROW2_Y, x, y, char25, v25);

	// MorseDraw (shows tap input)
	MorseDraw code0(cclk, rstb, `MOR_OFFSET(0), x, y, tap, mor0);
	MorseDraw code1(cclk, rstb, `MOR_OFFSET(1), x, y, tap, mor1);
	MorseDraw code2(cclk, rstb, `MOR_OFFSET(2), x, y, tap, mor2);
	MorseDraw code3(cclk, rstb, `MOR_OFFSET(3), x, y, tap, mor3);
	MorseDraw code4(cclk, rstb, `MOR_OFFSET(4), x, y, tap, mor4);

	assign tft_green = tft_red;
	assign tft_blue  = tft_red;
	assign tft_red = // draw the English characters
						  (x >= `OFFSET(0)     && x < `OFFSET(1)     && y >= `ROW1_Y && y < `ROW2_Y) ? v0  :
						  (x >= `OFFSET(1)     && x < `OFFSET(2)     && y >= `ROW1_Y && y < `ROW2_Y) ? v1  :
						  (x >= `OFFSET(2)     && x < `OFFSET(3)     && y >= `ROW1_Y && y < `ROW2_Y) ? v2  :
						  (x >= `OFFSET(3)     && x < `OFFSET(4)     && y >= `ROW1_Y && y < `ROW2_Y) ? v3  :
						  (x >= `OFFSET(4)     && x < `OFFSET(5)     && y >= `ROW1_Y && y < `ROW2_Y) ? v4  :
						  (x >= `OFFSET(5)     && x < `OFFSET(6)     && y >= `ROW1_Y && y < `ROW2_Y) ? v5  :
						  (x >= `OFFSET(6)     && x < `OFFSET(7)     && y >= `ROW1_Y && y < `ROW2_Y) ? v6  :
						  (x >= `OFFSET(7)     && x < `OFFSET(8)     && y >= `ROW1_Y && y < `ROW2_Y) ? v7  :
						  (x >= `OFFSET(8)     && x < `OFFSET(9)     && y >= `ROW1_Y && y < `ROW2_Y) ? v8  :
						  (x >= `OFFSET(9)     && x < `OFFSET(10)    && y >= `ROW1_Y && y < `ROW2_Y) ? v9  :
						  (x >= `OFFSET(10)    && x < `OFFSET(11)    && y >= `ROW1_Y && y < `ROW2_Y) ? v10 :
						  (x >= `OFFSET(11)    && x < `OFFSET(12)    && y >= `ROW1_Y && y < `ROW2_Y) ? v11 :
						  (x >= `OFFSET(12)    && x < `OFFSET(13)    && y >= `ROW1_Y && y < `ROW2_Y) ? v12 :
						  (x >= `OFFSET(0)     && x < `OFFSET(1)     && y >= `ROW2_Y && y < `ROW3_Y) ? v13 :
						  (x >= `OFFSET(1)     && x < `OFFSET(2)     && y >= `ROW2_Y && y < `ROW3_Y) ? v14 :
						  (x >= `OFFSET(2)     && x < `OFFSET(3)     && y >= `ROW2_Y && y < `ROW3_Y) ? v15 :
						  (x >= `OFFSET(3)     && x < `OFFSET(4)     && y >= `ROW2_Y && y < `ROW3_Y) ? v16 :
						  (x >= `OFFSET(4)     && x < `OFFSET(5)     && y >= `ROW2_Y && y < `ROW3_Y) ? v17 :
						  (x >= `OFFSET(5)     && x < `OFFSET(6)     && y >= `ROW2_Y && y < `ROW3_Y) ? v18 :
						  (x >= `OFFSET(6)     && x < `OFFSET(7)     && y >= `ROW2_Y && y < `ROW3_Y) ? v19 :
						  (x >= `OFFSET(7)     && x < `OFFSET(8)     && y >= `ROW2_Y && y < `ROW3_Y) ? v20 :
						  (x >= `OFFSET(8)     && x < `OFFSET(9)     && y >= `ROW2_Y && y < `ROW3_Y) ? v21 :
						  (x >= `OFFSET(9)     && x < `OFFSET(10)    && y >= `ROW2_Y && y < `ROW3_Y) ? v22 :
						  (x >= `OFFSET(10)    && x < `OFFSET(11)    && y >= `ROW2_Y && y < `ROW3_Y) ? v23 :
						  (x >= `OFFSET(11)    && x < `OFFSET(12)    && y >= `ROW2_Y && y < `ROW3_Y) ? v24 :
						  (x >= `OFFSET(12)    && x < `OFFSET(13)    && y >= `ROW2_Y && y < `ROW3_Y) ? v25 :
						  // draw the Morse code characters
						  (x >= `MOR_OFFSET(0) && x < `MOR_OFFSET(1) && y >= `ROW4_Y && y < `ROW5_Y) ? mor0 :
						  (x >= `MOR_OFFSET(1) && x < `MOR_OFFSET(2) && y >= `ROW4_Y && y < `ROW5_Y) ? mor1 :
						  (x >= `MOR_OFFSET(2) && x < `MOR_OFFSET(3) && y >= `ROW4_Y && y < `ROW5_Y) ? mor2 :
						  (x >= `MOR_OFFSET(3) && x < `MOR_OFFSET(4) && y >= `ROW4_Y && y < `ROW5_Y) ? mor3 :
						  (x >= `MOR_OFFSET(4) && x < `MOR_OFFSET(5) && y >= `ROW4_Y && y < `ROW5_Y) ? mor4 :
						  // draw the lines
						  (y >= `LINE_Y && y < `LINE_Y+1) 														  ? 8'd255 :
						  (x >= `HLINE1        && x < `HLINE1+1      && y >= `LINE_Y && y < `END_Y)  ? 8'd255 :
						  (x >= `HLINE2        && x < `HLINE1+1      && y >= `LINE_Y && y < `END_Y)  ? 8'd255 :
						  8'd0;
						  
endmodule
`default_nettype wire
