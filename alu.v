module alu #(parameter W=32) ( A, B, out, CO, OVF, N, Z, cntl);

	input [W-1:0] A, B;
	input [1:0] cntl;
	output reg [W-1:0] out;
	output reg CO, OVF, N, Z;
	
	
initial begin
	CO = 0;
	OVF = 0;
	N = 0;
	Z = 0;
end
	
always @(A, B, cntl) begin

	case(cntl)
	2'b00:	begin //add
		{CO,out} = A + B;
		N = out[W-1];
		if (out == 0)
			Z = 1;
		else 
			Z = 0;
		if ((A[W-1]==0&&B[W-1]==0&&out[W-1]==1)||(A[W-1]==1&&B[W-1]==1&&out[W-1]==0))
			OVF = 1;
		else
			OVF = 0;
	end
	2'b01:	begin //subtract A - B
		{CO,out} = A - B;
		N = out[W-1];
		if (out == 0)
			Z = 1;
		else 
			Z = 0;
		if ((A[W-1]==0&&B[W-1]==1&&out[W-1]==1)||(A[W-1]==1&&B[W-1]==0&&out[W-1]==0))
			OVF = 1;
		else
			OVF = 0;
	end
	
	2'b10:	begin //And
		out = A & B;
		N = out[W-1];
		if (out == 0)
			Z = 1;
		else 
			Z = 0;
		CO = 0;
		OVF = 0;
			
	end
	2'b11:	begin	//Or
		out = A | B;
		N = out[W-1];
		if (out == 0)
			Z = 1;
		else 
			Z = 0;
		CO = 0;
		OVF = 0;
	end
	default: begin //Default
		CO = 0;
		OVF = 0;
		N = 0;
		Z = 0;
	end
	endcase
	end
endmodule