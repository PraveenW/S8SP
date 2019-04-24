`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: San Jose State University
// Engineer: 
// 
// Create Date:    14:22:43 10/27/2014 
// Design Name: 
// Module Name:    alu_block 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: This block needs some more enhancemt. Need to add 4 flag register
//
//////////////////////////////////////////////////////////////////////////////////
module alu_block(reg_in1,reg_in2,sub_nadd,alu_out);
input [7:0] reg_in1;
input [7:0] reg_in2;
input sub_nadd;

output [8:0] alu_out;
//reg [8:0] alu_out;

wire [7:0] xor_out;

genvar i;
generate 
for (i=0; i<8; i=i+1)
begin : SUB_BLOCK
	xor xor_u1 (xor_out[i], reg_in2[i], sub_nadd);
end
endgenerate

CLA8bit cla8bit_u1 (.in1(reg_in1), .in2(xor_out), .sum(alu_out[7:0]), .cin(sub_nadd), .cout(alu_out[8]));

endmodule





/*



module alu_block(reg_in1,reg_in2,clk,reset,add_nsub,alu_out);
input [7:0] reg_in1;
input [7:0] reg_in2;
input clk,reset,add_nsub;
//output [8:0] alu_out_reg;
//reg [8:0] alu_out_reg;
output [8:0] alu_out;
reg [8:0] alu_out;

always @(*)
begin
	if(add_nsub)
		alu_out <= reg_in1 + reg_in2;
	else
		alu_out <= reg_in1 - reg_in2;
end

always @(posedge clk)
begin
	if(reset)
		alu_out_reg <= 9'd0;
	else
		alu_out_reg <= alu_out;
end*/

