`timescale 1ns/1ps
module bin2gray_tb;

  // Inputs
  logic [3:0] binary;

  // Outputs
  logic [3:0] gray;

  bin2gray dut (
    .binary(binary),
    .gray(gray)
  );

  function automatic logic [3:0] golden(input logic [3:0] x);
    return x ^ (x >> 1);
  endfunction

  task automatic poke_and_check(input logic [3:0] x);
    logic [3:0] e;
    binary = x;
    #1;
    e = golden(x);
    assert (gray === e)
      else $fatal(1, "[TB][%0t] mismatch: bin=%0d exp=%0d got=%0d", $time, x, e, gray);
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
