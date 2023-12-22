`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.12.2023 22:27:38
// Design Name: 
// Module Name: sw_sb_ctrl
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


module sw_sb_ctrl(
/*
    ����� ���������� ������, ���������� �� ����������� � ��������� ����
*/
  input  logic        clk_i,
  input  logic        rst_i,
  input  logic        req_i,
  input  logic        write_enable_i,
  input  logic [31:0] addr_i,
  input  logic [31:0] write_data_i,  // �� ������������, �������� ���
                                     // ������������� � ��������� �����
  output logic [31:0] read_data_o,

/*
    ����� ���������� ������, ���������� �� �������� �������� �� ����������
    ������������� ����
*/

  output logic        interrupt_request_o,
  input  logic        interrupt_return_i,

/*
    ����� ���������� ������, ���������� �� ����������� � ���������
*/
  input logic [15:0]  sw_i
);
logic [15:0] last_sw;

always_ff @(posedge clk_i) begin
        if(rst_i) begin read_data_o <= 32'h00000000; last_sw <= 0; end
        else if (req_i && addr_i == 32'h0 && write_enable_i == 0) begin
                        read_data_o <= {16'h0, sw_i};
        end
        if(last_sw != sw_i) begin
            interrupt_request_o <= 1'b1;
            last_sw <= sw_i;
        end
        else if(interrupt_return_i && last_sw == sw_i) interrupt_request_o <= 1'b1;
        else if(!interrupt_return_i && last_sw == sw_i) interrupt_request_o <= 1'b0;
end

endmodule
