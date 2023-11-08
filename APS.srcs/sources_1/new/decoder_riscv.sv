`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.09.2023 18:30:55
// Design Name: 
// Module Name: decoder_riscv
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


module decoder_riscv (
  input  logic [31:0]  fetched_instr_i,
  output logic [1:0]   a_sel_o,
  output logic [2:0]   b_sel_o,
  output logic [4:0]   alu_op_o,
  output logic         mem_req_o,
  output logic         mem_we_o,
  output logic [2:0]   mem_size_o,
  output logic         gpr_we_a_o,
  output logic         wb_src_sel_o,        //write back selector
  output logic         illegal_instr_o,
  output logic         branch_o,
  output logic         jal_o,
  output logic         jalr_o
);
import riscv_pkg::*;                          
import alu_opcodes_pkg::*;

//
logic [6:0] func7;
assign func7 = fetched_instr_i[31:25];
logic [2:0] func3;
assign func3 = fetched_instr_i[14:12];
logic [6:0] opcode;
assign opcode = fetched_instr_i [6:0];

//logic toNop <= fetched_instr_i[20];


always_comb begin 
    
        a_sel_o <= OP_A_ZERO;
        b_sel_o <= OP_B_INCR;
        alu_op_o  <= ALU_ADD; 
        mem_req_o  <= 0;
        mem_we_o   <= 0;
        mem_size_o <= 3'b000;
        gpr_we_a_o <= 0;
        wb_src_sel_o <= 0;
        illegal_instr_o <= 0;
        branch_o   <= 0;
        jal_o    <= 0;
        jalr_o    <= 0;  
        
    if(opcode[1:0] != 2'b11) begin
        illegal_instr_o <= 1;  
        
    end
    else begin
        case(opcode[6:2])
        ////////////////////////////////////////////////////////////////////
            // R-type
            // 10 operations
            // rs1 , rs2 -> A , B in ALU
            // Don't touch memory (only reg memory)
            OP_OPCODE : begin // R-type
            
                    gpr_we_a_o <= 1; // write to reg
                    case(func3)
                        3'b000: begin
                            if(func7 == 7'h20) alu_op_o <= ALU_SUB;
                            else if(func7 == 7'h00) alu_op_o <= ALU_ADD; //ALU_SUB 0x20
                            else begin 
                            gpr_we_a_o <= 0;
                            illegal_instr_o <= 1;
                            end
                        end
                        3'b100: if(func7 == 7'h00) alu_op_o <= ALU_XOR;
                                else begin 
                                gpr_we_a_o <= 0;
                                illegal_instr_o <= 1;
                                end
                        3'b110: if(func7 == 7'h00) alu_op_o <= ALU_OR;
                                else begin 
                                gpr_we_a_o <= 0;
                                illegal_instr_o <= 1;
                                end
                        3'b111: if(func7 == 7'h00) alu_op_o <= ALU_AND;
                                else begin 
                                gpr_we_a_o <= 0;
                                illegal_instr_o <= 1;
                                end
                        3'b001: if(func7 == 7'h00) alu_op_o <= ALU_SLL;
                                else begin 
                                gpr_we_a_o <= 0;
                                illegal_instr_o <= 1;
                                end
                        3'b101: begin
                            if(func7 == 7'h20) alu_op_o <= ALU_SRA;
                            else if(func7 == 7'h00) alu_op_o <= ALU_SRL; //ALU_SRA 0x20
                            else begin 
                            gpr_we_a_o <= 0;
                            illegal_instr_o <= 1;
                            end
                        end
                        3'b010: if(func7 == 7'h00) alu_op_o <= ALU_SLTS;
                                else begin 
                                gpr_we_a_o <= 0;
                                illegal_instr_o <= 1;
                                end // SLT
                        3'b011: if(func7 == 7'h00) alu_op_o <= ALU_SLTU;
                                else begin 
                                gpr_we_a_o <= 0;
                                illegal_instr_o <= 1;
                                end
                        default: begin
                             illegal_instr_o <= 1;
                             gpr_we_a_o <= 0;
                        end
                    endcase
//                    alu_op_o <= {2'b00,func3};
                    
                    
                    // to A, B in ALU
                    b_sel_o <= OP_B_RS2;
                    a_sel_o <= OP_A_RS1;
                    // No memory op
//                    mem_req_o <= 0;
//                    mem_we_o <= 0;
//                    mem_size_o <= 3'b000;
//                    // Reg memory op ))
//                    wb_src_sel_o <= 0; //from ALU to reg
//                    // PC <= PC + 4 
//                    // Zero port on multiplexer
//                    jalr_o <= 0;
//                    branch_o <= 0;
//                    jal_o <= 0;
                    //illegal_instr_o <= 1;
                    if(func7 != 7'h20 && func7 != 7'h0) begin illegal_instr_o <= 1;
                    gpr_we_a_o <= 0;
                    end
            end
        ////////////////////////////////////////////////////////////////////
            //I-type
            //imm, rs1 -> A, B in ALU
            //9 operations
            //
            OP_IMM_OPCODE: begin
                    gpr_we_a_o <= 1;// write to reg   
                    case(func3)
                        3'b000: alu_op_o <= ALU_ADD; //ALU_SUB 0x20
                        3'b100: alu_op_o <= ALU_XOR;
                        3'b110: alu_op_o <= ALU_OR;
                        3'b111: alu_op_o <= ALU_AND;
                        3'b001: begin 
                                if(func7 != 7'h0) begin illegal_instr_o <= 1;
                                gpr_we_a_o <= 0;
                                end
                                alu_op_o <= ALU_SLL;
                        end
                        3'b101: begin 
                                if(func7 != 7'h0 || func7 != 7'h20) begin illegal_instr_o <= 1;
                                gpr_we_a_o <= 0;
                                end
                                if(func7 == 7'h0) alu_op_o <= ALU_SRL;
                                if(func7 == 7'h20) alu_op_o <= ALU_SRA;
                        end //ALU_SRA 0x20
                        3'b010: alu_op_o <= ALU_SLTS; // SLT
                        3'b011: alu_op_o <= ALU_SLTU;
                        default: begin illegal_instr_o <= 1;
                            gpr_we_a_o <= 0;
                        end
                    endcase
                    
                    // to IMM, A in ALU
                    b_sel_o <= OP_B_IMM_I;
                    a_sel_o <= OP_A_RS1;
                    // No memory op
//                    mem_req_o <= 0;
//                    mem_we_o <= 0;
//                    mem_size_o <= 3'bxxx;
//                    // Reg memory op ))
//                    wb_src_sel_o <= 0;//from ALU to reg 
//                    // PC <= PC + 4 
//                    // Zero port on multiplexer
//                    jalr_o <= 0;
//                    branch_o <= 0;
//                    jal_o <= 0;
                    //illegal_instr_o <= 1;
//                    if(func7 != 7'h20 || func7 != 7'h0) illegal_instr_o <= 1;
            end
        ////////////////////////////////////////////////////////////////////
        //I-type load instructions
        //5 op
        //no ALU
        LOAD_OPCODE: begin
                
                    // no ALU
                    b_sel_o <= OP_B_IMM_I;
                    a_sel_o <= OP_A_RS1;
                    alu_op_o <= ALU_ADD; // to data_addr_o
                    // Reg memory op
                    gpr_we_a_o <= 1; // write to reg  (rd) 
                    wb_src_sel_o <= 1; // to mem by mem_rd_i
                    // PC <= PC + 4 
                    // Zero port on multiplexer
//                    jalr_o <= 0;
//                    branch_o <= 0;
//                    jal_o <= 0;
                    // memory op
                    mem_req_o <= 1;
//                    mem_we_o <= 0; //read from mem
//                    mem_size_o <= 3'bxxx;
                    case(func3)
                        LDST_B: mem_size_o <= LDST_B;
                        LDST_H: mem_size_o <= LDST_H;
                        LDST_W: mem_size_o <= LDST_W;
                        LDST_BU: mem_size_o <= LDST_BU;
                        LDST_HU: mem_size_o <= LDST_HU;
                        default: begin  
                            illegal_instr_o <= 1;
                            mem_req_o <= 0;
                            gpr_we_a_o <= 0;
                        end 
                    endcase
            end
        ////////////////////////////////////////////////////////////////////
        //S-type store instructions
        //3 op
        //no ALU
        STORE_OPCODE: begin
                
                    // no ALU
                    b_sel_o <= OP_B_IMM_S;
                    a_sel_o <= OP_A_RS1;
                    alu_op_o <= ALU_ADD; 
                    // NO Reg memory op
//                    gpr_we_a_o <= 0;
//                    wb_src_sel_o <= 0; //to ???? maybe x
//                    // PC <= PC + 4 
//                    // Zero port on multiplexer
//                    jalr_o <= 0;
//                    branch_o <= 0;
//                    jal_o <= 0;
                    // memory op
                    mem_req_o <= 1;
                    mem_we_o <= 1; // write to mem
                    mem_size_o <= 3'b000;
                    case(func3)
                        LDST_B: mem_size_o <= LDST_B;
                        LDST_H: mem_size_o <= LDST_H;
                        LDST_W: mem_size_o <= LDST_W;
                        default: begin 
                            illegal_instr_o <= 1;
                            mem_req_o <= 0;
                            mem_we_o <= 0;
                            
                        end 
                    endcase
            end
        ////////////////////////////////////////////////////////////////////
        //B-type branch instructions
        //6 op
        //rs1, rs2 to ALU -> get flag
        //No memory
        BRANCH_OPCODE: begin
        
                    branch_o <= 1;
                    case(func3)
                        3'b000: alu_op_o <= ALU_EQ;
                        3'b001: alu_op_o <= ALU_NE;
                        3'b100: alu_op_o <= ALU_LTS;
                        3'b101: alu_op_o <= ALU_GES;
                        3'b110: alu_op_o <= ALU_LTU;
                        3'b111: alu_op_o <= ALU_GEU;
                        default: begin  
                            illegal_instr_o <= 1;
                            branch_o <= 0;
                        end
                    endcase
                    b_sel_o <= OP_B_RS2;
                    a_sel_o <= OP_A_RS1;
                    // NO Reg memory op
//                    gpr_we_a_o <= 0;
//                    wb_src_sel_o <= 0; // maybe x ????
//                    // PC <= PC + imm
//                    // First port on multiplexer
//                    jalr_o <= 0;
//                    jal_o <= 0;
//                    // memory op
//                    mem_req_o <= 0;
//                    mem_we_o <= 0;
//                    mem_size_o <= 3'bxxx;
//                    if(illegal_instr_o == 1) branch_o <= 0;
            end
        ////////////////////////////////////////////////////////////////////
        //JAL instruction
        //1 op
        //4 + PC to ALU -> rd
        //No memory op
        //PC +<= imm
        5'b11011: begin 
                    b_sel_o <= OP_B_INCR; // +4
                    a_sel_o <= OP_A_CURR_PC;
                    alu_op_o <= ALU_ADD;
                    // Reg memory op
                    gpr_we_a_o <= 1; // write rd
//                    wb_src_sel_o <= 0; // from ALU
//                    // PC <= PC + imm
//                    // First port on multiplexer
//                    jalr_o <= 0;
//                    branch_o <= 0;
                    jal_o <= 1;
//                    // memory op
//                    mem_req_o <= 0;
//                    mem_we_o <= 0;
//                    mem_size_o <= 3'bxxx;
            end
        ////////////////////////////////////////////////////////////////////
        //JALR instruction
        //1 op
        //4 + PC to ALU -> rd
        //No memory op
        // PC <= RD1 + imm-i
        JALR_OPCODE: begin 
        
                    if(func3 != 0) illegal_instr_o <= 1;
                    else begin
                        b_sel_o <= OP_B_INCR; // +4
                        a_sel_o <= OP_A_CURR_PC;
                        alu_op_o <= ALU_ADD;
                        // Reg memory op
                        gpr_we_a_o <= 1; // write rd
//                        wb_src_sel_o <= 0; // from ALU
                        
                        jalr_o <= 1;
//                        branch_o <= 0;
//                        jal_o <= 0;
//                        // memory op
//                        mem_req_o <= 0;
//                        mem_we_o <= 0;
//                        mem_size_o <= 3'bxxx;
                    end
            
            end
        ////////////////////////////////////////////////////////////////////
        //AUIPC instruction
        //1 op
        // IMM_U + PC to ALU -> to rd
        //PC <= 4 + PC 
        //No memory op
        AUIPC_OPCODE: begin
                    b_sel_o <= OP_B_IMM_U; // 
                    a_sel_o <= OP_A_CURR_PC;
                    alu_op_o <= ALU_ADD;
                    // Reg memory op
                    gpr_we_a_o <= 1; // write rd
//                    wb_src_sel_o <= 0; // from ALU
//                    // PC <= PC + 4
//                    // First port on multiplexer
//                    jalr_o <= 0;
//                    branch_o <= 0;
//                    jal_o <= 0;
//                    // memory op
//                    mem_req_o <= 0;
//                    mem_we_o <= 0;
//                    mem_size_o <= 3'bxxx;
            end
        ////////////////////////////////////////////////////////////////////
        //LUI instruction
        //1 op
        // IMM_U + 0 to ALU -> to rd
        //PC <= 4 + PC 
        //No memory op
        LUI_OPCODE: begin
                    b_sel_o <= OP_B_IMM_U; // 
                    a_sel_o <= OP_A_ZERO;
                    alu_op_o <= ALU_ADD;
                    // Reg memory op
                    gpr_we_a_o <= 1; // write rd
//                    wb_src_sel_o <= 0; // from ALU
//                    // PC <= PC + 4
//                    // First port on multiplexer
//                    jalr_o <= 0;
//                    branch_o <= 0;
//                    jal_o <= 0;
//                    // memory op
//                    mem_req_o <= 0;
//                    mem_we_o <= 0;
//                    mem_size_o <= 3'bxxx;
            
            end
        ////////////////////////////////////////////////////////////////////
        //SYSTEM, MISC_MEM instructions
        //3 op
        // nop
        SYSTEM_OPCODE: begin
                    b_sel_o <= OP_B_IMM_U; // 
                    a_sel_o <= OP_A_ZERO;
                    alu_op_o <= ALU_ADD;
                    // Reg memory op
//                    gpr_we_a_o <= 0; // write rd
//                    wb_src_sel_o <= 0; // from ALU
//                    // PC <= PC + 4
//                    // First port on multiplexer
//                    jalr_o <= 0;
//                    branch_o <= 0;
//                    jal_o <= 0;
//                    // memory op
//                    mem_req_o <= 0;
//                    mem_we_o <= 0;
//                    mem_size_o <= 3'bxxx;
                    if(fetched_instr_i[19:7] != 0 || fetched_instr_i [31:20] != 0 && fetched_instr_i[31:20] != 1) begin illegal_instr_o <= 1;
                        
                    end
            end
            //SYSTEM, MISC_MEM instructions
        //3 op
        // nop
        MISC_MEM_OPCODE: begin
                    b_sel_o <= OP_B_IMM_U; // 
                    a_sel_o <= OP_A_ZERO;
                    alu_op_o <= ALU_ADD;
                    // Reg memory op
//                    gpr_we_a_o <= 0; // write rd
//                    wb_src_sel_o <= 0; // from ALU
//                    // PC <= PC + 4
//                    // First port on multiplexer
//                    jalr_o <= 0;
//                    branch_o <= 0;
//                    jal_o <= 0;
//                    // memory op
//                    mem_req_o <= 0;
//                    mem_we_o <= 0;
//                    mem_size_o <= 3'bxxx;
                    if(func3 != 0) illegal_instr_o <= 1;
            
            end
        default: begin
                
                illegal_instr_o <= 1;
                
            end
        endcase
    end
end  
endmodule
