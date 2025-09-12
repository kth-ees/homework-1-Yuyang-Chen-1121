module bin2gray (
  input logic [3:0] binary,
  output logic [3:0] gray
);
always_comb begin
    case(binary)
        4'd0:gray=4'b0000;
        4'd1:gray=4'b0001;
        4'd2:gray=4'b0011;
        4'd3:gray=4'b0010;
        4'd4:gray=4'b0110;
        4'd5:gray=4'b0111;
        4'd6:gray=4'b0101;
        4'd7:gray=4'b0100;
        4'd8:gray=4'b1100;
        4'd9:gray=4'b1101;
        4'd10:gray=4'b1111;
        4'd11:gray=4'b1110;
        4'd12:gray=4'b1010;
        4'd13:gray=4'b1011;
        4'd14:gray=4'b1001;
        4'd15:gray=4'b1000;
        default:gray=4'b0000;
    endcase
end
endmodule
