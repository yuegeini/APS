`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.12.2023 22:05:22
// Design Name: 
// Module Name: hex_digits
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


module hex_digits(
  input  logic       clk_i,
  input  logic       rst_i,
  input  logic [3:0] hex0_i,    // Цифра, выводимой на нулевой (самый правый) индикатор
  input  logic [3:0] hex1_i,    // Цифра, выводимая на первый индикатор
  input  logic [3:0] hex2_i,    // Цифра, выводимая на второй индикатор
  input  logic [3:0] hex3_i,    // Цифра, выводимая на третий индикатор
  input  logic [3:0] hex4_i,    // Цифра, выводимая на четвертый индикатор
  input  logic [3:0] hex5_i,    // Цифра, выводимая на пятый индикатор
  input  logic [3:0] hex6_i,    // Цифра, выводимая на шестой индикатор
  input  logic [3:0] hex7_i,    // Цифра, выводимая на седьмой индикатор
  input  logic [7:0] bitmask_i, // Битовая маска для включения/отключения
                                // отдельных индикаторов

  output logic [6:0] hex_led_o, // Сигнал, контролирующий каждый отдельный
                                // светодиод индикатора
  output logic [7:0] hex_sel_o  // Сигнал, указывающий на какой индикатор
                                // выставляется hex_led
);


endmodule
