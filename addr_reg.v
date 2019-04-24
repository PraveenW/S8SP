`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: San Jose State University
// Engineer: 
// 
// Create Date:    00:18:50 10/27/2014 
// Design Name: Address_Register Block
// Module Name:    addr_reg 
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
module addr_reg(clk,reset,data_on_ar,ar_on_bus,load_ar);
input clk;
input reset;
input load_ar;
input [7:0] data_on_ar;
output [7:0] ar_on_bus;
reg [7:0] ar_on_bus;

always @(posedge clk)
begin
	if(reset)
		ar_on_bus <= 8'd0;
	else
	begin
		if(load_ar)
			ar_on_bus <= data_on_ar;
	end
end

endmodule
