`timescale 1ns / 1ps
`default_nettype none

`define C_OFFSET(i)   (10'd5 + 10'd35 * i)   // character x-offset
`define M_OFFSET(i)   (10'd180 + 10'd25 * i) // Morse display x-offset
`define L_OFFSET(a,i) (a + 10'd29 * i)       // button label x-offset

`define HLINE1 160 // left vertical line x-offset
`define HLINE2 320 // right vertical line x-offset

`define ROW1_Y 5   // signal line 1 y-offset
`define ROW2_Y 60  // signal line 2 y-offset
`define ROW3_Y 115 // signal line 2 bottom
`define ROW4_Y 120 // Morse y-offset
`define ROW5_Y 130 // Morse bottom
`define LINE_Y 136 // horizontal line y-offset
`define ROW6_Y 184 // button label y-offset
`define ROW7_Y 224 // button label bottom
`define END_Y  272 // bottom of screen

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
//	 - input button labels ("space," "tap," "send")
//
// To save memory, each module only computes a gray scale value instead of a 
// color value. Thus, the red, green, and blue components of a given pixel have 
// the same value for the screen objects mentioned above.
//
//////////////////////////////////////////////////////////////////////////////////
module ScreenMux(cclk,rstb,inputCharBit,tap,x,y,morseCode,bg_red, bg_green, bg_blue,tft_red,tft_green,tft_blue);
	//port definitions
	input  wire cclk, rstb, inputCharBit;
	input  wire [1:0] tap;
	input  wire [9:0] x;
	input  wire [8:0] y;
	input  wire [1:0] morseCode;
