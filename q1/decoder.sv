module decoder(
    input logic [3:0] binary,
    output logic [15:0] one_hot
);

always_comb begin
	case(binary)
		4'd0: one_hot = 16'b0000_0000_0000_0001;
		4'd1: one_hot = 16'b0000_0000_0000_0010;
		4'd2: one_hot = 16'b0000_0000_0000_0100;
		4'd3: one_hot = 16'b0000_0000_0000_1000;
		4'd4: one_hot = 16'b0000_0000_0001_0000;
		4'd5: one_hot = 16'b0000_0000_0010_0000;
		4'd6: one_hot = 16'b0000_0000_0100_0000;
		4'd7: one_hot = 16'b0000_0000_1000_0000;
		4'd8: one_hot = 16'b0000_0001_0000_0000;
		4'd9: one_hot = 16'b0000_0010_0000_0000;
		4'd10: one_hot = 16'b0000_0100_0000_0000;
		4'd11: one_hot = 16'b0000_1000_0000_0000;
		4'd12: one_hot = 16'b0001_0000_0000_0000;
		4'd13: one_hot = 16'b0010_0000_0000_0000;
		4'd14: one_hot = 16'b0100_0000_0000_0000;
		4'd15: one_hot = 16'b1000_0000_0000_0000;
		default:one_hot = 16'b0000_0000_0000_0000;
    endcase
end

endmodule
