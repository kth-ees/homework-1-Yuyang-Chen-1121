// bin2bcd_tb.sv
`timescale 1ns/1ps

module bin2bcd_tb;

  // Testbench signals
  logic [3:0] binary;
  logic [3:0] bcd;
  logic carry;

  bin2bcd dut (
    .binary(binary),
    .bcd   (bcd),
    .carry (carry)
  );

  function automatic void golden(input  logic [3:0] a,
                                 output logic [3:0] bcd_exp,
                                 output logic       carry_exp);
    if (a <= 4'd9) begin
      carry_exp = 1'b0;
      bcd_exp   = a;
    end else begin
      carry_exp = 1'b1;
      bcd_exp   = a - 4'd10;
    end
  endfunction

  task automatic poke_and_check(input logic [3:0] a);
    logic [3:0] bcd_exp;
    logic       carry_exp;
    binary = a;
    #1;
    golden(a, bcd_exp, carry_exp);

    assert (bcd   === bcd_exp) else
      $fatal(1, "[TB][%0t] BCD mismatch: bin=%0d exp_bcd=%0d got_bcd=%0d",
                  $time, a, bcd_exp, bcd);
    assert (carry === carry_exp) else
      $fatal(1, "[TB][%0t] CARRY mismatch: bin=%0d exp_carry=%0b got_carry=%0b",
                  $time, a, carry_exp, carry);
  endtask

  initial begin
    $display("[TB] Exhaustive test 0..15");
    for (int i = 0; i < 16; i++) begin
      poke_and_check(i[3:0]);
    end

    $display("[TB] Random regression");
    for (int k = 0; k < 32; k++) begin
      poke_and_check($urandom_range(0,15));
    end

    $display("[TB] All tests passed.");
    #5;
    $finish;
  end

endmodule
