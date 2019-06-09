module register_file (
	clock, a1, a2, a3, wd3, r15, we3, rd1, rd2, r0
);

	input clock, we3;
	input [3:0] a1, a2, a3;
	input [31:0] wd3, r15;
	output [31:0] rd1, rd2;
	output [7:0] r0;
	
	reg [31:0] register [15:0];
	
	/*initial begin
		register[0] = 32'b00000000000000000000000000000001; //1
		register[1] = 32'b00000000000000000000000000000010; //2
		register[2] = 32'b00000000000000000000000000000011; //3
		register[3] = 32'b00000000000000000000000000000100; //4
		register[4] = 32'b00000000000000000000000000000101; //5
		register[5] = 32'b00000000000000000000000000000110; //6
		register[6] = 32'b00000000000000000000000000000111; //7
		register[7] = 32'b00000000000000000000000000001000; //8
		register[8] = 32'b00000000000000000000000000001001; //9
		register[9] = 32'b00000000000000000000000000001010; //10
	end*/
	
	assign rd1 = register[a1];
	assign rd2 = register[a2];
	assign r0 = register[0][7:0];

	
	always @(posedge clock) begin
		register[15] <= r15;
		if (we3) begin
			register[a3] <= wd3;
		end
	end
	
endmodule
		
		