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
  input  logic [3:0] hex0_i,    // �����, ��������� �� ������� (����� ������) ���������
  input  logic [3:0] hex1_i,    // �����, ��������� �� ������ ���������
  input  logic [3:0] hex2_i,    // �����, ��������� �� ������ ���������
  input  logic [3:0] hex3_i,    // �����, ��������� �� ������ ���������
  input  logic [3:0] hex4_i,    // �����, ��������� �� ��������� ���������
  input  logic [3:0] hex5_i,    // �����, ��������� �� ����� ���������
  input  logic [3:0] hex6_i,    // �����, ��������� �� ������ ���������
  input  logic [3:0] hex7_i,    // �����, ��������� �� ������� ���������
  input  logic [7:0] bitmask_i, // ������� ����� ��� ���������/����������
                                // ��������� �����������

  output logic [6:0] hex_led_o, // ������, �������������� ������ ���������
                                // ��������� ����������
  output logic [7:0] hex_sel_o  // ������, ����������� �� ����� ���������
                                // ������������ hex_led
);


endmodule
