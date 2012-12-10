`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// 
// Module Name:    PWM 
// Description: 
//
//////////////////////////////////////////////////////////////////////////////////
module pwm_module(cclk, rstb, duty_cycle, base_frequency, pwm_out);
	 
	 //define inputs
    input wire cclk, rstb; //all fsms will have clock and reset
    input wire [7:0] duty_cycle, base_frequency; //the input that determines how often the pulse will happen (lower is more frequent)
    output wire pwm_out;
     
    reg [7:0] frequency_count; //counts every clock cycle
	 reg [7:0] cycle_count;  	//counts how often the clock cycles reach the frequency 
     
    //pulse is an output of the FSM, so make sure to drive it outside of the always block!
    //only transitional logic and flip flop related statements should go inside always blocks
    assign pwm_out = (cycle_count < duty_cycle);  //this creates an equals combinational logic structure for us - this is a bit behavioural, but actually better.
     
    //only the transitional logic goes in the always block
    always @(posedge cclk) begin
        if(~rstb) begin //always take care of the reset first
            frequency_count <= 8'd0;  //reset the count to a known state (zero)
				cycle_count <= 8'd0;
        end
        else begin //out of reset
            //the mux is created by the if statement
            if(frequency_count == base_frequency) begin
					frequency_count <= 8'd0;
					if(cycle_count == 8'd255) begin
						cycle_count <= 8'd0;
					end	
               else begin
						cycle_count <= cycle_count + 8'd1; //be careful to size your constants properly
					end
				end
            else begin
                frequency_count <= frequency_count + 8'd1;  //Xilinx will put a nice combinational adder here for you
            end
        end
    end
endmodule

`default_nettype wire