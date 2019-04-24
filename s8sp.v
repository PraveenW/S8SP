`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: San Jose State University
// Engineer: 
// 
// Create Date:    02:05:08 10/28/2014 
// Design Name:   Simple 8 bit Scalar Processor
// Module Name:    s8sp 
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
module s8sp(clk,reset,add,dat,wrt,rd );
input clk;
input reset;
output[7:0] add;
inout [7:0] dat;
output wrt;
output rd;

//For AR Connections from Controller to Data_block
wire load_ar;
wire ar_on_addr;
wire ar_2_data;

//For DR Connections from Controller to Data_block
wire load_dr;
wire dr_2_data;

//For GR Connections from Controller to Data_block
wire load_lsb_gr; 
wire load_msb_gr;
wire gr_2_data;

//For PR Connections from Controller to Data_block
wire load_ar_2_pr; 
wire inc_pr;
wire pr_2_data;
wire pr_on_addr;

//For IR Connections from Controller to Data_block
wire load_ir;
wire ir_2_data;
wire [7:0] ir_code;

//For ALU Connections from Controller to Data_block
wire sub_nadd;
wire alu_2_data;
wire [1:0] add_oprnd1_sel;
wire [1:0] add_oprnd2_sel;

//For Flag connections
wire flag_2_data;





data_block u1_data_block_instantiation (
//System Signals
.clk (clk),
.reset (reset),

//System Bus
.data_bus (dat),
.addr_bus (add),

//AR related signals
.load_ar(load_ar),
.ar_on_addr(ar_on_addr),
.ar_2_data(ar_2_data),

//DR related signals
.load_dr(load_dr),
.dr_2_data(dr_2_data),

//GR related signals
.load_lsb_gr(load_lsb_gr),
.load_msb_gr(load_msb_gr),
.gr_2_data(gr_2_data),

//PR related signals
.load_ar_2_pr(load_ar_2_pr),
.inc_pr(inc_pr),
.pr_2_data(pr_2_data),
.pr_on_addr(pr_on_addr),

//Internal IR related signals
.load_ir(load_ir),
.ir_2_data(ir_2_data),
.ir_code(ir_code), //used by controller for decoding instructions

//ALU related signals
.sub_nadd(sub_nadd),
.add_oprnd1_sel(add_oprnd1_sel),
.add_oprnd2_sel(add_oprnd2_sel),
.alu_2_data (alu_2_data),

//FLAG related signals
.flag_2_data (flag_2_data)

);



//--------------------------------------------------------------------------------------

sys_controller u1_sys_controller_inst (

//System related signals
.clk   (clk),
.reset (reset),
.rd_mem (rd),
.wr_mem (wrt),


//AR related signals
.ctrl_load_ar(load_ar),
.ctrl_ar_on_addr(ar_on_addr),
.ctrl_ar_2_data(ar_2_data),

//DR related signals
.ctrl_load_dr(load_dr),
.ctrl_dr_2_data(dr_2_data),

//GR related signals
.ctrl_load_lsb_gr(load_lsb_gr),
.ctrl_load_msb_gr(load_msb_gr),
.ctrl_gr_2_data(gr_2_data),

//PR related signals
.ctrl_load_ar_2_pr(load_ar_2_pr),
.ctrl_inc_pr(inc_pr),
.ctrl_pr_2_data(pr_2_data),
.ctrl_pr_on_addr(pr_on_addr),

//Internal IR related signals
.ctrl_load_ir(load_ir),
.ctrl_ir_2_data(ir_2_data),
.ctrl_ir_code(ir_code),

//ALU related signals
.ctrl_alu_2_data(alu_2_data),
.ctrl_sub_nadd(sub_nadd),
.ctrl_add_oprnd1_sel(add_oprnd1_sel),
.ctrl_add_oprnd2_sel(add_oprnd2_sel),

//FLAG related signals
.ctrl_flag_2_data (flag_2_data)
);

endmodule