//	input   reg [2:0] button; // 2'd0 = nothing pressed, 2'd1 = space, 2'd2 = tap, 2'd3 = send
	input  wire [7:0] bg_red, bg_green, bg_blue;
	output wire [7:0] tft_red, tft_green, tft_blue;
	
	// Outputs to write to screen
	wire [7:0] v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25; // Message output characters
	wire [7:0] mor0, mor1, mor2, mor3, mor4; // Morse code output symbols
	wire [7:0] b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11; // Button label output characters

	// Current set of received character signals
	wire [7:0] char0, char1, char2, char3, char4, char5, char6, char7, char8, char9, char10, char11, char12;
	wire [7:0] char13, char14, char15, char16, char17, char18, char19, char20, char21, char22, char23, char24, char25;

	// CharReceiver (populate characters from Xbee)
	CharReceiver receiver(cclk, rstb, inputCharBit, char0, char1, char2, char3, char4, char5, char6, char7, char8, char9, char10, char11, char12, 
								 char13, char14, char15, char16, char17, char18, char19, char20, char21, char22, char23, char24, char25);

	// First row of incoming signal (CharDraw shows English characters)
	CharDraw chardraw0(cclk,  rstb, `C_OFFSET(0),  `ROW1_Y, x, y, char0,  10, v0);
	CharDraw chardraw1(cclk,  rstb, `C_OFFSET(1),  `ROW1_Y, x, y, char1,  10, v1);
	CharDraw chardraw2(cclk,  rstb, `C_OFFSET(2),  `ROW1_Y, x, y, char2,  10, v2);
	CharDraw chardraw3(cclk,  rstb, `C_OFFSET(3),  `ROW1_Y, x, y, char3,  10, v3);
	CharDraw chardraw4(cclk,  rstb, `C_OFFSET(4),  `ROW1_Y, x, y, char4,  10, v4);
	CharDraw chardraw5(cclk,  rstb, `C_OFFSET(5),  `ROW1_Y, x, y, char5,  10, v5);
	CharDraw chardraw6(cclk,  rstb, `C_OFFSET(6),  `ROW1_Y, x, y, char6,  10, v6);
	CharDraw chardraw7(cclk,  rstb, `C_OFFSET(7),  `ROW1_Y, x, y, char7,  10, v7);
	CharDraw chardraw8(cclk,  rstb, `C_OFFSET(8),  `ROW1_Y, x, y, char8,  10, v8);
	CharDraw chardraw9(cclk,  rstb, `C_OFFSET(9),  `ROW1_Y, x, y, char9,  10, v9);
	CharDraw chardraw10(cclk, rstb, `C_OFFSET(10), `ROW1_Y, x, y, char10, 10, v10);
	CharDraw chardraw11(cclk, rstb, `C_OFFSET(11), `ROW1_Y, x, y, char11, 10, v11);
	CharDraw chardraw12(cclk, rstb, `C_OFFSET(12), `ROW1_Y, x, y, char12, 10, v12);

	// Second row of incoming signal
	CharDraw chardraw13(cclk, rstb, `C_OFFSET(0),  `ROW2_Y, x, y, char13, 10, v13);
	CharDraw chardraw14(cclk, rstb, `C_OFFSET(1),  `ROW2_Y, x, y, char14, 10, v14);
	CharDraw chardraw15(cclk, rstb, `C_OFFSET(2),  `ROW2_Y, x, y, char15, 10, v15);
	CharDraw chardraw16(cclk, rstb, `C_OFFSET(3),  `ROW2_Y, x, y, char16, 10, v16);
	CharDraw chardraw17(cclk, rstb, `C_OFFSET(4),  `ROW2_Y, x, y, char17, 10, v17);
	CharDraw chardraw18(cclk, rstb, `C_OFFSET(5),  `ROW2_Y, x, y, char18, 10, v18);
	CharDraw chardraw19(cclk, rstb, `C_OFFSET(6),  `ROW2_Y, x, y, char19, 10, v19);
	CharDraw chardraw20(cclk, rstb, `C_OFFSET(7),  `ROW2_Y, x, y, char20, 10, v20);
	CharDraw chardraw21(cclk, rstb, `C_OFFSET(8),  `ROW2_Y, x, y, char21, 10, v21);
	CharDraw chardraw22(cclk, rstb, `C_OFFSET(9),  `ROW2_Y, x, y, char22, 10, v22);
	CharDraw chardraw23(cclk, rstb, `C_OFFSET(10), `ROW2_Y, x, y, char23, 10, v23);
	CharDraw chardraw24(cclk, rstb, `C_OFFSET(11), `ROW2_Y, x, y, char24, 10, v24);
	CharDraw chardraw25(cclk, rstb, `C_OFFSET(12), `ROW2_Y, x, y, char25, 10, v25);

	// Display tap input (MorseDraw shows dots and dashes)
	MorseDraw code0(cclk, rstb, `M_OFFSET(0), x, y, 2'd1, mor0);
	MorseDraw code1(cclk, rstb, `M_OFFSET(1), x, y, 2'd1, mor1);
	MorseDraw code2(cclk, rstb, `M_OFFSET(2), x, y, 2'd1, mor2);
	MorseDraw code3(cclk, rstb, `M_OFFSET(3), x, y, 2'd0, mor3);
	MorseDraw code4(cclk, rstb, `M_OFFSET(4), x, y, 2'd0, mor4);
	
	// Labels for input buttons 
	CharDraw label0(cclk,  rstb, `L_OFFSET(10'd7,   0),  `ROW6_Y, x, y, 19, 8, b0);  // S
	CharDraw label1(cclk,  rstb, `L_OFFSET(10'd7,   1),  `ROW6_Y, x, y, 16, 8, b1);  //  P
	CharDraw label2(cclk,  rstb, `L_OFFSET(10'd7,   2),  `ROW6_Y, x, y, 1,  8, b2);  //   A
	CharDraw label3(cclk,  rstb, `L_OFFSET(10'd7,   3),  `ROW6_Y, x, y, 3,  8, b3);  //    C
	CharDraw label4(cclk,  rstb, `L_OFFSET(10'd7,   4),  `ROW6_Y, x, y, 5,  8, b4);  //     E
	CharDraw label5(cclk,  rstb, `L_OFFSET(10'd196, 0),  `ROW6_Y, x, y, 20, 8, b5);  // T
	CharDraw label6(cclk,  rstb, `L_OFFSET(10'd196, 1),  `ROW6_Y, x, y, 1,  8, b6);  //  A
	CharDraw label7(cclk,  rstb, `L_OFFSET(10'd196, 2),  `ROW6_Y, x, y, 16, 8, b7);  //   P
	CharDraw label8(cclk,  rstb, `L_OFFSET(10'd342, 0),  `ROW6_Y, x, y, 19, 8, b8);  // S
	CharDraw label9(cclk,  rstb, `L_OFFSET(10'd342, 1),  `ROW6_Y, x, y, 5,  8, b9);  //  E
	CharDraw label10(cclk, rstb, `L_OFFSET(10'd342, 2),  `ROW6_Y, x, y, 14, 8, b10); //   N
	CharDraw label11(cclk, rstb, `L_OFFSET(10'd342, 3),  `ROW6_Y, x, y, 4,  8, b11); //    D
                                
	// Output display colors
	assign tft_red = // draw the English characters (row 1) at y = 5
						  (x >= `C_OFFSET(0)  && x < `C_OFFSET(1)  && y >= `ROW1_Y && y < `ROW2_Y) ? v0  :
						  (x >= `C_OFFSET(1)  && x < `C_OFFSET(2)  && y >= `ROW1_Y && y < `ROW2_Y) ? v1  :
						  (x >= `C_OFFSET(2)  && x < `C_OFFSET(3)  && y >= `ROW1_Y && y < `ROW2_Y) ? v2  :
						  (x >= `C_OFFSET(3)  && x < `C_OFFSET(4)  && y >= `ROW1_Y && y < `ROW2_Y) ? v3  :
						  (x >= `C_OFFSET(4)  && x < `C_OFFSET(5)  && y >= `ROW1_Y && y < `ROW2_Y) ? v4  :
						  (x >= `C_OFFSET(5)  && x < `C_OFFSET(6)  && y >= `ROW1_Y && y < `ROW2_Y) ? v5  :
						  (x >= `C_OFFSET(6)  && x < `C_OFFSET(7)  && y >= `ROW1_Y && y < `ROW2_Y) ? v6  :
						  (x >= `C_OFFSET(7)  && x < `C_OFFSET(8)  && y >= `ROW1_Y && y < `ROW2_Y) ? v7  :
						  (x >= `C_OFFSET(8)  && x < `C_OFFSET(9)  && y >= `ROW1_Y && y < `ROW2_Y) ? v8  :
						  (x >= `C_OFFSET(9)  && x < `C_OFFSET(10) && y >= `ROW1_Y && y < `ROW2_Y) ? v9  :
						  (x >= `C_OFFSET(10) && x < `C_OFFSET(11) && y >= `ROW1_Y && y < `ROW2_Y) ? v10 :
						  (x >= `C_OFFSET(11) && x < `C_OFFSET(12) && y >= `ROW1_Y && y < `ROW2_Y) ? v11 :
						  (x >= `C_OFFSET(12) && x < `C_OFFSET(13) && y >= `ROW1_Y && y < `ROW2_Y) ? v12 :

						  // draw the English characters (row 2) at y = 60
						  (x >= `C_OFFSET(0)  && x < `C_OFFSET(1)  && y >= `ROW2_Y && y < `ROW3_Y) ? v13 :
						  (x >= `C_OFFSET(1)  && x < `C_OFFSET(2)  && y >= `ROW2_Y && y < `ROW3_Y) ? v14 :
						  (x >= `C_OFFSET(2)  && x < `C_OFFSET(3)  && y >= `ROW2_Y && y < `ROW3_Y) ? v15 :
						  (x >= `C_OFFSET(3)  && x < `C_OFFSET(4)  && y >= `ROW2_Y && y < `ROW3_Y) ? v16 :
						  (x >= `C_OFFSET(4)  && x < `C_OFFSET(5)  && y >= `ROW2_Y && y < `ROW3_Y) ? v17 :
						  (x >= `C_OFFSET(5)  && x < `C_OFFSET(6)  && y >= `ROW2_Y && y < `ROW3_Y) ? v18 :
						  (x >= `C_OFFSET(6)  && x < `C_OFFSET(7)  && y >= `ROW2_Y && y < `ROW3_Y) ? v19 :
						  (x >= `C_OFFSET(7)  && x < `C_OFFSET(8)  && y >= `ROW2_Y && y < `ROW3_Y) ? v20 :
						  (x >= `C_OFFSET(8)  && x < `C_OFFSET(9)  && y >= `ROW2_Y && y < `ROW3_Y) ? v21 :
						  (x >= `C_OFFSET(9)  && x < `C_OFFSET(10) && y >= `ROW2_Y && y < `ROW3_Y) ? v22 :
						  (x >= `C_OFFSET(10) && x < `C_OFFSET(11) && y >= `ROW2_Y && y < `ROW3_Y) ? v23 :
						  (x >= `C_OFFSET(11) && x < `C_OFFSET(12) && y >= `ROW2_Y && y < `ROW3_Y) ? v24 :
						  (x >= `C_OFFSET(12) && x < `C_OFFSET(13) && y >= `ROW2_Y && y < `ROW3_Y) ? v25 :

						  // draw the Morse code characters at y = 115
						  (x >= `M_OFFSET(0) && x < `M_OFFSET(1) && y >= `ROW4_Y && y < `ROW5_Y) ? mor0 :
						  (x >= `M_OFFSET(1) && x < `M_OFFSET(2) && y >= `ROW4_Y && y < `ROW5_Y) ? mor1 :
						  (x >= `M_OFFSET(2) && x < `M_OFFSET(3) && y >= `ROW4_Y && y < `ROW5_Y) ? mor2 :
						  (x >= `M_OFFSET(3) && x < `M_OFFSET(4) && y >= `ROW4_Y && y < `ROW5_Y) ? mor3 :
						  (x >= `M_OFFSET(4) && x < `M_OFFSET(5) && y >= `ROW4_Y && y < `ROW5_Y) ? mor4 :

						  // draw the lines                                              
						  (y >= `LINE_Y && y < `LINE_Y+1) 														  ? 8'd255 :
						  (x >= `HLINE1        && x < `HLINE1+1      && y >= `LINE_Y && y < `END_Y)  ? 8'd255 :
						  (x >= `HLINE2        && x < `HLINE2+1      && y >= `LINE_Y && y < `END_Y)  ? 8'd255 :

						  // draw the input button labels
						  (x >= `L_OFFSET(10'd7,   0) && x < `L_OFFSET(10'd7,   1) && y >= `ROW6_Y && y < `ROW7_Y) ? b0 :
						  (x >= `L_OFFSET(10'd7,   1) && x < `L_OFFSET(10'd7,   2) && y >= `ROW6_Y && y < `ROW7_Y) ? b1 :
						  (x >= `L_OFFSET(10'd7,   2) && x < `L_OFFSET(10'd7,   3) && y >= `ROW6_Y && y < `ROW7_Y) ? b2 :
						  (x >= `L_OFFSET(10'd7,   3) && x < `L_OFFSET(10'd7,   4) && y >= `ROW6_Y && y < `ROW7_Y) ? b3 :
						  (x >= `L_OFFSET(10'd7,   4) && x < `L_OFFSET(10'd7,   5) && y >= `ROW6_Y && y < `ROW7_Y) ? b4 :
						  (x >= `L_OFFSET(10'd196, 0) && x < `L_OFFSET(10'd196, 1) && y >= `ROW6_Y && y < `ROW7_Y) ? b5 :
						  (x >= `L_OFFSET(10'd196, 1) && x < `L_OFFSET(10'd196, 2) && y >= `ROW6_Y && y < `ROW7_Y) ? b6 :
						  (x >= `L_OFFSET(10'd196, 2) && x < `L_OFFSET(10'd196, 3) && y >= `ROW6_Y && y < `ROW7_Y) ? b7 :
						  (x >= `L_OFFSET(10'd342, 0) && x < `L_OFFSET(10'd342, 1) && y >= `ROW6_Y && y < `ROW7_Y) ? b8 :
						  (x >= `L_OFFSET(10'd342, 1) && x < `L_OFFSET(10'd342, 2) && y >= `ROW6_Y && y < `ROW7_Y) ? b9 :
						  (x >= `L_OFFSET(10'd342, 2) && x < `L_OFFSET(10'd342, 3) && y >= `ROW6_Y && y < `ROW7_Y) ? b10 :
						  (x >= `L_OFFSET(10'd342, 3) && x < `L_OFFSET(10'd342, 4) && y >= `ROW6_Y && y < `ROW7_Y) ? b11 :
/*
						  // visual signal for tapping buttons
						  (y > 137 && x < 160  && button == 2'd1) 			  ? 8'd255 :
						  (y > 137 && x >= 161 && x < 320 && button == 2'd2) ? 8'd255 :
						  (y > 137 && x >= 321 && x < 480 && button == 2'd3) ? 8'd255 :
*/  
						  // default
						  bg_red;
	assign tft_green = // draw the English characters (row 1) at y = 5
						  (x >= `C_OFFSET(0)  && x < `C_OFFSET(1)  && y >= `ROW1_Y && y < `ROW2_Y) ? v0  :
						  (x >= `C_OFFSET(1)  && x < `C_OFFSET(2)  && y >= `ROW1_Y && y < `ROW2_Y) ? v1  :
						  (x >= `C_OFFSET(2)  && x < `C_OFFSET(3)  && y >= `ROW1_Y && y < `ROW2_Y) ? v2  :
						  (x >= `C_OFFSET(3)  && x < `C_OFFSET(4)  && y >= `ROW1_Y && y < `ROW2_Y) ? v3  :
						  (x >= `C_OFFSET(4)  && x < `C_OFFSET(5)  && y >= `ROW1_Y && y < `ROW2_Y) ? v4  :
						  (x >= `C_OFFSET(5)  && x < `C_OFFSET(6)  && y >= `ROW1_Y && y < `ROW2_Y) ? v5  :
						  (x >= `C_OFFSET(6)  && x < `C_OFFSET(7)  && y >= `ROW1_Y && y < `ROW2_Y) ? v6  :
						  (x >= `C_OFFSET(7)  && x < `C_OFFSET(8)  && y >= `ROW1_Y && y < `ROW2_Y) ? v7  :
						  (x >= `C_OFFSET(8)  && x < `C_OFFSET(9)  && y >= `ROW1_Y && y < `ROW2_Y) ? v8  :
						  (x >= `C_OFFSET(9)  && x < `C_OFFSET(10) && y >= `ROW1_Y && y < `ROW2_Y) ? v9  :
						  (x >= `C_OFFSET(10) && x < `C_OFFSET(11) && y >= `ROW1_Y && y < `ROW2_Y) ? v10 :
						  (x >= `C_OFFSET(11) && x < `C_OFFSET(12) && y >= `ROW1_Y && y < `ROW2_Y) ? v11 :
						  (x >= `C_OFFSET(12) && x < `C_OFFSET(13) && y >= `ROW1_Y && y < `ROW2_Y) ? v12 :

						  // draw the English characters (row 2) at y = 60
						  (x >= `C_OFFSET(0)  && x < `C_OFFSET(1)  && y >= `ROW2_Y && y < `ROW3_Y) ? v13 :
						  (x >= `C_OFFSET(1)  && x < `C_OFFSET(2)  && y >= `ROW2_Y && y < `ROW3_Y) ? v14 :
						  (x >= `C_OFFSET(2)  && x < `C_OFFSET(3)  && y >= `ROW2_Y && y < `ROW3_Y) ? v15 :
						  (x >= `C_OFFSET(3)  && x < `C_OFFSET(4)  && y >= `ROW2_Y && y < `ROW3_Y) ? v16 :
						  (x >= `C_OFFSET(4)  && x < `C_OFFSET(5)  && y >= `ROW2_Y && y < `ROW3_Y) ? v17 :
						  (x >= `C_OFFSET(5)  && x < `C_OFFSET(6)  && y >= `ROW2_Y && y < `ROW3_Y) ? v18 :
						  (x >= `C_OFFSET(6)  && x < `C_OFFSET(7)  && y >= `ROW2_Y && y < `ROW3_Y) ? v19 :
						  (x >= `C_OFFSET(7)  && x < `C_OFFSET(8)  && y >= `ROW2_Y && y < `ROW3_Y) ? v20 :
						  (x >= `C_OFFSET(8)  && x < `C_OFFSET(9)  && y >= `ROW2_Y && y < `ROW3_Y) ? v21 :
						  (x >= `C_OFFSET(9)  && x < `C_OFFSET(10) && y >= `ROW2_Y && y < `ROW3_Y) ? v22 :
						  (x >= `C_OFFSET(10) && x < `C_OFFSET(11) && y >= `ROW2_Y && y < `ROW3_Y) ? v23 :
						  (x >= `C_OFFSET(11) && x < `C_OFFSET(12) && y >= `ROW2_Y && y < `ROW3_Y) ? v24 :
						  (x >= `C_OFFSET(12) && x < `C_OFFSET(13) && y >= `ROW2_Y && y < `ROW3_Y) ? v25 :

						  // draw the Morse code characters at y = 115
						  (x >= `M_OFFSET(0) && x < `M_OFFSET(1) && y >= `ROW4_Y && y < `ROW5_Y) ? mor0 :
						  (x >= `M_OFFSET(1) && x < `M_OFFSET(2) && y >= `ROW4_Y && y < `ROW5_Y) ? mor1 :
						  (x >= `M_OFFSET(2) && x < `M_OFFSET(3) && y >= `ROW4_Y && y < `ROW5_Y) ? mor2 :
						  (x >= `M_OFFSET(3) && x < `M_OFFSET(4) && y >= `ROW4_Y && y < `ROW5_Y) ? mor3 :
						  (x >= `M_OFFSET(4) && x < `M_OFFSET(5) && y >= `ROW4_Y && y < `ROW5_Y) ? mor4 :

						  // draw the lines                                              
						  (y >= `LINE_Y && y < `LINE_Y+1) 														  ? 8'd255 :
						  (x >= `HLINE1        && x < `HLINE1+1      && y >= `LINE_Y && y < `END_Y)  ? 8'd255 :
						  (x >= `HLINE2        && x < `HLINE2+1      && y >= `LINE_Y && y < `END_Y)  ? 8'd255 :

						  // draw the input button labels
						  (x >= `L_OFFSET(10'd7,   0) && x < `L_OFFSET(10'd7,   1) && y >= `ROW6_Y && y < `ROW7_Y) ? b0 :
						  (x >= `L_OFFSET(10'd7,   1) && x < `L_OFFSET(10'd7,   2) && y >= `ROW6_Y && y < `ROW7_Y) ? b1 :
						  (x >= `L_OFFSET(10'd7,   2) && x < `L_OFFSET(10'd7,   3) && y >= `ROW6_Y && y < `ROW7_Y) ? b2 :
						  (x >= `L_OFFSET(10'd7,   3) && x < `L_OFFSET(10'd7,   4) && y >= `ROW6_Y && y < `ROW7_Y) ? b3 :
						  (x >= `L_OFFSET(10'd7,   4) && x < `L_OFFSET(10'd7,   5) && y >= `ROW6_Y && y < `ROW7_Y) ? b4 :
						  (x >= `L_OFFSET(10'd196, 0) && x < `L_OFFSET(10'd196, 1) && y >= `ROW6_Y && y < `ROW7_Y) ? b5 :
						  (x >= `L_OFFSET(10'd196, 1) && x < `L_OFFSET(10'd196, 2) && y >= `ROW6_Y && y < `ROW7_Y) ? b6 :
						  (x >= `L_OFFSET(10'd196, 2) && x < `L_OFFSET(10'd196, 3) && y >= `ROW6_Y && y < `ROW7_Y) ? b7 :
						  (x >= `L_OFFSET(10'd342, 0) && x < `L_OFFSET(10'd342, 1) && y >= `ROW6_Y && y < `ROW7_Y) ? b8 :
						  (x >= `L_OFFSET(10'd342, 1) && x < `L_OFFSET(10'd342, 2) && y >= `ROW6_Y && y < `ROW7_Y) ? b9 :
						  (x >= `L_OFFSET(10'd342, 2) && x < `L_OFFSET(10'd342, 3) && y >= `ROW6_Y && y < `ROW7_Y) ? b10 :
						  (x >= `L_OFFSET(10'd342, 3) && x < `L_OFFSET(10'd342, 4) && y >= `ROW6_Y && y < `ROW7_Y) ? b11 :
/*
						  // visual signal for tapping buttons
						  (y > 137 && x < 160  && button == 2'd1) 			  ? 8'd255 :
						  (y > 137 && x >= 161 && x < 320 && button == 2'd2) ? 8'd255 :
						  (y > 137 && x >= 321 && x < 480 && button == 2'd3) ? 8'd255 :
*/  
						  // default
						  bg_green;
	assign tft_blue = // draw the English characters (row 1) at y = 5
						  (x >= `C_OFFSET(0)  && x < `C_OFFSET(1)  && y >= `ROW1_Y && y < `ROW2_Y) ? v0  :
						  (x >= `C_OFFSET(1)  && x < `C_OFFSET(2)  && y >= `ROW1_Y && y < `ROW2_Y) ? v1  :
						  (x >= `C_OFFSET(2)  && x < `C_OFFSET(3)  && y >= `ROW1_Y && y < `ROW2_Y) ? v2  :
						  (x >= `C_OFFSET(3)  && x < `C_OFFSET(4)  && y >= `ROW1_Y && y < `ROW2_Y) ? v3  :
						  (x >= `C_OFFSET(4)  && x < `C_OFFSET(5)  && y >= `ROW1_Y && y < `ROW2_Y) ? v4  :
						  (x >= `C_OFFSET(5)  && x < `C_OFFSET(6)  && y >= `ROW1_Y && y < `ROW2_Y) ? v5  :
						  (x >= `C_OFFSET(6)  && x < `C_OFFSET(7)  && y >= `ROW1_Y && y < `ROW2_Y) ? v6  :
						  (x >= `C_OFFSET(7)  && x < `C_OFFSET(8)  && y >= `ROW1_Y && y < `ROW2_Y) ? v7  :
						  (x >= `C_OFFSET(8)  && x < `C_OFFSET(9)  && y >= `ROW1_Y && y < `ROW2_Y) ? v8  :
						  (x >= `C_OFFSET(9)  && x < `C_OFFSET(10) && y >= `ROW1_Y && y < `ROW2_Y) ? v9  :
						  (x >= `C_OFFSET(10) && x < `C_OFFSET(11) && y >= `ROW1_Y && y < `ROW2_Y) ? v10 :
						  (x >= `C_OFFSET(11) && x < `C_OFFSET(12) && y >= `ROW1_Y && y < `ROW2_Y) ? v11 :
						  (x >= `C_OFFSET(12) && x < `C_OFFSET(13) && y >= `ROW1_Y && y < `ROW2_Y) ? v12 :

						  // draw the English characters (row 2) at y = 60
						  (x >= `C_OFFSET(0)  && x < `C_OFFSET(1)  && y >= `ROW2_Y && y < `ROW3_Y) ? v13 :
						  (x >= `C_OFFSET(1)  && x < `C_OFFSET(2)  && y >= `ROW2_Y && y < `ROW3_Y) ? v14 :
						  (x >= `C_OFFSET(2)  && x < `C_OFFSET(3)  && y >= `ROW2_Y && y < `ROW3_Y) ? v15 :
						  (x >= `C_OFFSET(3)  && x < `C_OFFSET(4)  && y >= `ROW2_Y && y < `ROW3_Y) ? v16 :
						  (x >= `C_OFFSET(4)  && x < `C_OFFSET(5)  && y >= `ROW2_Y && y < `ROW3_Y) ? v17 :
						  (x >= `C_OFFSET(5)  && x < `C_OFFSET(6)  && y >= `ROW2_Y && y < `ROW3_Y) ? v18 :
						  (x >= `C_OFFSET(6)  && x < `C_OFFSET(7)  && y >= `ROW2_Y && y < `ROW3_Y) ? v19 :
						  (x >= `C_OFFSET(7)  && x < `C_OFFSET(8)  && y >= `ROW2_Y && y < `ROW3_Y) ? v20 :
						  (x >= `C_OFFSET(8)  && x < `C_OFFSET(9)  && y >= `ROW2_Y && y < `ROW3_Y) ? v21 :
						  (x >= `C_OFFSET(9)  && x < `C_OFFSET(10) && y >= `ROW2_Y && y < `ROW3_Y) ? v22 :
						  (x >= `C_OFFSET(10) && x < `C_OFFSET(11) && y >= `ROW2_Y && y < `ROW3_Y) ? v23 :
						  (x >= `C_OFFSET(11) && x < `C_OFFSET(12) && y >= `ROW2_Y && y < `ROW3_Y) ? v24 :
						  (x >= `C_OFFSET(12) && x < `C_OFFSET(13) && y >= `ROW2_Y && y < `ROW3_Y) ? v25 :

						  // draw the Morse code characters at y = 115
						  (x >= `M_OFFSET(0) && x < `M_OFFSET(1) && y >= `ROW4_Y && y < `ROW5_Y) ? mor0 :
						  (x >= `M_OFFSET(1) && x < `M_OFFSET(2) && y >= `ROW4_Y && y < `ROW5_Y) ? mor1 :
						  (x >= `M_OFFSET(2) && x < `M_OFFSET(3) && y >= `ROW4_Y && y < `ROW5_Y) ? mor2 :
						  (x >= `M_OFFSET(3) && x < `M_OFFSET(4) && y >= `ROW4_Y && y < `ROW5_Y) ? mor3 :
						  (x >= `M_OFFSET(4) && x < `M_OFFSET(5) && y >= `ROW4_Y && y < `ROW5_Y) ? mor4 :

						  // draw the lines                                              
						  (y >= `LINE_Y && y < `LINE_Y+1) 														  ? 8'd255 :
						  (x >= `HLINE1        && x < `HLINE1+1      && y >= `LINE_Y && y < `END_Y)  ? 8'd255 :
						  (x >= `HLINE2        && x < `HLINE2+1      && y >= `LINE_Y && y < `END_Y)  ? 8'd255 :

						  // draw the input button labels
						  (x >= `L_OFFSET(10'd7,   0) && x < `L_OFFSET(10'd7,   1) && y >= `ROW6_Y && y < `ROW7_Y) ? b0 :
						  (x >= `L_OFFSET(10'd7,   1) && x < `L_OFFSET(10'd7,   2) && y >= `ROW6_Y && y < `ROW7_Y) ? b1 :
						  (x >= `L_OFFSET(10'd7,   2) && x < `L_OFFSET(10'd7,   3) && y >= `ROW6_Y && y < `ROW7_Y) ? b2 :
						  (x >= `L_OFFSET(10'd7,   3) && x < `L_OFFSET(10'd7,   4) && y >= `ROW6_Y && y < `ROW7_Y) ? b3 :
						  (x >= `L_OFFSET(10'd7,   4) && x < `L_OFFSET(10'd7,   5) && y >= `ROW6_Y && y < `ROW7_Y) ? b4 :
						  (x >= `L_OFFSET(10'd196, 0) && x < `L_OFFSET(10'd196, 1) && y >= `ROW6_Y && y < `ROW7_Y) ? b5 :
						  (x >= `L_OFFSET(10'd196, 1) && x < `L_OFFSET(10'd196, 2) && y >= `ROW6_Y && y < `ROW7_Y) ? b6 :
						  (x >= `L_OFFSET(10'd196, 2) && x < `L_OFFSET(10'd196, 3) && y >= `ROW6_Y && y < `ROW7_Y) ? b7 :
						  (x >= `L_OFFSET(10'd342, 0) && x < `L_OFFSET(10'd342, 1) && y >= `ROW6_Y && y < `ROW7_Y) ? b8 :
						  (x >= `L_OFFSET(10'd342, 1) && x < `L_OFFSET(10'd342, 2) && y >= `ROW6_Y && y < `ROW7_Y) ? b9 :
						  (x >= `L_OFFSET(10'd342, 2) && x < `L_OFFSET(10'd342, 3) && y >= `ROW6_Y && y < `ROW7_Y) ? b10 :
						  (x >= `L_OFFSET(10'd342, 3) && x < `L_OFFSET(10'd342, 4) && y >= `ROW6_Y && y < `ROW7_Y) ? b11 :
/*
						  // visual signal for tapping buttons
						  (y > 137 && x < 160  && button == 2'd1) 			  ? 8'd255 :
						  (y > 137 && x >= 161 && x < 320 && button == 2'd2) ? 8'd255 :
						  (y > 137 && x >= 321 && x < 480 && button == 2'd3) ? 8'd255 :
*/  
						  // default
						  bg_blue;
endmodule

`default_nettype wire
