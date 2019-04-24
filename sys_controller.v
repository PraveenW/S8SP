`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: San Jose State University
// Engineer: 
// 
// Create Date:    21:49:57 10/27/2014 
// Design Name:    System Controller
// Module Name:    sys_controller 
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
module sys_controller( clk,reset,rd_mem,wr_mem,ctrl_load_ar,ctrl_ar_on_addr,ctrl_ar_2_data,ctrl_load_dr,ctrl_dr_2_data,
ctrl_load_lsb_gr,ctrl_load_msb_gr,ctrl_gr_2_data,ctrl_load_ar_2_pr,ctrl_inc_pr,ctrl_pr_2_data,ctrl_pr_on_addr,ctrl_load_ir,
ctrl_ir_2_data,ctrl_ir_code,ctrl_alu_2_data,ctrl_sub_nadd,ctrl_add_oprnd1_sel,ctrl_add_oprnd2_sel,ctrl_flag_2_data );


//System related signals
input clk;
input reset;
output reg rd_mem;
output reg wr_mem;


//AR related signals
output reg ctrl_load_ar;
output reg ctrl_ar_on_addr;
output reg ctrl_ar_2_data;

//DR related signals
output reg ctrl_load_dr;
output reg ctrl_dr_2_data;

//GR related signals
output reg ctrl_load_lsb_gr;
output reg ctrl_load_msb_gr;
output reg ctrl_gr_2_data;

//PR related signals
output reg ctrl_load_ar_2_pr;
output reg ctrl_inc_pr;
output reg ctrl_pr_2_data;
output reg ctrl_pr_on_addr;

//Internal IR related signals
output reg ctrl_load_ir;
output reg ctrl_ir_2_data;
input [7:0] ctrl_ir_code;

//ALU related signals
output reg ctrl_alu_2_data;
output reg ctrl_sub_nadd;
output reg [1:0] ctrl_add_oprnd1_sel;
output reg [1:0] ctrl_add_oprnd2_sel;

//FLAG related signals
output reg ctrl_flag_2_data;


//State Assignment
parameter RST     = 2'b00;
parameter FETCH   = 2'b01;
parameter DECODE  = 2'b10;
parameter EXECUTE = 2'b11;


//Register Assignment
parameter AR     = 2'b00;
parameter DR     = 2'b01;
parameter GR     = 2'b10;
parameter PR     = 2'b11;

//Instruction opcodes
parameter NOP  = 4'b0000;
parameter JMP  = 4'b0001;
parameter RDM  = 4'b0010;
parameter WRM  = 4'b0011;
parameter CPR  = 4'b0100;
parameter ADD  = 4'b0101;
parameter SUB  = 4'b0110;
parameter LLS  = 4'b0111;
parameter LMS  = 4'b1000;
parameter CFR  = 4'b1001;


reg [1:0] present_state;
reg [1:0] next_state;

always @(posedge clk)
begin
	if(reset)
	present_state <= 2'b00;
	else
	present_state <= next_state;
end


always @(present_state or reset or ctrl_ir_code)
begin

rd_mem = 0;
wr_mem = 0;

ctrl_load_ar = 0;
ctrl_ar_on_addr = 0;
ctrl_ar_2_data = 0;

ctrl_load_dr = 0;
ctrl_dr_2_data = 0;

ctrl_load_lsb_gr = 0;
ctrl_load_msb_gr = 0;
ctrl_gr_2_data = 0;


ctrl_load_ar_2_pr = 0;
ctrl_inc_pr = 0;
ctrl_pr_2_data = 0;
ctrl_pr_on_addr = 0;

ctrl_load_ir = 0;
ctrl_ir_2_data = 0;
//ctrl_ir_code,


ctrl_alu_2_data = 0;
ctrl_sub_nadd = 0;
ctrl_add_oprnd1_sel = 2'b01;
ctrl_add_oprnd2_sel = 2'b10;

ctrl_flag_2_data = 0;

case (present_state)
RST : begin 
			next_state = reset? RST : FETCH;
		end

FETCH : begin 
		    next_state = DECODE;
			 rd_mem = 1; 
          ctrl_pr_on_addr = 1;
			 ctrl_load_ir = 1;
			 ctrl_inc_pr = 1;
		  end
		  
DECODE : begin 
				next_state = EXECUTE;
			end


EXECUTE : begin 
				next_state = FETCH;
				
				case (ctrl_ir_code [7:4]) //synopsys full_case
             NOP : ;
				 
				 JMP : begin 
							ctrl_load_ar_2_pr = 1;
							ctrl_ar_2_data = 1;
						 end
				 
				  RDM : begin 
                      rd_mem = 1;
							 ctrl_ar_on_addr = 1;
							 
							 case (ctrl_ir_code [3:2])
								AR : ctrl_load_ar = 1;
								DR : ctrl_load_dr = 1;
								GR : begin ctrl_load_lsb_gr = 1;
							            ctrl_load_msb_gr = 1;
									end
								PR : ctrl_load_ar_2_pr = 1;
							 endcase
							 end
					
					WRM : begin
					         wr_mem = 1;
								ctrl_ar_on_addr = 1;
								
								case (ctrl_ir_code [3:2])
								AR : ctrl_ar_2_data = 1;
								DR : ctrl_dr_2_data = 1;
								GR : ctrl_gr_2_data = 1;
								PR : ctrl_pr_2_data = 1;
							 endcase
							 end
					CPR : begin 
					
					         case (ctrl_ir_code [3:0])
								4'b0000 : ;
								4'b0001 : begin  ctrl_dr_2_data = 1; ctrl_load_ar = 1;  end
								4'b0010 : begin  ctrl_gr_2_data = 1; ctrl_load_ar = 1;  end 
								4'b0011 : begin  ctrl_pr_2_data = 1; ctrl_load_ar = 1;  end
								//---------------------------------------------------------
								4'b0100 : begin  ctrl_ar_2_data = 1; ctrl_load_dr = 1;  end
								4'b0101 : ;
								4'b0110 : begin  ctrl_gr_2_data = 1; ctrl_load_dr = 1;  end
								4'b0111 : begin  ctrl_pr_2_data = 1; ctrl_load_dr = 1;  end
                        //----------------------------------------------------------   
								
								//-----------------------------------------------------------
								4'b1000 : begin ctrl_ar_2_data = 1; ctrl_load_lsb_gr = 1; ctrl_load_msb_gr = 1; end
								4'b1001 : begin ctrl_dr_2_data = 1; ctrl_load_lsb_gr = 1; ctrl_load_msb_gr = 1; end
								4'b1010 : ;
								4'b1011 : begin ctrl_pr_2_data = 1; ctrl_load_lsb_gr = 1; ctrl_load_msb_gr = 1; end
                        //----------------------------------------------------------------
															
								//----------------------------------------------------------------
								4'b1100 : begin ctrl_ar_2_data = 1; ctrl_load_ar_2_pr = 1; end
								4'b1101 : begin ctrl_dr_2_data = 1; ctrl_load_ar_2_pr = 1; end
								4'b1110 : begin ctrl_gr_2_data = 1; ctrl_load_ar_2_pr = 1; end
								4'b1111 :  ; 
                       
							  endcase
								
								
								
								
								
							/*	case (ctrl_ir_code [3:0])
								4'b0000 : ;
								4'b0001 : begin  ctrl_ar_2_data = 1; ctrl_load_dr = 1; end
								4'b0010 : begin  ctrl_ar_2_data = 1; ctrl_load_lsb_gr = 1;
								                 ctrl_load_msb_gr = 1; 
										 end
								4'b0011 : begin  ctrl_ar_2_data = 1; ctrl_load_ar_2_pr = 1; end
								
								4'b0100 : begin  ctrl_dr_2_data = 1; ctrl_load_ar = 1; end
								4'b0101 : ; //begin  ctrl_dr_2_data = 1; ctrl_load_dr = 1; end
								4'b0110 : begin  ctrl_dr_2_data = 1; ctrl_load_lsb_gr = 1;
								                 ctrl_load_msb_gr = 1; 
											 end
								4'b0111 : begin  ctrl_dr_2_data = 1; ctrl_load_ar_2_pr = 1; end

								
								4'b1000 : begin  ctrl_gr_2_data = 1; ctrl_load_ar = 1; end
								4'b1001 : begin  ctrl_gr_2_data = 1; ctrl_load_dr = 1; end
								4'b1010 : ; //begin  ctrl_gr_2_data = 1; ctrl_load_lsb_gr = 1;
								               //  ctrl_load_msb_gr = 1; 
											 //end
								4'b1011 : begin  ctrl_gr_2_data = 1; ctrl_load_ar_2_pr = 1; end
                        
								
								4'b1100 : begin  ctrl_pr_2_data = 1; ctrl_load_ar = 1; end
								4'b1101 : begin  ctrl_pr_2_data = 1; ctrl_load_dr = 1; end
								4'b1110 : begin  ctrl_pr_2_data = 1; ctrl_load_lsb_gr = 1;
								                 ctrl_load_msb_gr = 1; 
											 end
								4'b1111 :  ; //begin  ctrl_gr_2_data = 1; ctrl_load_ar_2_pr = 1; end
                        endcase */
								
								
								
							end
						
					ADD : begin ctrl_sub_nadd = 0;
					            ctrl_add_oprnd1_sel = ctrl_ir_code [3:2];
									ctrl_add_oprnd2_sel = ctrl_ir_code [1:0];
								
								ctrl_alu_2_data = 1;
								case (ctrl_ir_code [3:2])
								AR : ctrl_load_ar = 1;
								DR : ctrl_load_dr = 1;
								GR : begin ctrl_load_lsb_gr = 1;
							              ctrl_load_msb_gr = 1;
									end
								PR : ctrl_load_ar_2_pr = 1;
							 endcase
									
							end
					
					SUB : begin ctrl_sub_nadd = 1; 
					            ctrl_add_oprnd1_sel = ctrl_ir_code [3:2];
									ctrl_add_oprnd2_sel = ctrl_ir_code [1:0];
									
								ctrl_alu_2_data = 1;	
								case (ctrl_ir_code [3:2])
								AR : ctrl_load_ar = 1;
								DR : ctrl_load_dr = 1;
								GR : begin ctrl_load_lsb_gr = 1;
							              ctrl_load_msb_gr = 1;
									end
								PR : ctrl_load_ar_2_pr = 1;
							 endcase
							end
					
					LLS : begin ctrl_ir_2_data = 1; ctrl_load_lsb_gr = 1; end
					
					LMS : begin ctrl_ir_2_data = 1; ctrl_load_msb_gr = 1; end   

               CFR : begin ctrl_flag_2_data = 1; 
					            ctrl_load_lsb_gr = 1; end
									
               default : next_state = RST ;
					
					endcase //endcase of EXECUTE block
               end //end of EXECUTE begin block
					
endcase
end
 				 
endmodule
