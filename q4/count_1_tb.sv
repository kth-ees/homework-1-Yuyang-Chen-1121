`timescale 1ns/1ps
module count_1_tb;

  // Inputs
  logic [3:0] a;

  // Outputs
  logic [2:0] out;

  count_1 dut (
    .a(a),
    .out(out)
  );

  function automatic logic [2:0] golden(input logic [3:0] x);
    logic [2:0] r;
    r = $countones(x);
    return r;
  endfunction

  task automatic poke_and_check(input logic [3:0] x);
    logic [2:0] e;
    a = x;
    #1;
    e = golden(x);
    assert (out === e)
      else $fatal(1, "[TB][%0t] mismatch: a=%0d exp=%0d got=%0d", $time, x, e, out);
  endtask

  initial begin
    for (int i = 0; i < 16; i++) begin
      poke_and_check(i[3:0]);
    end
    for (int k = 0; k < 32; k++) begin
      poke_and_check($urandom());
    end
    #5;
    $finish;
  end
endmodule
