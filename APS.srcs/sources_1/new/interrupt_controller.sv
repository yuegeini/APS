`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.11.2023 00:03:24
// Design Name: 
// Module Name: interrupt_controller
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


module interrupt_controller(
  input  logic        clk_i,
  input  logic        rst_i,
  input  logic        exception_i,
  input  logic        irq_req_i,
  input  logic        mie_i,
  input  logic        mret_i,

  output logic        irq_ret_o,
  output logic [31:0] irq_cause_o,
  output logic        irq_o
);
logic exch_o, exch_set, exch_reset, irqh_o, irqh_set, irqh_reset;

always_comb begin 
    irq_cause_o <= 32'h10000010;
    
    irq_o <= irq_req_i & mie_i & ~(exch_set | irqh_o);
    irq_ret_o <= mret_i & (~exch_set); 
                   
    irqh_set <= irq_o  | irqh_o;                      
    irqh_reset <= ~irq_ret_o & irqh_set;    
              
    exch_set <= exception_i | exch_o; 
    exch_reset <= ~mret_i & exch_set; 
end
always_ff @(posedge clk_i, posedge rst_i) begin
    if(rst_i) exch_o <= 0;
    else exch_o <= exch_reset;
    if(rst_i) irqh_o <= 0;
    else irqh_o <= irqh_reset;
end

endmodule
