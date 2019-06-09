module mux2to1 #(parameter W=32)(out, in_1, in_2, select);

input [W-1:0] in_1, in_2;
output reg [W-1:0] out;
input select;

always @(in_1 or in_2 or select) 
	case(select)
	1'b0:	out = in_1;
	1'b1: out = in_2;
	endcase
endmodule