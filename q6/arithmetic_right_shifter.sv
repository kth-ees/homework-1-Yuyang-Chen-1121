module arithmetic_right_shifter #(parameter N) (
  input logic [N-1:0] input_data,
  input logic [1:0] control,
  output logic [N-1:0] shifted_result
);
always_comb begin
    case(control)
        2'd0:shifted_result=input_data;
        2'd1:shifted_result={input_data[N-1],input_data[N-1:1]};
        2'd2:shifted_result={{2{input_data[N-1]}},input_data[N-1:2]};
        2'd3:shifted_result={{3{input_data[N-1]}},input_data[N-1:3]};
        default:shifted_result=input_data;
    endcase
end
endmodule
