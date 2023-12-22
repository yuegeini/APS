`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.12.2023 22:08:17
// Design Name: 
// Module Name: hex_sb_ctrl
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

module hex_sb_ctrl(
/*
    „асть интерфейса модул€, отвечающа€ за подключение к системной шине
*/
  input  logic        clk_i,
  input  logic [31:0] addr_i,
  input  logic        req_i,
  input  logic [31:0] write_data_i,
  input  logic        write_enable_i,
  output logic [31:0] read_data_o,

/*
    „асть интерфейса модул€, отвечающа€ за подключение к модулю,
    осуществл€ющему вывод цифр на семисегментные индикаторы
*/
  output logic [6:0] hex_led,
  output logic [7:0] hex_sel
);

logic [3:0] hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7;
logic [7:0] bitmask;
  
hex_digits hex(
    .clk_i      (clk_i      ),    
    .rst_i      (rst_i      ),    
    .hex0_i     (hex0       ),   
    .hex1_i     (hex1       ),   
    .hex2_i     (hex2       ),   
    .hex3_i     (hex3       ),   
    .hex4_i     (hex4       ),   
    .hex5_i     (hex5       ),   
    .hex6_i     (hex6       ),   
    .hex7_i     (hex7       ),   
    .bitmask_i  (bitmask    ),
    
    .hex_led_o  (hex_led    ),
    
    .hex_sel_o  (hex_sel    )
);
  
always_comb begin
    if(req_i && write_enable_i == 1) begin
    
        case(addr_i)
            32'h00: hex0 <=  write_data_i[3:0];
        endcase
    end
end 
  
  
  
endmodule
