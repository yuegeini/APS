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
  input  logic        clk_i,
  input  logic        resetn_i,

  // Входы и выходы периферии
  input  logic [15:0] sw_i,       // Переключатели

  output logic [15:0] led_o,      // Светодиоды

  input  logic        kclk_i,     // Тактирующий сигнал клавиатуры
  input  logic        kdata_i,    // Сигнал данных клавиатуры

  output logic [ 6:0] hex_led_o,  // Вывод семисегментных индикаторов
  output logic [ 7:0] hex_sel_o,  // Селектор семисегментных индикаторов

  input  logic        rx_i,       // Линия приема по UART
  output logic        tx_o       // Линия передачи по UART

//  output logic [3:0]  vga_r_o,    // красный канал vga
//  output logic [3:0]  vga_g_o,    // зеленый канал vga
//  output logic [3:0]  vga_b_o,    // синий канал vga
//  output logic        vga_hs_o,   // линия горизонтальной синхронизации vga
//  output logic        vga_vs_o    // линия вертикальной синхронизации vga

    );
logic sysclk, rst;
sys_clk_rst_gen divider(.ex_clk_i(clk_i),.ex_areset_n_i(resetn_i),.div_i(10),.sys_clk_o(sysclk),
                             .sys_reset_o(rst));
 
 
logic stall, mem_we, mem_req, lsu_req, lsu_we, lsu_ready, req;
logic [31:0] instr, RD, instr_addr, mem_addr, mem_wd, lsu_wd, lsu_addr, lsu_rd, addr;
logic [2:0] mem_size;
logic [3:0] lsu_be;
logic irq_ret, irq_req; 
logic [7:0] multi_addr;
logic [31:0] data_RD, hex_RD, sw_RD;
logic [255:0] out;

always_comb begin
    out <= 256'd0;
    out[multi_addr] <= 1'b1;
end

assign multi_addr = lsu_addr[31:24];
assign lsu_ready = 1'b1;
assign addr = {8'd0, lsu_addr[23:0]};
assign req = lsu_req;


//CORE
riscv_core CORE (
        .clk_i              (sysclk      ),
        .rst_i              (rst      ),
        .stall_i            (stall      ),
        .instr_i            (instr      ),
        .mem_rd_i           (RD         ),
        
        .instr_addr_o       (instr_addr ),
        .data_addr_o        (mem_addr  ),
        .mem_we_o           (mem_we     ),
        .mem_req_o          (mem_req    ),
        .mem_size_o         (mem_size   ),
        .mem_wd_o           (mem_wd     ),
        
        .irq_req_i          (irq_req), 
        .irq_ret_o          (irq_ret)  
);
//INSTRUCTION MEMORY
instr_mem instruction(
        .addr_i             (instr_addr ),
        .read_data_o        (instr      )
);
//LSU
LSU LSU( 
        .clk_i              (sysclk      ),
        .rst_i              (rst      ),  
         
        .core_req_i         (mem_req    ),
        .core_we_i          (mem_we     ),
        .core_size_i        (mem_size   ),
        .core_addr_i        (mem_addr   ),
        .core_wd_i          (mem_wd     ),
        .core_rd_o          (RD         ),
        .core_stall_o       (stall      ),
                             
        .mem_req_o          (lsu_req    ),
        .mem_we_o           (lsu_we     ),
        .mem_be_o           (lsu_be     ),
        .mem_addr_o         (lsu_addr   ),
        .mem_wd_o           (lsu_wd     ),
        .mem_rd_i           (lsu_rd     ),
        .mem_ready_i        (lsu_ready  )
);
//DATA MEMORY
data_mem data(
        .clk_i              (sysclk      ),
        .mem_req_i          (req & out[0]),
        .write_enable_i     (mem_we     ),
        .byte_enable_i      (lsu_be     ),
        .addr_i             (addr       ),
        .write_data_i       (mem_wd     ),
        .read_data_o        (data_RD    )
);
////HEX
//hex_sb_ctrl HEX(
//        .clk_i              (clk_i          ),
//        .addr_i             (addr           ),
//        .req_i              (req & out[4]   ),
//        .write_data_i       (lsu_wd         ),
//        .write_enable_i     (lsu_we         ),
//        .read_data_o        (hex_RD         ),
       
//        .hex_led            (hex_led_o      ),
//        .hex_sel            (hex_sel_o      ) 
//);
sw_sb_ctrl SW(
        .clk_i              (sysclk          ),             
        .rst_i              (rst          ),             
        .req_i              (req & out[1]   ),             
        .write_enable_i     (lsu_we         ),    
        .addr_i             (addr           ),            
        .write_data_i       (lsu_wd         ), 
                      
        .read_data_o        (sw_RD          ),       
                 
        .interrupt_request_o(irq_req        ),
        .interrupt_return_i (irq_ret        ),
        .sw_i               (sw_i           )
);
led_sb_ctrl LED(
        .clk_i              (sysclk          ),          
        .rst_i              (rst          ),          
        .req_i              (req & out[2]   ),          
        .write_enable_i     (lsu_we         ), 
        .addr_i             (addr           ),         
        .write_data_i       (lsu_wd         ),   
        .read_data_o        (hex_RD         ),   
        
        .led_o              (led_o          )          
);

always_comb  begin
    case(multi_addr)
        8'd0: lsu_rd <= data_RD;
        8'd1: lsu_rd <= sw_RD;
        8'd2: lsu_rd <= hex_RD;
    endcase
end

//STALL

//always @(posedge clk_i)
//begin
//    if(rst_i) stall <= 1;
//    else stall <= ~stall & mem_req;
//end
endmodule
