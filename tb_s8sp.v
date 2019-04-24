`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   03:28:58 11/03/2014
// Design Name:   s8sp
// Module Name:   D:/xilinx_location/S8SP/tb_s8sp.v
// Project Name:  S8SP
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: s8sp
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`define clk_period_by2 10
module tb_s8sp;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire [7:0] add;
	wire wrt;
	wire rd;

	// Bidirs
	wire [7:0] dat;
	
	reg [7:0] out_data;
	
	reg [7:0] mem [0:255];
	
	
	// Instantiate the Unit Under Test (UUT)
	s8sp uut (
		.clk(clk), 
		.reset(reset), 
		.add(add), 
		.dat(dat), 
		.wrt(wrt), 
		.rd(rd)
	);


//Memory Initialisation
	
	initial 
		begin
			$readmemh ( "mem.txt", mem, 8'h00, 8'hff );
		end
		
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		end
		
// Wait 100 ns for global reset to finish
//	#100;
// Add stimulus here

	always # `clk_period_by2 clk = ~clk;
	
	initial begin 
	#40 reset = 0;
	end
	
	
	// Read memory block
	always @(rd,wrt,add)
	begin 
		if(rd && !wrt)
		out_data = mem[add];
	end
	
	//Write memory block
	always @(rd,wrt,add)
	begin 
		if( !rd && wrt)
		mem[add] = dat;
	end
	
assign dat = rd ? out_data : 8'bzzzz_zzzz;

initial begin 
$dumpfile("s8sp_wave.vcd");
$dumpvars(0,uut);
end

initial #4000 $finish;

///tb_s8sp/uut/u1_data_block_instantiation/pr_on_bus
///tb_s8sp/uut/u1_data_block_instantiation/u1_pr_instance/pr_on_bus

initial 
begin
 #3610 force uut.u1_data_block_instantiation.u1_pr_instance.pr_on_bus = 8'd32;
 //#3670 release uut.u1_data_block_instantiation.u1_pr_instance.pr_on_bus;
 #60 release uut.u1_data_block_instantiation.u1_pr_instance.pr_on_bus;
end

endmodule

