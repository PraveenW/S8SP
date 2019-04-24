`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:45:15 10/26/2014 
// Design Name: 
// Module Name:    program_cnt_reg 
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
module program_cnt_reg(clk,reset,inc_pr,pr_on_bus,load_ar_2_pr,data_on_pr);
input clk;
input reset;
input inc_pr;
input load_ar_2_pr;
input [7:0] data_on_pr;
output [7:0] pr_on_bus;
reg [7:0] pr_on_bus;

always @(posedge clk)
begin : PR_Block
	if (reset)
		pr_on_bus <= 8'd0;
	else 
	begin
		if(load_ar_2_pr)
			pr_on_bus <= data_on_pr;
		else if( inc_pr)
			pr_on_bus <= pr_on_bus+1;
	end
end

endmodule
