`timescale 1ns / 1ps
`default_nettype none

`define TOUCH_CLK_DIV_COUNT 25

// Maybe useful defines
`define TOUCH_X_ADJ_MIN 12'h090
`define TOUCH_X_POST_ADJ_MAX 12'h745

`define TOUCH_Y_ADJ_MIN 12'h060
`define TOUCH_Y_POST_ADJ_MAX 12'h6F0

// Important!  The data_in pin here corresponds to the spi_data_out pin on the lab handout.
// Likewise, the spi_data_in pin on the handout corresponds to the data_out port here!
// The spi_* signals are named from the point of view of the touchpad itself, whereas the signals
// here are named from the point of view of the module. That is to say, data_out here is what the module
// is sending, data_in is what the module is receiving.

module touchpad_controller(
	input wire cclk, rstb,
	input wire touch_busy,data_in,
	output reg touch_clk, data_out,
	output reg touch_csb,
	output wire [11:0] x,y,z,
	wire zThreshold
);

reg [4:0] clk_div_counter;

reg [4:0] counter;
reg [4:0] counter2;
reg [4:0] xSampleCount;
reg [4:0] ySampleCount;
reg [4:0] zSampleCount;

reg [11:0] tmp_x;
reg [11:0] tmp_y;
reg [11:0] tmp_z;

reg [12:0] sampled_x, sampled_y, sampled_z;
//wire zThreshold;
reg enax, enay, enaz;

averager z_avg(.cclk(cclk), .rstb(rstb), .ena(enaz), .raw(sampled_z), .averaged(z)); 
averager y_avg(.cclk(cclk), .rstb(rstb), .ena(enay), .raw(sampled_y), .averaged(y)); 
averager x_avg(.cclk(cclk), .rstb(rstb), .ena(enax), .raw(sampled_x), .averaged(x)); 

assign zThreshold = (z[11] == 1) || (z[10] == 1) || (z[9] == 1) || (z[8] == 1);

always @(posedge cclk) begin
	if(~rstb) begin
		touch_clk <= 0;
		clk_div_counter <= 0;
		counter <= 0;
		counter2 <= 0;
		tmp_x <= 925;
		tmp_y <= 887;
		tmp_z <= 0;
		sampled_z <= 0;
		sampled_y <= 0;
		sampled_x <= 0;
		data_out <= 0;
		enax <= 0; 
		enay <= 0; 
		enaz <= 0; 

	end
	else begin
		touch_csb <= 0;
		if(clk_div_counter != (`TOUCH_CLK_DIV_COUNT-1)) begin
			clk_div_counter <= clk_div_counter + 6'd1;
		end
		else begin
			clk_div_counter <= 0;
			touch_clk <= ~touch_clk;
			if(touch_clk) begin  //negative edge logic
			
				// We send the z address 8 times before we sample
				if (counter2 <= 6) begin
					enay <= 0; 

					if (counter == 19) begin
						data_out <= 0;
						counter <= 0;
						tmp_z[0] <= data_in;
						counter2 <= counter2 + 1;
					end					
					if (counter > 7) begin
						data_out <= 0;
						tmp_z[19-counter+1] <= data_in;
					end
					else if (counter == 0) begin
						data_out <= 1;	
					end
					else if (counter == 1) begin
						data_out <= 0;
					end
					else if (counter == 2) begin
						data_out <= 1;
					end
					else if (counter == 3) begin
						data_out <= 1;
					end
					else if (counter == 4) begin
						data_out <= 0;
					end
					else if (counter == 5) begin
						data_out <= 0;
					end
					else if (counter == 6) begin
						data_out <= 1;
					end
					else if (counter == 7) begin
						data_out <= 1;
					end
					counter <= counter + 1;
				end
				
				// on 8th iteration sample z by adding it to our sum
				else if (counter2 == 7) begin
					
					//sampled_Z <= (tmp_z[11] == 1) || (tmp_z[10] == 1) || (tmp_z[9] == 1) || (tmp_z[8] == 1)|| (tmp_z[7] == 1);
					sampled_z <= tmp_z;

					enaz <=1; 
					counter2 <= counter2+1;
					
				end			
	
				// send x address 8 times before sampling
				else if (counter2 <= 14) begin
					enaz <= 0; 

					if (counter == 19) begin
						data_out <= 0;
						counter <= 0;
						tmp_x[0] <= data_in;
						counter2 <= counter2 + 1;
					end					
					if (counter > 7) begin
						data_out <= 0;
						tmp_x[19-counter+1] <= data_in;
					end
					else if (counter == 0) begin
						data_out <= 1;	
					end
					else if (counter == 1) begin
						data_out <= 1;
					end
					else if (counter == 2) begin
						data_out <= 0;
					end
					else if (counter == 3) begin
						data_out <= 1;
					end
					else if (counter == 4) begin
						data_out <= 0;
					end
					else if (counter == 5) begin
						data_out <= 0;
					end
					else if (counter == 6) begin
						data_out <= 1;
					end
					else if (counter == 7) begin
						data_out <= 1;
					end
					counter <= counter + 1;
					
				end
				
				// on 8th iteration sample x
				else if (counter2 == 15) begin
				
					if (zThreshold > 0) begin
						sampled_x <= ((tmp_x - 145) >> 2) + 25;
						enax <=1; 
						
						// assign z here so it doesn't get assigned in same place where threshold changes
					end
					
					counter2 <= counter2 + 1;
					
				end
				
				// request y 7 times before you sample
				else if (counter2 <= 22) begin
					enax <= 0; 

					if (counter == 19) begin
						data_out <= 0;
						counter <= 0;
						tmp_y[0] <= data_in;
						counter2 <= counter2 + 1;
					end					
					if (counter > 7) begin
						data_out <= 0;
						tmp_y[19-counter+1] <= data_in;
					end
					else if (counter == 0) begin
						data_out <= 1;	
					end
					else if (counter == 1) begin
						data_out <= 0;
					end
					else if (counter == 2) begin
						data_out <= 0;
					end
					else if (counter == 3) begin
						data_out <= 1;
					end
					else if (counter == 4) begin
						data_out <= 0;
					end
					else if (counter == 5) begin
						data_out <= 0;
					end
					else if (counter == 6) begin
						data_out <= 1;
					end
					else if (counter == 7) begin
						data_out <= 1;
					end
					counter <= counter + 1;
				end
				
				// on 16th iteration set y
				else if (counter2 == 23) begin
					if (zThreshold > 0) begin
						sampled_y <=((tmp_y - 95) >> 3) + 20;
						enay <= 1; 
					end
					counter2 <= 0;
				end
			end
		end
	end
end

endmodule
`default_nettype wire