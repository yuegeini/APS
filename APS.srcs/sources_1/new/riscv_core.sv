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
    input   logic          irq_req_i,
    output  logic          irq_ret_o,    
    output  logic  [31:0]  instr_addr_o,//
    output  logic  [31:0]  data_addr_o,//
    output  logic          mem_we_o, //
    output  logic          mem_req_o,//
    output  logic  [2:0]   mem_size_o, //  
    output  logic  [31:0]  mem_wd_o//

    );
logic [31:0] WD, RD1, RD2, A, B, alu_result;//

logic [31:0] imm_I, imm_S, imm_B, imm_U, imm_J, imm_Z;//
logic [4:0] aluop, RA1, RA2, WA;//
logic flag, rf_we, gpr_we;
logic jal, jalr, branch, illegal_instr, mem_req, mem_we;//
logic [1:0] ws;

logic [1:0] src_a; //
logic [2:0] src_b, mem_size, csr_op;//

logic mret, trap, csr_we, irq;
logic [31:0] PC, csr_wd, mie, mepc, mtvec, mcause;

//MAIN DECODER
decoder_riscv main_decoder(
        .fetched_instr_i  (instr_i        ), //
        .a_sel_o          (src_a          ), //
        .b_sel_o          (src_b          ), //
        .alu_op_o         (aluop          ), 
        .mem_req_o        (mem_req        ), //
        .mem_we_o         (mem_we         ), //
        .mem_size_o       (mem_size       ), //
        .gpr_we_a_o       (gpr_we          ), //
        .wb_src_sel_o     (ws             ), //
        .illegal_instr_o  (illegal_instr  ), //
        .branch_o         (branch         ), //
        .jal_o            (jal            ), //
        .jalr_o           (jalr           ), //
        .mret_o           (mret           ),
        .csr_op_o         (csr_op         ),
        .csr_we_o         (csr_we         )
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
//CSR
csr_controller CSR (
        .clk_i              (clk_i),
        .rst_i              (rst_i),
        .trap_i             (trap),
        
        .opcode_i           (csr_op),
        
        .addr_i             (instr_i[31:20]),
        .pc_i               (PC),          
        .mcause_i           (mcause),      
        .rs1_data_i         (RD1),    
        .imm_data_i         (imm_Z),
        .write_enable_i     (csr_we),
        
        .read_data_o        (csr_wd),  
        .mie_o              (mie),
        .mepc_o             (mepc),
        .mtvec_o            (mtvec)        
);
//IRQ
interrupt_controller IRQ (
        .clk_i               (clk_i),
        .rst_i               (rst_i),
        .exception_i         (illegal_instr),
        .irq_req_i           (irq_req_i),  
        .mie_i               (mie[0]),      
        .mret_i              (mret),     
        
        .irq_ret_o           (irq_ret_o),  
        .irq_cause_o         (irq_cause),
        .irq_o               (irq)       
);


//PC  

initial
begin
    PC <= instr_i;
    //enpc = 1;
end

// Sign Extentions:
assign imm_U = {instr_i[31:12], 12'b0};
assign imm_I = {{20{instr_i[31]}}, instr_i[31:20]};
assign imm_S = {{20{instr_i[31]}}, instr_i[31:25], instr_i[11:7]};
assign imm_B = {{20{instr_i[31]}}, instr_i[7], instr_i[30:25], instr_i[11:8], 1'b0};
assign imm_J = {{20{instr_i[31]}}, instr_i[19:12], instr_i[20], instr_i[30:21], 1'b0};
assign imm_Z = {27'b0, instr_i[19:15]};
 
//adresses for Register file
assign RA1 = instr_i[19:15];
assign RA2 = instr_i[24:20];
assign WA = instr_i[11:7];

assign mem_size_o = mem_size;
assign mem_req_o = mem_req & ~trap;
assign mem_we_o = mem_we & ~trap;
assign mem_wd_o = RD2;

assign data_addr_o = alu_result;

assign rf_we = ~(stall_i | trap) & gpr_we;

//CSR
assign trap = irq | illegal_instr;
assign mcause = illegal_instr ? 32'h2 : irq_cause;


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
      case(ws)
        2'b00: WD <= alu_result;
        2'b01: WD <= mem_rd_i;
        2'b10: WD <= csr_wd;
      endcase
end
logic [31:0] add_pc, new_pc, new_pc_trap, new_pc_mret;
always_comb begin
    add_pc <= ((flag & branch | jal) ? (branch ? imm_B : imm_J) : 4);
    new_pc <= jalr ? (RD1 + imm_J) & 32'hfffffffe : PC + add_pc;
    new_pc_trap <= trap ? mtvec : new_pc;
    new_pc_mret <= mret ? mepc : new_pc_trap;
end
always @(posedge clk_i)
begin
    //reset????????
    if(rst_i) PC <= 0;
    else if(!stall_i) begin
//        case(jalr)
//            1'b0: PC <= PC + add_pc;
//            1'b1: begin PC <=  RD1 + imm_J; PC[0] = 0; end
//        endcase
        PC <= new_pc_mret;
//        PC <= PC + ((flag & branch | jal) ? (branch ? imm_B : imm_J) : 4);
//        PC <= trap ? mtvec : PC;
//        PC <= mret ? mepc : PC;
//        PC <= instr_addr_o;
    end
end
assign instr_addr_o = PC;
endmodule
