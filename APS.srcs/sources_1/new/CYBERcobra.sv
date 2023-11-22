module CYBERcobra(
    input   logic        clk_i,
    input   logic        rst_i,
    input   logic [15:0] sw_i,
    output  logic [31:0] out_o
    );
    // reset_simulation -simset sim_1 -mode behavioral 
logic [31:0] PC;

logic [31:0] REG_RD1, REG_RD2, REG_WD;
                        //logic [4:0] REG_RA1, REG_RA2, REG_WA;
logic REG_WE;
//
logic [31:0]  ALU_res;  //A, B,
                        //logic [4:0] ALUop;
logic Flag;
// no


logic [31:0] I_M_RD;   //  I_M_RA,
//

alu_riscv ALU_dut(
    //input
    .a_i(REG_RD1),
    .b_i(REG_RD2),
    .alu_op_i(I_M_RD[27:23]),
    //output
    .result_o(ALU_res),
    .flag_o(Flag)
);


// no one
rf_riscv REG_dut( 
    //output
    .read_data1_o(REG_RD1),
    .read_data2_o(REG_RD2),
    //input
    .read_addr1_i(I_M_RD[22:18]),
    .read_addr2_i(I_M_RD[17:13]),
    .write_data_i(REG_WD),
    .write_addr_i(I_M_RD[4:0]),
    .write_enable_i(REG_WE),
    .clk_i(clk_i)
);

instr_mem INS_MEM_dut(
    .addr_i(PC),
    .read_data_o(I_M_RD)
);
always_ff @(posedge clk_i) begin
//    connected in ALU_dut
//    A = REG_RD1;
//    B = REG_RD2;
//    ALUop = I_M_RD[27:23];

//    connected in REG_dut    
//    REG_WA = I_M_RD[4:0];
//    REG_RA2 = I_M_RD[17:13];
//    REG_RA1 = I_M_RD[22:18];


    if(rst_i) PC <= 32'b0;
    else begin 
          if((Flag & I_M_RD[30]) == 1 | I_M_RD[31]) PC <= PC + {22'b0, I_M_RD[12:5], 2'b0};
        else PC <= PC + 32'd4; 
    end
end
always_comb begin
    REG_WE <= ~(I_M_RD[30] | I_M_RD[31]);
    out_o <= REG_RD1;
    
    case(I_M_RD[29:28])
        2'b01: REG_WD <= ALU_res;
        2'b00: REG_WD <= (I_M_RD[27] == 1) ? {9'b1, I_M_RD[27:0]} : {9'b0, I_M_RD[27:0]};
        2'b10: REG_WD <= {16'b0, sw_i[15:0]};
        default: REG_WD <= 32'b0;
    endcase
end

endmodule
