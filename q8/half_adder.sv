module half_adder(
    input a,b,
    output c_out,s
);
assign s = a^b;
assign c_out = a&b;
endmodule
