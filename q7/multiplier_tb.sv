`timescale 1ns/1ps
module multiplier_tb;

  localparam N = 4;
  logic [N-1:0] a;
  logic [N-1:0] b;
  logic [2*N-1:0] product;

  multiplier #(.N(N)) dut (
    .a(a),
    .b(b),
    .product(product)
  );


  function automatic logic [2*N-1:0] golden(input logic [N-1:0] aa, input logic [N-1:0] bb);
    return $unsigned(aa) * $unsigned(bb);
  endfunction
  
  task automatic poke_and_check(input logic [N-1:0] aa, input logic [N-1:0] bb);
    logic [2*N-1:0] e;
    a = aa; b = bb;
    #1;
    e = golden(aa, bb);
    assert (product === e)
      else $fatal(1, "[TB][%0t] mismatch: a=%0d b=%0d exp=%0d got=%0d", $time, $signed(aa), $signed(bb), $signed(e), $signed(product));
  endtask

  function automatic logic [N-1:0] toN(input int x);
    logic [N-1:0] r;
    r = x;             
    return r;
  endfunction


  initial begin
    poke_and_check(toN(0), toN(0));
    poke_and_check(toN(1), toN(1));
    poke_and_check(toN(-1), toN(1));
    poke_and_check(toN(-1), toN(-1));
    poke_and_check(toN(2**(N-1)-1), toN(2**(N-1)-1));
    poke_and_check(toN(-(2**(N-1))), toN(1));
    poke_and_check(toN(-(2**(N-1))), toN(-(2**(N-1))));
    for (int k = 0; k < 200; k++) begin
      poke_and_check($urandom(), $urandom());
    end
    #5;
    $finish;
  end
endmodule
