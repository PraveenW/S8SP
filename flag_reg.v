`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:43:48 11/08/2014 
// Design Name: 
// Module Name:    flag_reg 
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
module flag_reg(clk,reset,alu_2_data,alu_data,flag_reg);
input clk;
input reset;
input alu_2_data;
input [8:0] alu_data;
output [3:0] flag_reg;
reg [3:0] flag_reg;

always @(posedge clk)
begin 
	if(reset)
	flag_reg <= 4'b0000;
	else if(alu_2_data)
	begin
	flag_reg[3] <= ~|alu_data;
	flag_reg[2] <= (alu_data[7]^alu_data[8]);
	flag_reg[1] <= alu_data[8];
	flag_reg[0] <= alu_data[7]^alu_data[8];
	end
	else 
	flag_reg <= flag_reg;
end


endmodule
