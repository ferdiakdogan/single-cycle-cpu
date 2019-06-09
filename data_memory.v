module data_memory #(parameter ADDR_WIDTH = 32, DATA_WIDTH = 32)(
	clock, WE, ALUResult, WriteData, ReadData
);

	input clock, WE;
	input [DATA_WIDTH-1:0] ALUResult, WriteData;
	output [DATA_WIDTH-1:0] ReadData;
	
	reg [DATA_WIDTH-1:0] memory [0:(1<<ADDR_WIDTH)-1];
	
	assign ReadData = memory[ALUResult];
	
	always @(posedge clock)
		if (WE)
			memory[ALUResult] <= WriteData;

endmodule