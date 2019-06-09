module extend (
	ImmSrc, ExtIn, ExtImm
);
	
	input [1:0] ImmSrc;
	input [23:0] ExtIn;
	output reg [31:0] ExtImm;
	
	always @(ImmSrc) begin
	
		case(ImmSrc) 
			2'b00: ExtImm = {24'b0, ExtIn[7:0]};
			2'b01: ExtImm = {20'b0, ExtIn[11:0]};
			2'b10: ExtImm = {{6{ExtIn[23]}}, ExtIn[23:0], 2'b00};
		endcase
		
	end
	
endmodule