`include "multiplier.sv"
module sum_prod #(parameter N) (
    input [N-1:0] X [5:0],
    output [2*N+2:0] result
);

logic [2*N-1:0] p1, p2, p3;

multiplier #(.N(N)) u_mul0 (
    .a(X[0]),
    .b(X[1]),
    .product(p1)
);

multiplier #(.N(N)) u_mul1 (
    .a(X[2]),
    .b(X[3]),
    .product(p2)
);

multiplier #(.N(N)) u_mul2 (
    .a(X[4]),
    .b(X[5]),
    .product(p3)
);
logic [2*N+2:0] ext_p1, ext_p2, ext_p3;
assign ext_p1 = {3'b000, p1};
assign ext_p2 = {3'b000, p2};
assign ext_p3 = {3'b000, p3};


assign result = ext_p1 + ext_p2 + ext_p3;
endmodule
