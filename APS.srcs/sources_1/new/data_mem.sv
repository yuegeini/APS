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
    input   logic [31:0]    addr_i,
    input   logic [31:0]    write_data_i,
    output  logic [31:0]    read_data_oi 
    );
//    assign read_data_oi = 0;
logic [7:0] ROM [0:1023];
always_ff @(posedge clk_i) begin
    if(mem_req_i == 0 || write_enable_i == 1) begin 
            read_data_oi <= 32'hfa11_1eaf;
    end
    else if(mem_req_i) begin 
        if (addr_i < 1021)
            read_data_oi <= {ROM[addr_i + 3], ROM[addr_i + 2], ROM[addr_i + 1], ROM[addr_i]};
        else if(addr_i < 1024)
//            read_data_oi <= {{((addr_i - 4092) * 2){4'bx}}, ROM[4095 : addr_i]};
            case(addr_i)
                1021: read_data_oi <= {{2{4'bx}}, ROM[addr_i + 2], ROM[addr_i + 1], ROM[addr_i]};
                1022: read_data_oi <= {{4{4'bx}}, ROM[addr_i + 1], ROM[addr_i]};
                1023: read_data_oi <= {{6{4'bx}}, ROM[addr_i]};
            endcase
        else read_data_oi <= 32'hdead_beef; 
    end
//    else     read_data_oi <= 32'hx;

end
always_ff @(posedge clk_i) begin
    if(mem_req_i && write_enable_i) begin
        if(addr_i < 1021) begin
            ROM[addr_i] <= write_data_i[7:0];
            ROM[addr_i + 1] <= write_data_i[15:8];
            ROM[addr_i + 2] <= write_data_i[23:16];
            ROM[addr_i + 3] <= write_data_i[31:24];
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