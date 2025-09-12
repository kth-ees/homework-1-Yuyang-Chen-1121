`include "full_adder.sv"
`include "half_adder.sv"
module multiplier #(parameter N)(
    input [N-1:0] a,b,
    output [2*N-1:0] product
);
logic [N-1:0]     inter_unit         [0:N-1];   
logic [2*N-1:0]   shifted_inter_unit [0:N-1];   
logic [2*N-1:0]   sum   [0:N];                 
logic [2*N:0]     c     [0:N-1];               

genvar i, j, m, n;

generate
    for (m = 0; m < N; m++) begin: GEN_INTER_ROW
        for (j = 0; j < N; j++) begin: GEN_INTER_COL
            assign inter_unit[m][j] = a[j] & b[m];
        end
    end
endgenerate

generate
    for (m = 0; m < N; m++) begin: GEN_SHIFTED_ROW
        for (n = 0; n < 2*N; n++) begin: GEN_SHIFTED_COL
            if (n < m || n >= m+N) begin
                assign shifted_inter_unit[m][n] = 1'b0;
            end else begin
                assign shifted_inter_unit[m][n] = inter_unit[m][n - m];
            end
        end
    end
endgenerate

assign sum[0] = '0;

generate
    for (m = 0; m < N; m++) begin: GEN_C_INIT
        assign c[m][0] = 1'b0;
    end
endgenerate

generate
    for (m = 0; m < N; m++) begin: GEN_ROW_ADD
        for (n = 0; n < 2*N; n++) begin: GEN_COL_ADD
            full_adder u_fa (
                .a    ( sum[m][n] ),
                .b    ( shifted_inter_unit[m][n] ),
                .c_in ( c[m][n] ),
                .s    ( sum[m+1][n] ),
                .c_out( c[m][n+1] )
            );
        end
    end
endgenerate

assign product = sum[N];

endmodule
