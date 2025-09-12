`timescale 1ns/1ps
module sum_prod_tb;
  localparam N = 4;
  logic [N-1:0] X [5:0];
  logic [2*N+2:0] result;

  sum_prod #(.N(N)) dut (
    .X(X),
    .result(result)
  );

  task automatic poke(input logic [N-1:0] x0,input logic [N-1:0] x1,input logic [N-1:0] x2,input logic [N-1:0] x3,input logic [N-1:0] x4,input logic [N-1:0] x5);
    logic [2*N-1:0] p1,p2,p3;
    logic [2*N+2:0] e;
    X[0]=x0; X[1]=x1; X[2]=x2; X[3]=x3; X[4]=x4; X[5]=x5;
    #1;
    p1 = x0 * x1;
    p2 = x2 * x3;
    p3 = x4 * x5;
    e = {3'b000,p1} + {3'b000,p2} + {3'b000,p3};
    assert (result === e)
      else $fatal(1,"[TB][%0t] mismatch exp=%0d got=%0d", $time, e, result);
  endtask

  initial begin
    poke('0,'0,'0,'0,'0,'0);
    poke('0,{N{1'b1}},'0,{N{1'b1}},'0,{N{1'b1}});
    poke({N{1'b1}},{N{1'b1}},{N{1'b1}},'0,{N{1'b1}},1);
    for (int k=0;k<200;k++) begin
      poke($urandom(),$urandom(),$urandom(),$urandom(),$urandom(),$urandom());
    end
    #5;
    $finish;
  end
endmodule
