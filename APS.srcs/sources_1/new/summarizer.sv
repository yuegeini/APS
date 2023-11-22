`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.09.2023 13:11:19
// Design Name: 
// Module Name: summarizer
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


module summarizer(
    input   logic   a,
    input   logic   b,
    input   logic   cin,
    output  logic   s,
    output  logic   cout
    );

assign cout = a & b | a & cin | b & cin;
assign s = a ^ b ^ cin;

endmodule
