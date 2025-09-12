module csa_8 (
  input logic [7:0] a, b,
  output logic [7:0] sum,
  output logic carry
);
logic C3,C07,C17,Cinc;
logic [3:0] S0,S1;

adder_4 u1_aader_4(
  .A(a[3:0]),
  .B(b[3:0]),
  .sum(sum[3:0]),
  .carry(C3)
);

adder_4 u2_aader_4(
  .A(a[7:4]),
  .B(b[7:4]),
  .sum(S0[3:0]),
  .carry(C07)
);

adder_4 u3_aader_4(
  .A(S0[3:0]),
  .B(4'b0001),
  .sum(S1[3:0]),
  .carry(Cinc)
);

assign C17 = C07 | Cinc;
assign sum[7:4] = (C3==1) ? S1 : S0;
assign carry    = (C3==1) ? C17 : C07;

endmodule



