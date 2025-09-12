`include "mul4.sv"
module multiplier (
  input  logic [15:0]a,b,
  output logic [31:0] product
);

logic [3:0] a_blk [3:0];
logic [3:0] b_blk [3:0];
assign {a_blk[3], a_blk[2], a_blk[1], a_blk[0]} = a;
assign {b_blk[3], b_blk[2], b_blk[1], b_blk[0]} = b;

logic [7:0] pp [3:0][3:0];
genvar i,j;
generate
    for (i=0;i<4;i++) begin: bLOCK_a
        for (j=0;j<4;j++) begin: bLOCK_b
            mul4 u_mul4(.a(a_blk[i]), .b(b_blk[j]), .p(pp[i][j]));
        end
    end
endgenerate

logic [31:0] s [3:0][3:0];
generate
    for (i=0;i<4;i++) begin: SHIFT_I
        for (j=0;j<4;j++) begin: SHIFT_J
            localparam int SH = 4*(i+j);
            assign s[i][j] = {{(32-8){1'b0}}, pp[i][j]} << SH;
        end
    end
endgenerate

logic [31:0] l1 [7:0];
assign l1[0]=s[0][0]+s[0][1]; 
assign l1[1]=s[0][2]+s[0][3];
assign l1[2]=s[1][0]+s[1][1]; 
assign l1[3]=s[1][2]+s[1][3];
assign l1[4]=s[2][0]+s[2][1]; 
assign l1[5]=s[2][2]+s[2][3];
assign l1[6]=s[3][0]+s[3][1]; 
assign l1[7]=s[3][2]+s[3][3];

logic [31:0] l2 [3:0];
assign l2[0]=l1[0]+l1[1]; 
assign l2[1]=l1[2]+l1[3];
assign l2[2]=l1[4]+l1[5]; 
assign l2[3]=l1[6]+l1[7];

logic [31:0] l3 [1:0];
assign l3[0]=l2[0]+l2[1];
assign l3[1]=l2[2]+l2[3];

assign product = l3[0] + l3[1];

endmodule

