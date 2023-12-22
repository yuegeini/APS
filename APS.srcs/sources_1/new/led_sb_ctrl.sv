`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.12.2023 00:58:21
// Design Name: 
// Module Name: led_sb_ctrl
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


module led_sb_ctrl(
/*
    Часть интерфейса модуля, отвечающая за подключение к системной шине
*/
  input  logic        clk_i,
  input  logic        rst_i,
  input  logic        req_i,
  input  logic        write_enable_i,
  input  logic [31:0] addr_i,
  input  logic [31:0] write_data_i,
  output logic [31:0] read_data_o,

/*
    Часть интерфейса модуля, отвечающая за подключение к периферии
*/
  output logic [15:0] led_o
);
logic [15:0]  led_val;
logic         led_mode;
logic led_blink;
logic [31:0] counter;
//initial counter = 0;


always_ff @(posedge clk_i) begin

    if (addr_i == 32'h00000000 ) led_val <= write_data_i[15:0];// write_data_i > {16'h00, write_data_i[15:0]} ? 16'h0000 :
    if (addr_i == 32'h00000004) led_mode <= write_data_i[0];     // write_data_i > 1 ? 0 :
    
    if(counter == 32'd9999999) begin 
        led_o <= led_val & {16{led_blink}}; 
        counter <= 0; 
        led_blink <= led_blink ^ 1;
    end 
    else 
    if(rst_i) begin counter <= 0; read_data_o <= 0; led_o <= 0; led_mode <= 0; led_blink <= 0; end
    else if(req_i) begin
        if(write_enable_i == 1) led_o <= led_val;
        if(write_enable_i == 0) read_data_o <= {16'h0000, led_val};
    end 
    if(addr_i[7:0] == 8'h24) begin
        led_val <= 0;
        led_mode <= 0;
        led_blink <= 0;
        counter <= 0;
        led_o <= 0;
        read_data_o <= 0;
    end 
    
    if(led_mode) counter <= counter + 1'b1;
    else counter <= 0;
end


endmodule
