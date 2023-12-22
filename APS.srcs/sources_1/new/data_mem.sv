`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.09.2023 20:23:36
// Design Name: 
// Module Name: data_mem
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


module data_mem(
    input   logic           clk_i,
    input   logic           mem_req_i,
    input   logic           write_enable_i,
    input   logic [ 3:0]    byte_enable_i,
    input   logic [31:0]    addr_i,
    input   logic [31:0]    write_data_i,
    output  logic [31:0]    read_data_o 
    );
//    assign read_data_oi = 0;
import riscv_pkg::*;
logic [31:0] PRISHED [0:1023];

always_ff @(posedge clk_i)begin
    if(mem_req_i == 1) begin
        read_data_o <= PRISHED[addr_i >> 2];
    end 
end

always_ff@(posedge clk_i) begin
    if(mem_req_i == 1 && write_enable_i == 1)begin
        if(byte_enable_i[0])begin
            PRISHED[addr_i >> 2][7:0] <= write_data_i[7:0];
        end
        if(byte_enable_i[1])begin
            PRISHED[addr_i >> 2][15:8] <= write_data_i[15:8];
        end
        if(byte_enable_i[2])begin
            PRISHED[addr_i >> 2][23:16] <= write_data_i[23:16];
        end
        if(byte_enable_i[3])begin
            PRISHED[addr_i >> 2][31:24] <= write_data_i[31:24];
        end
    end
end
endmodule



//            case(state)
//                2'b00: begin
//                    ROM[addr_i] <= write_data_i[7:0];
//                    state <= 2'b01;
//                end
//                2'b01: begin
//                    ROM[addr_i + 1] <= write_data_i[15:8];
//                    state <= 2'b10;
//                end 
//                2'b10: begin
//                    ROM[addr_i + 2] <= write_data_i[23:16];
//                    state <= 2'b11;
//                end 
//                2'b11: begin 
//                    ROM[addr_i + 3] <= write_data_i[31:24];
                    
//                end