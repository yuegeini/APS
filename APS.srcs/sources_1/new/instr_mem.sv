`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.09.2023 19:28:11
// Design Name: 
// Module Name: instr_mem
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


module instr_mem(
    input   logic [31:0] addr_i,
    output  logic [31:0] read_data_o 

    );
    
logic [7:0] ROM [0:1023];

initial $readmemh("program.txt", ROM);

always_comb begin
    if(addr_i < 1021) 
        read_data_o = {ROM[addr_i + 3], ROM[addr_i + 2], ROM[addr_i + 1], ROM[addr_i]};
    else read_data_o = 0;
end


endmodule
