`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.09.2023 07:16:19
// Design Name: 
// Module Name: alu_riscv
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

module alu_riscv(
    input   logic [31:0]  a_i,
    input   logic [31:0]  b_i,
    input   logic [4:0]   alu_op_i,
    output  logic         flag_o,
    output  logic [31:0]  result_o
);
import alu_opcodes_pkg::*;
logic c_out;
//logic [31:0] res;
//full_adder fulladder(
//    .a_i(a_i),
//    .b_i(b_i),
//    .result(res)
// );
always_comb
begin

//    if(alu_op_i[4])
//        result_o = 0;
//    else
//        flag_o = 0;
    
    case(alu_op_i)
        ALU_ADD:    {c_out, result_o} <= a_i + b_i;
        ALU_SUB:    {c_out, result_o} <= a_i + ~b_i + 1;
        ALU_SLL:    result_o <= a_i << b_i[4:0];
        ALU_SLTS:   result_o <= $signed(a_i) < $signed(b_i);
        ALU_SLTU:   result_o <= a_i < b_i;// without +-
        ALU_XOR:    result_o <= a_i ^ b_i;
        ALU_SRL:    result_o <= a_i >> b_i[4:0]; 
        ALU_SRA:    result_o <= $signed(a_i) >>> b_i[4:0];
        ALU_OR:     result_o <= a_i | b_i;
        ALU_AND:    result_o <= a_i & b_i;
//        ALU_EQ:     result_o <= 0;
//        ALU_NE:     result_o <= 0;
//        ALU_LTS:    result_o <= 0; 
//        ALU_GES:    result_o <= 0;
//        ALU_LTU:    result_o <= 0;
//        ALU_GEU:    result_o <= 0;
        default:    result_o <= 0;
    endcase
//end
//always_comb
//begin
    case(alu_op_i)
//        ALU_ADD:    flag_o <= 0;
//        ALU_SUB:    flag_o <= 0;
//        ALU_SLL:    flag_o <= 0;
//        ALU_SLTS:   flag_o <= 0;
//        ALU_SLTU:   flag_o <= 0;
//        ALU_XOR:    flag_o <= 0;
//        ALU_SRL:    flag_o <= 0;
//        ALU_SRA:    flag_o <= 0;
//        ALU_OR:     flag_o <= 0;
//        ALU_AND:    flag_o <= 0;
        ALU_EQ:     flag_o <= (a_i == b_i); // ? 1 : 0;
        ALU_NE:     flag_o <= (a_i != b_i);
        ALU_LTS:    flag_o <= ($signed(a_i) < $signed(b_i));
        ALU_GES:    flag_o <= ($signed(a_i) >= $signed(b_i));
        ALU_LTU:    flag_o <= (a_i < b_i); //without sign
        ALU_GEU:    flag_o <= (a_i >= b_i); //without sign
        default:    flag_o <= 0;
    endcase            
end


endmodule
