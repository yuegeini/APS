`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.10.2023 00:36:22
// Design Name: 
// Module Name: riscv_unit
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


module riscv_unit(
    input logic clk_i,
    input logic rst_i
    );
    
logic stall, mem_we, mem_req;
logic [31:0] instr, RD, instr_addr, data_addr, mem_wd;
logic [3:0] mem_size;
logic irq_ret, irq_req; 
 
//CORE
riscv_core CORE (
    .clk_i          (clk_i      ),
    .rst_i          (rst_i      ),
    .stall_i        (stall      ),
    .instr_i        (instr      ),
    .mem_rd_i       (RD         ),
    
    .instr_addr_o   (instr_addr ),
    .data_addr_o    (data_addr  ),
    .mem_we_o       (mem_we     ),
    .mem_req_o      (mem_req    ),
    .mem_size_o     (mem_size   ),
    .mem_wd_o       (mem_wd     ),
    
    .irq_req_i      (irq_req), 
    .irq_ret_o      (irq_ret)  
);
//INSTRUCTION MEMORY
instr_mem instruction(
    .addr_i         (instr_addr ),
    .read_data_o    (instr      )
);
//DATA MEMORY
data_mem data(
    .clk_i          (clk_i      ),
    .mem_req_i      (mem_req    ),
    .write_enable_i (mem_we     ),
    .addr_i         (data_addr  ),
    .write_data_i   (mem_wd     ),
    .read_data_oi   (RD         )
);
//STALL

always @(posedge clk_i)
begin
    if(rst_i) stall <= 1;
    else stall <= ~stall & mem_req;
end
endmodule
