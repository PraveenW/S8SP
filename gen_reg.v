`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  San Jose State University
// Engineer:   
// 
// Create Date:    21:33:15 10/26/2014 
// Design Name:    Genral Register Block
// Module Name:    gen_reg 
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
module gen_reg(clk,reset,load_lsb_gr,load_msb_gr,data_on_gr,gr_on_data );
input clk;
input reset;
input load_lsb_gr;
input load_msb_gr;
input [7:0] data_on_gr;
output [7:0] gr_on_data;
reg  [7:0] gr_on_data;

always @(posedge clk)
begin : Genral_Register_Block 
	if( reset)
		gr_on_data <= 8'd0;
	else
	begin
		if(load_lsb_gr && !load_msb_gr)
			gr_on_data[3:0] <= data_on_gr[3:0];
		else if(load_msb_gr && !load_lsb_gr)
			gr_on_data[7:4] <= data_on_gr[3:0];
		else if(load_msb_gr && load_lsb_gr)
			gr_on_data <= data_on_gr;
	end
end

endmodule
