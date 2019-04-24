`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: San Jose State University
// Engineer: 
// 
// Create Date:    13:57:22 10/26/2014 
// Design Name:     
// Module Name:    data_block 
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
module data_block(clk,reset,data_bus,addr_bus,load_ar,ar_on_addr,ar_2_data,load_dr,dr_2_data,
load_lsb_gr,load_msb_gr,gr_2_data,load_ar_2_pr,inc_pr,pr_2_data,pr_on_addr,load_ir,ir_2_data,
ir_code,sub_nadd,add_oprnd1_sel,add_oprnd2_sel,alu_2_data,flag_2_data);

//System Bus
inout [7:0] data_bus;
output [7:0] addr_bus;


//System Signals
input clk;
input reset;

//AR related signals
input load_ar;
input ar_on_addr;
input ar_2_data;

//DR related signals
input load_dr;
input dr_2_data;

//GR related signals
input load_lsb_gr;
input load_msb_gr;
input gr_2_data;

//PR related signals
input load_ar_2_pr;
input inc_pr;
input pr_2_data;
input pr_on_addr;

//Internal IR related signals
input load_ir;
input ir_2_data;
output [7:0] ir_code; //used by controller for decoding instructions

//ALU related signals
input sub_nadd;
input [1:0] add_oprnd1_sel;
input [1:0] add_oprnd2_sel;
input alu_2_data;

//Flag_reg related signals
input flag_2_data;
 
wire [7:0] pr_on_bus;
wire [7:0] dr_on_data;
wire [7:0] gr_on_data;
wire [7:0] ar_on_bus;
wire [8:0] alu_out;
wire [7:0] ir_out;
wire [3:0] flag_on_data;

reg [7:0] mux_out1;
reg [7:0] mux_out2;


program_cnt_reg u1_pr_instance (
                                .clk               (clk),
										  .reset             (reset),
										  .inc_pr            (inc_pr),
										  .pr_on_bus         (pr_on_bus),
										  .load_ar_2_pr      (load_ar_2_pr),
										  .data_on_pr        (data_bus)
										  );


data_reg u1_dr_instance (
                         .clk                 (clk),
								 .reset               (reset),
								 .data_on_dr          (data_bus),
								 .dr_on_data          (dr_on_data),
								 .load_dr             (load_dr)
								 );




gen_reg  u1_gr_instance (
                         .clk                  (clk),
								 .reset                (reset),
								 .load_lsb_gr          (load_lsb_gr),
								 .load_msb_gr          (load_msb_gr),
								 .data_on_gr           (data_bus),
								 .gr_on_data           (gr_on_data)
								 );



addr_reg  u1_ar_instance (
                          .clk                 (clk),
								  .reset					  (reset),
								  .data_on_ar          (data_bus),
								  .ar_on_bus           (ar_on_bus),
								  .load_ar             (load_ar)
								 );


local_ir_reg u1_ir_instance (
									  .clk              (clk),
									  .reset            (reset),
									  .load_ir          (load_ir),
									  .ir_out           (ir_out),
									  .data_on_ir       (data_bus)
									  );




alu_block  u1_alu_instance (
                            .reg_in1           (mux_out1),
									 .reg_in2           (mux_out2),
									 //.clk               (clk),
									 //.reset             (reset),
									 .sub_nadd          (sub_nadd),
									 .alu_out           (alu_out)
									 );


flag_reg u1_flag_reg_instance (
                           .clk                (clk),
									.reset              (reset),
									.alu_2_data         (alu_2_data),
									.alu_data           (alu_out),
									.flag_reg           (flag_on_data)
								  );



									 
									 
always @(*)
begin : mux_block1
	case (add_oprnd1_sel)
		2'b00 : mux_out1 = ar_on_bus;
		2'b01 : mux_out1 = dr_on_data;
		2'b10 : mux_out1 = gr_on_data;
		2'b11 : mux_out1 = pr_on_bus;
	endcase
end
									 
always @(*)
begin : mux_block2
	case (add_oprnd2_sel)
		2'b00 : mux_out2 = ar_on_bus;
		2'b01 : mux_out2 = dr_on_data;
		2'b10 : mux_out2 = gr_on_data;
		2'b11 : mux_out2 = pr_on_bus;
	endcase
end


assign addr_bus = ar_on_addr ? ar_on_bus : 8'bzzzz_zzzz;
assign addr_bus = pr_on_addr ? pr_on_bus : 8'bzzzz_zzzz;

assign data_bus = pr_2_data ? pr_on_bus  : 8'bzzzz_zzzz;
assign data_bus = dr_2_data ? dr_on_data : 8'bzzzz_zzzz;
assign data_bus = gr_2_data ? gr_on_data : 8'bzzzz_zzzz;
assign data_bus = ar_2_data ? ar_on_bus  : 8'bzzzz_zzzz;
assign data_bus = alu_2_data ? alu_out[7:0]   : 8'bzzzz_zzzz; 
assign data_bus = flag_2_data ?{4'b0000,flag_on_data} : 8'bzzzz_zzzz;

assign data_bus = ir_2_data ? ir_out : 8'bzzzz_zzzz;
assign ir_code = ir_out;

endmodule
