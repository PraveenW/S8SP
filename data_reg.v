`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: San Jose State University
// Engineer: 
// 
// Create Date:    21:18:20 10/26/2014 
// Design Name: 
// Module Name:    data_reg 
// Project Name:   S8SP
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
module data_reg(clk,reset,data_on_dr,dr_on_data,load_dr);
input clk;
input reset;
input load_dr;
input [7:0] data_on_dr;
output [7:0] dr_on_data;
reg [7:0] dr_on_data;

always @(posedge clk)
begin: DR_Block
	if(reset)
		dr_on_data <= 8'd0;
	else
	begin
		if(load_dr)
			dr_on_data <= data_on_dr;
	end
end

endmodule
