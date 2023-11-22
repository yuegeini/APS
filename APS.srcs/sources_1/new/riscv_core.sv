`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2023 23:53:12
// Design Name: 
// Module Name: riscv_core
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


module riscv_core(
        
    //common
    input   logic          clk_i,
    input   logic          rst_i,
    input   logic          stall_i,
    
    //memory
    input   logic  [31:0]  instr_i,//
    input   logic  [31:0]  mem_rd_i,//
    
    output  logic  [31:0]  instr_addr_o,//
    output  logic  [31:0]  data_addr_o,//
    output  logic          mem_we_o, //
    output  logic          mem_req_o,//
    output  logic  [2:0]   mem_size_o, //  
    output  logic  [31:0]  mem_wd_o//

    );
logic [31:0] WD, RD1, RD2, A, B, alu_result;//

logic [31:0] imm_I, imm_S, imm_B, imm_U, imm_J;//
logic [4:0] aluop, RA1, RA2, WA;//
logic flag, rf_we;
logic jal, jalr, branch, illegal_instr, ws, mem_req, mem_we;//

logic [1:0] src_a; //
logic [2:0] src_b, mem_size;//
//MAIN DECODER
decoder_riscv main_decoder(
        .fetched_instr_i  (instr_i        ), //
        .a_sel_o          (src_a          ), //
        .b_sel_o          (src_b          ), //
        .alu_op_o         (aluop          ), 
        .mem_req_o        (mem_req        ), //
        .mem_we_o         (mem_we         ), //
        .mem_size_o       (mem_size       ), //
        .gpr_we_a_o       (rf_we          ), //
        .wb_src_sel_o     (ws             ), //
        .illegal_instr_o  (illegal_instr  ), //
        .branch_o         (branch         ), //
        .jal_o            (jal            ), //
        .jalr_o           (jalr           )//
);
//REGISTER FILE
rf_riscv RF(
        .write_enable_i           (rf_we          ), //
        .read_addr1_i             (RA1            ), 
        .read_addr2_i             (RA2            ), 
        .write_addr_i             (WA             ), 
        .read_data1_o             (RD1            ), //
        .read_data2_o             (RD2            ), //
        .write_data_i             (WD             ), //
        .clk_i                    (clk_i          )
);
//ALU
alu_riscv ALU (
        .a_i              (A              ), //
        .b_i              (B              ), //
        .alu_op_i         (aluop          ), //
        .result_o         (alu_result     ), //
        .flag_o           (flag           ) //
); 
//PC  

initial
begin
    instr_addr_o = 32'h00000000;
    //enpc = 1;
end

// Sign Extentions:
assign imm_U = {instr_i[31:12], 12'b0};
assign imm_I = {{20{instr_i[31]}}, instr_i[31:20]};
assign imm_S = {{20{instr_i[31]}}, instr_i[31:25], instr_i[11:7]};
assign imm_B = {{20{instr_i[31]}}, instr_i[7], instr_i[30:25], instr_i[11:8], 1'b0};
assign imm_J = {{20{instr_i[31]}}, instr_i[19:12], instr_i[20], instr_i[30:21], 1'b0};
 
//adresses for Register file
assign RA1 = instr_i[19:15];
assign RA2 = instr_i[24:20];
assign WA = instr_i[11:7];

assign mem_size_o = mem_size;
assign mem_req_o = mem_req;
assign mem_we_o = mem_we;
assign mem_wd_o = RD2;

assign data_addr_o = alu_result;


always_comb
begin
// ALU operands muts:
    case(src_a)
      2'b00: A <= RD1;
      2'b01: A <= instr_addr_o;
      2'b10: A <= 0;
    endcase
    
    case(src_b)
      3'b000: B <= RD2;
      3'b001: B <= imm_I;
      3'b010: B <= imm_U;
      3'b011: B <= imm_S;
      3'b100: B <= 4;
      endcase
      
      WD <= ws == 0 ? alu_result : mem_rd_i;
end

always @(posedge clk_i)
begin
    //reset????????
    if(rst_i) instr_addr_o <= 0;
    else if(!stall_i) case(jalr)
    1'b0: instr_addr_o <= ((jalr)? RD1 : (instr_addr_o + ((jal || (flag && branch))? ((branch)? imm_B : imm_J ): 4)));
    1'b1: instr_addr_o <=  RD1;
    endcase
    
end
endmodule
