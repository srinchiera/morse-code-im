module averager(
	input wire cclk, 
	input wire rstb, 
	input wire ena,
	input wire [11:0] raw,
	output reg [N-1:0] averaged
);

parameter N = 11;
parameter M = 9;

reg [M+N:0] sum; 
reg [M-1:0] counter; 
  

//implement an averager here
// be sure that it only adds to the sum when the ena signal is high
always @(posedge cclk) begin
	if(~rstb) begin
		counter <= 0;
		sum <= 0; 
	end
	else begin
		if (ena) begin 
			if (counter == 0) begin 
				averaged <= sum >> M; //shift 9 because we are taking 512 samples which accounts for 25 clks per touch_clk
				sum <= raw; 
				counter <= counter + 1;
			end
			else begin 
				sum <= sum + raw; 
				counter <= counter + 1; 		
			end
		end	
	end
end



endmodule
`default_nettype wire