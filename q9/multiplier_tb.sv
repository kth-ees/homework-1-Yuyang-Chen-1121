`timescale 1ns/1ps
module multiplier_tb;
  logic [15:0] a;
  logic [15:0] b;
  logic [31:0] product;

  multiplier dut (
    .a(a),
    .b(b),
    .product(product)
  );

  function automatic logic [31:0] golden(input logic [15:0] aa, input logic [15:0] bb);
    return $unsigned(aa) * $unsigned(bb);
  endfunction

  task automatic poke_and_check(input logic [15:0] aa, input logic [15:0] bb);
    logic [31:0] e;
    a = aa; b = bb;
    #1;
    e = golden(aa, bb);
    assert (product === e)
      else $fatal(1, "[TB][%0t] mismatch: a=%0d b=%0d exp=%0d got=%0d", $time, aa, bb, e, product);
  endtask

  initial begin
    poke_and_check(16'h0000, 16'h0000);
    poke_and_check(16'h0001, 16'h0001);
    poke_and_check(16'hFFFF, 16'h0001);
    poke_and_check(16'h00FF, 16'h00FF);
    poke_and_check(16'h8000, 16'h0002);
    poke_and_check(16'hFFFF, 16'hFFFF);
    for (int k=0;k<300;k++) begin
      poke_and_check($urandom(), $urandom());
    end
    #5;
    $finish;
  end
endmodule
