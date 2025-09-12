`timescale 1ns/1ps
module csa_8_tb;
  logic [7:0] a;
  logic [7:0] b;
  logic [7:0] sum;
  logic       carry;

  csa_8 dut (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
  );

  function automatic void golden(input logic [7:0] aa, input logic [7:0] bb,
                                 output logic [7:0] s, output logic c);
    logic [8:0] t;
    t = aa + bb;
    s = t[7:0];
    c = t[8];
  endfunction

  task automatic poke_and_check(input logic [7:0] aa, input logic [7:0] bb);
    logic [7:0] s_exp;
    logic       c_exp;
    a = aa; b = bb;
    #1;
    golden(aa, bb, s_exp, c_exp);
    assert (sum === s_exp)
      else $fatal(1, "[TB][%0t] SUM mismatch: a=%0d b=%0d exp=%0d got=%0d", $time, aa, bb, s_exp, sum);
    assert (carry === c_exp)
      else $fatal(1, "[TB][%0t] CARRY mismatch: a=%0d b=%0d exp=%0b got=%0b", $time, aa, bb, c_exp, carry);
  endtask

  initial begin
    poke_and_check(8'h00, 8'h00);
    poke_and_check(8'hFF, 8'h01);
    poke_and_check(8'h0F, 8'h01);
    poke_and_check(8'h10, 8'h10);
    poke_and_check(8'h7F, 8'h01);
    poke_and_check(8'h80, 8'h80);
    poke_and_check(8'hF0, 8'h10);
    poke_and_check(8'hAA, 8'h55);
    for (int k = 0; k < 200; k++) begin
      poke_and_check($urandom(), $urandom());
    end
    #5;
    $finish;
  end
endmodule
