`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:52:55 12/06/2012
// Design Name:   CharReceiver
// Module Name:   C:/Documents and Settings/student/Desktop/lat3-submission/visual2test/visual2/ReceiverTestbench.v
// Project Name:  visual2
// Target Device:  
// Tool versions:  
// Description:   Tests CharReceiver module.
//
// Alternate sending bytes of values 1 - 7, corresponding to English 
// characters 'A' - 'G'. This testbench does not naively increment byte values
// to receive, but instead changes the byte values based on two counters which
// wrap around 2 and 3 respectively, both of which correspond to bits 1 and 2
// respectively as well.
//
// Verilog Test Fixture created by ISE for module: CharReceiver
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ReceiverTestbench;

	// Inputs
	reg cclk;
	reg rstb;
	reg inputCharBit;

	// Outputs
	wire [7:0] char0, char1, char2, char3, char4, char5, char6, char7, char8, char9, char10, char11, char12;
	wire [7:0] char13, char14, char15, char16, char17, char18, char19, char20, char21, char22, char23, char24, char25;
	
	reg on1, on2;
	reg [3:0] counter;

	// Instantiate the Unit Under Test (UUT)
	CharReceiver uut (
		.cclk(cclk), 
		.rstb(rstb), 
		.inputCharBit(inputCharBit), 
		.char0(char0), 
		.char1(char1), 
		.char2(char2), 
		.char3(char3), 
		.char4(char4), 
		.char5(char5), 
		.char6(char6), 
		.char7(char7), 
		.char8(char8), 
		.char9(char9), 
		.char10(char10), 
		.char11(char11),
		.char12(char12), 
		.char13(char13), 
		.char14(char14), 
		.char15(char15), 
		.char16(char16), 
		.char17(char17), 
		.char18(char18), 
		.char19(char19), 
		.char20(char20), 
		.char21(char21), 
		.char22(char22), 
		.char23(char23),
		.char24(char24), 
		.char25(char25)
	);
	
	always #5 cclk = ~cclk;

	initial begin
		// Initialize Inputs
		cclk = 0;
		rstb = 0;
		inputCharBit = 1;
		on1 = 1; // used for varying bit 1 (0-indexed)
		on2 = 1; // used for varying bit 2
		counter = 0;

		// Wait 10 ns for global reset to finish
		#10;		
		rstb = 1;
		#50;

		repeat (100) begin
			inputCharBit = 0;             // start bit
			#10;
			inputCharBit = 1;             // bit 0
			#10;
			inputCharBit = (on1) ? 0 : 1; // bit 1
			#10;
			inputCharBit = (on2) ? 0 : 1; // bit 2
			#10;
			inputCharBit = 0;             // bits 3 - 7
			#50;
			inputCharBit = 1;             // end bit
			#1000;
			counter = counter + 1;
			on1 = (counter % 2) ? 0 : 1;
			on2 = (counter % 3) ? 0 : 1;
		end

	end
      
endmodule

