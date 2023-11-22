`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.11.2023 22:05:31
// Design Name: 
// Module Name: csr_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module csr_controller(
  input  logic        clk_i,
  input  logic        rst_i,
  input  logic        trap_i,

  input  logic [ 2:0] opcode_i,

  input  logic [11:0] addr_i,
  input  logic [31:0] pc_i,
  input  logic [31:0] mcause_i,
  input  logic [31:0] rs1_data_i,
  input  logic [31:0] imm_data_i,
  input  logic        write_enable_i,

  output logic [31:0] read_data_o,
  output logic [31:0] mie_o,
  output logic [31:0] mepc_o,
  output logic [31:0] mtvec_o
);

import csr_pkg::*;
logic [31:0] sys_instr;
logic mie_en, mtvec_en, mscratch_en, mepc_en, mcause_en; 
logic [31:0] mie_instr_o, mtvec_instr_o, mscratch_instr_o, mepc_instr_o, mcause_instr_o;
assign mie_o = mie_instr_o;
assign mtvec_o = mtvec_instr_o;
assign mepc_o = mepc_instr_o;


always_comb begin
    case(opcode_i)
        3'b001: sys_instr <= rs1_data_i;
        3'b010: sys_instr <= rs1_data_i | read_data_o;
        3'b011: sys_instr <= ~rs1_data_i & read_data_o;
        3'b101: sys_instr <= imm_data_i;
        3'b110: sys_instr <= imm_data_i | read_data_o;
        3'b111: sys_instr <= ~imm_data_i & read_data_o;
//        default: sys_instr <= 32'bx;
    endcase
end


always_comb begin
    mie_en <= 0;
    mtvec_en <= 0;
    mscratch_en <= 0;
    mepc_en <= 0;
    mcause_en <= 0; 
    case(addr_i)
        MIE_ADDR:       mie_en <= write_enable_i;
        MTVEC_ADDR:     mtvec_en <= write_enable_i;
        MSCRATCH_ADDR:  mscratch_en <= write_enable_i;
        MEPC_ADDR:      mepc_en <= write_enable_i;
        MCAUSE_ADDR:    mcause_en <= write_enable_i; 
//        default: mie_en = 1'bx;
    endcase
end


always_comb begin
    case(addr_i)
        MIE_ADDR:       read_data_o <= mie_instr_o;
        MTVEC_ADDR:     read_data_o <= mtvec_instr_o;
        MSCRATCH_ADDR:  read_data_o <= mscratch_instr_o;
        MEPC_ADDR:      read_data_o <= mepc_instr_o;
        MCAUSE_ADDR:    read_data_o <= mcause_instr_o;
    endcase
end

always_ff @(posedge clk_i, posedge rst_i) begin
    if(rst_i) begin
         if(mie_en)             mie_instr_o <= 32'b0;
         if(mtvec_en)           mtvec_instr_o <= 32'b0;
         if(mscratch_en)        mscratch_instr_o <= 32'b0;
         if(mepc_en || trap_i)  mepc_instr_o <= 32'b0;
         if(mcause_en || trap_i) mcause_instr_o <= 32'b0;
    end else begin
        mie_instr_o <= sys_instr;
        mtvec_instr_o <= sys_instr;
        mscratch_instr_o <= sys_instr;
        mepc_instr_o <= trap_i == 1 ? pc_i : sys_instr;
        mcause_instr_o <= trap_i == 1 ? mcause_i : sys_instr;
    end
end


endmodule