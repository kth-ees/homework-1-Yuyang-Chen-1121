module bin2bcd(
	input logic [3:0] binary,
	output logic [3:0] bcd,
	output logic carry
);
//An easier way
//assign carry = (binary<=9)?0:1;
//assign bcd = (binary<=9)?binary:binary-4'd10;

//Using 16-to-1 multiplexer
always_comb begin
	case(binary)
		4'd0: begin
			bcd = 4'd0;
			carry=1'b0;
		end
		4'd1: begin
			bcd = 4'd1;
			carry=1'b0;
		end
		4'd2: begin
			bcd = 4'd2;
			carry=1'b0;
		end
		4'd3: begin
			bcd = 4'd3;
			carry=1'b0;
		end
		4'd4: begin
			bcd = 4'd4;
			carry=1'b0;
		end
		4'd5: begin
			bcd = 4'd5;
			carry=1'b0;
		end
		4'd6: begin
			bcd = 4'd6;
			carry=1'b0;
		end
		4'd7: begin
			bcd = 4'd7;
			carry=1'b0;
		end
		4'd8: begin
			bcd = 4'd8;
			carry=1'b0;
		end
		4'd9: begin
			bcd = 4'd9;
			carry=1'b0;
		end
		4'd10: begin
			bcd = 4'd0;
			carry=1'b1;
		end
		4'd11: begin
			bcd = 4'd1;
			carry=1'b1;
		end
		4'd12: begin
			bcd = 4'd2;
			carry=1'b1;
		end
		4'd13: begin
			bcd = 4'd3;
			carry=1'b1;
		end
		4'd14: begin
			bcd = 4'd4;
			carry=1'b1;
		end
		4'd15: begin
			bcd = 4'd5;
			carry=1'b1;
		end
        default:begin
            bcd=4'd0;
            carry=1'b0;
        end
    endcase
end
endmodule
