`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:34:33 10/27/2014 
// Design Name: 
// Module Name:    local_ir_reg 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module local_ir_reg(clk,reset,load_ir,ir_out,data_on_ir);
input clk;
input reset;
input load_ir;
input [7:0] data_on_ir;
output [7:0] ir_out;
reg [7:0] ir_out;

always @(posedge clk)
begin
	if(reset)
		ir_out <= 8'd0;
	else
	begin
		if(load_ir)
			ir_out <= data_on_ir;
	end
end		

endmodule
