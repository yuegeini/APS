module full_adder(
    input   logic [31:0]  a_i,
    input   logic [31:0]  b_i,
    output  logic [31:0]  result
    );

    logic [31:0] cin;
    logic [31:0] cout;

genvar i;
generate
    for (i = 0; i < 32; i = i + 1) begin : newgen
        if(i == 0) assign cin[i] = 0;
        summarizer new_i(
            .a(a_i[i]),
            .b(b_i[i]),
            .cin(cin[i]),
            .cout(cout[i]),
            .s(result[i])
            );
            assign cin[i + 1] = cout[i];
     end
endgenerate
            

endmodule
