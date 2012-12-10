`timescale 1ns / 1ps
`default_nettype none

`define BUFFERSTART 10000000
`define BUFFEREND 10000000

//////////////////////////////////////////////////////////////////////////////////
// 
// Module Name:    Touch 
// Description: 
//
//////////////////////////////////////////////////////////////////////////////////
module Touch(
	input wire cclk, rstb, 
	input wire z, 
	input wire [11:0] x, y,
	output reg tap, send, space
); 

// have a buffer in case z dips below the threshold when you are touching the screen
reg [31:0] buffer_start; 
reg [31:0] buffer_end; 

always @(posedge cclk) begin	
	if(~rstb) begin
	 buffer_start <= 0; 
	 buffer_end <= 0; 
	 tap <= 0;
	 send <= 0;
	 space <= 0; 
	end
	else if (z) begin 
		// if screen sending a touch signal for > BUFFERSTART cycles then
		// set touch booleans
		buffer_end <= 0;
		if (buffer_start < `BUFFERSTART) begin
			buffer_start <= buffer_start + 1;
		end
		else begin
			if (y > 136) begin
				if ( x >= 0 && x < 160) begin
					space <= 1; 
					tap <= 0; 
					send <= 0; 
				end 
				else if ( x >= 160 && x <= 320) begin 
					space <= 0; 
					tap <= 1; 
					send <= 0;
				end
				else if ( x > 320 && x <= 480) begin 
					space <= 0; 
					tap <= 0; 
					send <= 1;
				end
			end
			
			buffer_end <= 0;
			buffer_start <= 0;
			
		end
	end 	
	else if (buffer_end < `BUFFEREND) begin
		buffer_start <= 0;
		buffer_end <= buffer_end + 1; 		
	end
	else begin
		buffer_end <= 0;
		buffer_start <= 0;
		space <= 0; 
		tap <= 0; 
		send <= 0; 
	end
end

endmodule
`default_nettype wire
