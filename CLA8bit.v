`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:41:48 11/07/2014 
// Design Name: 
// Module Name:    CLA8bit 
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
module CLA8bit (in1,in2,sum,cin,cout);
input [7:0] in1,in2;
input cin;
output [7:0] sum;
output cout;

wire cnxt;


CLA_N_bit #4 nbit_cla_inst3to0 (.in1(in1[3:0]),.in2(in2[3:0]),.sum(sum[3:0]),.cin(cin),.cout(cnxt));

CLA_N_bit #4 nbit_cla_inst7to4 (.in1(in1[7:4]),.in2(in2[7:4]),.sum(sum[7:4]),.cin(cnxt),.cout(cout));

endmodule

