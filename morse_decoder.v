`timescale 1ns / 1ps
`default_nettype none


`define TOUCHBUFFER 100000
`define DASHSPEED 85000000


//////////////////////////////////////////////////////////////////////////////////
// 
// Module Name:    morse_decoder 
// Description: 
//
//////////////////////////////////////////////////////////////////////////////////
module morse_decoder(
	input wire cclk, rstb, 
	input wire tap, space, send,
	input wire done_reading,
	output reg [7:0] red, green, blue,
	output reg [1:0] morseCode,
	output reg [7:0] send_byte,
	output reg send_ena
);

	reg [10:0] state;
	reg [40:0] touch_cycles;
	reg dot, dash;
	reg prev_space, space_reg;
	
	//port definitions
	always @(posedge cclk) begin
		if(~rstb) begin
			morseCode <= 2'd2;
			state <= 0; 
			touch_cycles <= 0;
			dot <= 0;
			dash <= 0;
			send_ena <= 0;
			send_byte <= 0;
			space_reg <= 0;
			prev_space <= 0;
		end
		else begin
			if (prev_space != space) begin
				prev_space <= space;
				space_reg <= space;
			end		
			else if (state == 0) begin
				 if (dot) begin
					  state <= 1;
				 end
				 else if (dash) begin
					  state <= 2;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// E
			else if (state == 1) begin
				 if (dot) begin
					  state <= 3;
				 end
				 else if (dash) begin
					  state <= 4;
				 end
				 else if (space_reg) begin
					  state <= 63;
				 end
				 else if (send) begin
					  send_byte <= 5;
					  state <= 64;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// T
			else if (state == 2) begin
				 if (dot) begin
					  state <= 5;
				 end
				 else if (dash) begin
					  state <= 6;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
					  send_byte <= 20;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// I
			else if (state == 3) begin
				 if (dot) begin
					  state <= 7;
				 end
				 else if (dash) begin
					  state <= 8;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
					  send_byte <= 9;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// A
			else if (state == 4) begin
				 if (dot) begin
					  state <= 9;
				 end
				 else if (dash) begin
					  state <= 10;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
					  send_byte <= 1;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// N
			else if (state == 5) begin
				 if (dot) begin
					  state <= 11;
				 end
				 else if (dash) begin
					  state <= 12;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 14;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// M
			else if (state == 6) begin
				 if (dot) begin
					  state <= 13;
				 end
				 else if (dash) begin
					  state <= 14;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
					  send_byte <= 13;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// S
			else if (state == 7) begin
				 if (dot) begin
					  state <= 15;
				 end
				 else if (dash) begin
					  state <= 16;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 19;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// U
			else if (state == 8) begin
				 if (dot) begin
					  state <= 17;
				 end
				 else if (dash) begin
					  state <= 18;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 21;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// R
			else if (state == 9) begin
				 if (dot) begin
					  state <= 19;
				 end
				 else if (dash) begin
					  state <= 20;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
					  send_byte <= 18;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// W
			else if (state == 10) begin
				 if (dot) begin
					  state <= 21;
				 end
				 else if (dash) begin
					  state <= 22;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 23;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// D
			else if (state == 11) begin
				 if (dot) begin
					  state <= 23;
				 end
				 else if (dash) begin
					  state <= 24;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
					  send_byte <= 4;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// K
			else if (state == 12) begin
				 if (dot) begin
					  state <= 25;
				 end
				 else if (dash) begin
					  state <= 26;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 11;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// G
			else if (state == 13) begin
				 if (dot) begin
					  state <= 27;
				 end
				 else if (dash) begin
					  state <= 28;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 7;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// O
			else if (state == 14) begin
				 if (dot) begin
					  state <= 29;
				 end
				 else if (dash) begin
					  state <= 30;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 15;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// H
			else if (state == 15) begin
				 if (dot) begin
					  state <= 31;
				 end
				 else if (dash) begin
					  state <= 32;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 8;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// V
			else if (state == 16) begin
				 if (dot) begin
					  state <= 33;
				 end
				 else if (dash) begin
					  state <= 34;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 22;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// F
			else if (state == 17) begin
				 if (dot) begin
					  state <= 35;
				 end
				 else if (dash) begin
					  state <= 36;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 6;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// BLANK
			else if (state == 18) begin
				 if (dot) begin
					  state <= 37;
				 end
				 else if (dash) begin
					  state <= 38;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// L
			else if (state == 19) begin
				 if (dot) begin
					  state <= 39;
				 end
				 else if (dash) begin
					  state <= 40;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 12;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// BLANK
			else if (state == 20) begin
				 if (dot) begin
					  state <= 41;
				 end
				 else if (dash) begin
					  state <= 42;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// P
			else if (state == 21) begin
				 if (dot) begin
					  state <= 43;
				 end
				 else if (dash) begin
					  state <= 44;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 16;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// J
			else if (state == 22) begin
				 if (dot) begin
					  state <= 45;
				 end
				 else if (dash) begin
					  state <= 46;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 10;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// B
			else if (state == 23) begin
				 if (dot) begin
					  state <= 47;
				 end
				 else if (dash) begin
					  state <= 48;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 2;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// X
			else if (state == 24) begin
				 if (dot) begin
					  state <= 49;
				 end
				 else if (dash) begin
					  state <= 50;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 24;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// C
			else if (state == 25) begin
				 if (dot) begin
					  state <= 51;
				 end
				 else if (dash) begin
					  state <= 52;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 3;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// Y
			else if (state == 26) begin
				 if (dot) begin
					  state <= 53;
				 end
				 else if (dash) begin
					  state <= 54;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 25;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// Z
			else if (state == 27) begin
				 if (dot) begin
					  state <= 55;
				 end
				 else if (dash) begin
					  state <= 56;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 26;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// Q
			else if (state == 28) begin
				 if (dot) begin
					  state <= 57;
				 end
				 else if (dash) begin
					  state <= 58;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 17;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// BLANK
			else if (state == 29) begin
				 if (dot) begin
					  state <= 59;
				 end
				 else if (dash) begin
					  state <= 60;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// BLANK
			else if (state == 30) begin
				 if (dot) begin
					  state <= 61;
				 end
				 else if (dash) begin
					  state <= 62;
				 end
				 else if (space_reg) begin
					  state <= 63 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// 5
			else if (state == 31) begin
				 if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 32;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// 4
			else if (state == 32) begin
				 if (space_reg) begin
					  state <= 63 ;
				 end
				 if (send) begin
				     send_byte <= 31;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// 3
			else if (state == 34) begin
				 if (space_reg) begin
					  state <= 63 ;
				 end
				 if (send) begin
				     send_byte <= 30;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// 2
			else if (state == 38) begin
				 if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 29;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// +
			else if (state == 41) begin
				 if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 37;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// 1
			else if (state == 46) begin
				 if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 28;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// 6
			else if (state == 47) begin
				 if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 33;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// =
			else if (state == 48) begin
				 if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 38;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// /
			else if (state == 49) begin
				 if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 39;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// 7
			else if (state == 55) begin
				 if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 34;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// 8
			else if (state == 59) begin
				 if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 35;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// 9
			else if (state == 61) begin
				 if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 36;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
			end

			// 0
			else if (state == 62) begin
				 if (space_reg) begin
					  state <= 63 ;
				 end
				 else if (send) begin
				     send_byte <= 37;
					  state <= 64 ;
				 end
				 dash<= 0;
				 dot <= 0;
				 state <= 0;
			end

			// space_reg
			else if (state == 63) begin
			    send_byte <= 27;	 
				 state <= 64;
				 space_reg <= 0;
			end

			// SEND
			else if (state == 64) begin
				send_ena <= 1;
				state <= 65;
			end
			else if (state == 65) begin
				if (done_reading) begin
					// handle send case
					dash<= 0;
					dot <= 0;
					state <= 0;
					send_ena <= 0;
					space_reg <= 0;
				end		
			end
				
			
			// count cycles but watch out for overflow
			if (tap) begin
				touch_cycles <= touch_cycles +1;
			end
			// eliminate noise, if there was a 10000 cycle blip, ignore
			else if (touch_cycles > `TOUCHBUFFER) begin
				// if held down for 100000000 cycles then its a dash
				if (touch_cycles > `DASHSPEED) begin
					dash <= 1;
				end
				else begin
					dot <= 1;
				end
				touch_cycles <= 0;
			end
			else begin
				touch_cycles <= 0;
			end
			/*
			if (touch_cycles > 10000000 && touch_cycles < 100000000) begin
				red <= 153;
				green <= 204;
				blue <= 50;
			end
			*/
			
			// A
			if (state == 4) begin
				red <= 'hff;
				green <= 'h0;
				blue <= 'h0;
			end
			
			// B
			else if (state == 23) begin
				red <= 'hff;
				green <= 'h80;
				blue <= 'h0;
			end
			
			// C
			else if (state == 25) begin
				red <= 'hff;
				green <= 'hff;
				blue <= 'h0;
			end
			
			// D
			else if (state == 11) begin
				red <= 'h80;
				green <= 'hff;
				blue <= 'h0;
			end
			
			// E
			else if (state == 1) begin
				red <= 'h00;
				green <= 'hff;
				blue <= 'h0;
			end
			
			// F
			else if (state == 17) begin
				red <= 'h00;
				green <= 'hff;
				blue <= 'h80;
			end

			// G
			else if (state == 13) begin
				red <= 'h0;
				green <= 'hff;
				blue <= 'hff;
			end
			
			// H
			else if (state == 15) begin
				red <= 'h00;
				green <= 'h80;
				blue <= 'hff;
			end
			
			// I
			else if (state == 3) begin
				red <= 'h00;
				green <= 'h00;
				blue <= 'hff;
			end	

			// J
			else if (state == 22) begin
				red <= 'h80;
				green <= 'h00;
				blue <= 'hff;
			end
			
			// K
			else if (state == 12) begin
				red <= 'hff;
				green <= 'h00;
				blue <= 'hff;
			end
			
			// L
			else if (state == 19) begin
				red <= 'hff;
				green <= 'h00;
				blue <= 'h80;
			end		
			
			// M
			else if (state == 6) begin
				red <= 'hFF;
				green <= 'h45;
				blue <= 'h0;
			end
			
			// N
			else if (state == 5) begin
				red <= 'hE3;
				green <= 'hCF;
				blue <= 'h57;
			end

			// O
			else if (state == 14) begin
				red <= 'hFF;
				green <= 'hF8;
				blue <= 'hDC;
			end
			
			// P
			else if (state == 21) begin
				red <= 'h9C;
				green <= 'h66;
				blue <= 'h1F;
			end
			
			// Q
			else if (state == 28) begin
				red <= 'hFF;
				green <= 'hD3;
				blue <= 'h9B;
			end	

			// R
			else if (state == 9) begin
				red <= 'hEE;
				green <= 'hB4;
				blue <= 'hB4;
			end
			
			// T
			else if (state == 2) begin
				red <= 'hDC;
				green <= 'hDC;
				blue <= 'hDC;
			end
			
			// U
			else if (state == 8) begin
				red <= 'hFF;
				green <= 'hBB;
				blue <= 'hFF;
			end				

			// V
			else if (state == 16) begin
				red <= 'hDC;
				green <= 'h14;
				blue <= 'h3C;
			end
			
			// W
			else if (state == 10) begin
				red <= 'hFF;
				green <= 'hF0;
				blue <= 'hF5;
			end
			
			// X
			else if (state == 24) begin
				red <= 'hFF;
				green <= 'h3E;
				blue <= 'h96;
			end		
			
			// Y
			else if (state == 26) begin
				red <= 'h1E;
				green <= 'h90;
				blue <= 'hFF;
			end
			
			// Z
			else if (state == 27) begin
				red <= 'h3D;
				green <= 'h91;
				blue <= 'h40;
			end

			// 1
			else if (state == 46) begin
				red <= 'hBD;
				green <= 'hFC;
				blue <= 'hC9;
			end
			
			// 2
			else if (state == 38) begin
				red <= 'hCA;
				green <= 'hFF;
				blue <= 'h70;
			end
			
			// 3
			else if (state == 34) begin
				red <= 'hFF;
				green <= 'hFF;
				blue <= 'hF0;
			end	

			// 4
			else if (state == 32) begin
				red <= 'h80;
				green <= 'h80;
				blue <= 'h69;
			end
			
			// 5
			else if (state == 31) begin
				red <= 'hFF;
				green <= 'hD7;
				blue <= 'h00;
			end
			
			// 6
			else if (state == 47) begin
				red <= 'hFF;
				green <= 'hEF;
				blue <= 'hD5;
			end	

			// 7
			else if (state == 55) begin
				red <= 'h71;
				green <= 'h71;
				blue <= 'hC6;
			end
			
			// 8
			else if (state == 59) begin
				red <= 'hA8;
				green <= 'hFF;
				blue <= 'hFF;
			end
			
			// 9
			else if (state == 61) begin
				red <= 'hD4;
				green <= 'hFF;
				blue <= 'hA8;
			end	

			// 0
			else if (state == 62) begin
				red <= 'hFF;
				green <= 'hA8;
				blue <= 'hD4;
			end
			
			else begin
				red <= 0;
				green <= 0;
				blue <= 0;
			end
		end
	end
endmodule
`default_nettype wire
