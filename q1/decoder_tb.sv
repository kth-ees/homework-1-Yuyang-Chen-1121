// decoder_tb.sv
`timescale 1ns/1ps

module decoder_tb;

  // Testbench signals
  logic [3:0] binary;
  logic [15:0] one_hot;


  decoder uut (
    .binary(binary),
    .one_hot(one_hot)
  );

  function automatic logic [15:0] golden(input logic [3:0] a);
    logic [15:0] v;
    v = '0;
    v[a] = 1'b1;
    return v;
  endfunction

  task automatic poke_and_check(input logic [3:0] a);
    logic [15:0] exp;
    binary = a;
    #1;
    exp = golden(a);
    if (one_hot !== exp) begin
      $error("[TB][%0t] MISMATCH a=%0d exp=%016b got=%016b", $time, a, exp, one_hot);
      $fatal(1);
    end
  endtask

  initial begin
    $display("[TB] Start exhaustive check 0..15");
    for (int i = 0; i < 16; i++) begin
      poke_and_check(i[3:0]);
    end

    $display("[TB] Random regression");
    for (int k = 0; k < 50; k++) begin
      poke_and_check($urandom_range(0,15));
    end

    $display("[TB] All tests passed.");
    #5;
    $finish;
  end

endmodule
