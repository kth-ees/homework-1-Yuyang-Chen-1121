`timescale 1ns/1ps
module arithmetic_right_shifter_tb;

  localparam N = 8;
  logic [N-1:0] input_data;
  logic [1:0] control;
  logic [N-1:0] shifted_result;

  arithmetic_right_shifter #(.N(N)) dut (
    .input_data(input_data),
    .control(control),
    .shifted_result(shifted_result)
  );

  function automatic logic [N-1:0] golden(input logic [N-1:0] d, input logic [1:0] c);
    logic [N-1:0] r;
    case (c)
      2'd0: r = d;
      2'd1: r = {d[N-1], d[N-1:1]};
      2'd2: r = {{2{d[N-1]}}, d[N-1:2]};
      2'd3: r = {{3{d[N-1]}}, d[N-1:3]};
      default: r = d;
    endcase
    return r;
  endfunction

  task automatic poke_and_check(input logic [N-1:0] d, input logic [1:0] c);
    logic [N-1:0] e;
    input_data = d;
    control = c;
    #1;
    e = golden(d, c);
    assert (shifted_result === e)
      else $fatal(1, "[TB][%0t] mismatch: in=%0d ctrl=%0d exp=%0d got=%0d", $time, d, c, e, shifted_result);
  endtask

  initial begin
    for (int c = 0; c < 4; c++) begin
      poke_and_check(8'h00, c[1:0]);
      poke_and_check(8'h01, c[1:0]);
      poke_and_check(8'h80, c[1:0]);
      poke_and_check(8'hFF, c[1:0]);
      poke_and_check(8'h7F, c[1:0]);
      poke_and_check(8'hAA, c[1:0]);
      poke_and_check(8'h55, c[1:0]);
    end
    for (int k = 0; k < 200; k++) begin
      poke_and_check($urandom(), $urandom());
    end
    #5;
    $finish;
  end
endmodule
