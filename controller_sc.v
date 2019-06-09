module controller_sc (
	clock, Cond, ALUFlags, Op, Funct, Rd, PCSrc, RegWrite, MemWrite, MemtoReg, ALUSrc, 
	ImmSrc, RegSrc, ALUControl, ALUSrcA
);

	input clock;
	input [3:0] Cond, ALUFlags, Rd;
	input [1:0] Op;
	input [5:0] Funct;
	output PCSrc, RegWrite, MemWrite, MemtoReg, ALUSrc, ALUSrcA;
	output [1:0] ImmSrc, RegSrc, ALUControl;
	
	wire [1:0] FlagW, FlagWrite;
	wire PCS, RegW, MemW, Branch, ALUOp, NoWrite, CondEx;
	reg [3:0] Flags;
	
	//Main Decoder
	assign Branch = Op[1] & Op[0];
	assign MemtoReg = ~Op[1] & Op[0] & Funct[0];
	assign MemW = ~Op[1] & Op[0] & ~Funct[0];
	assign ALUSrc = Op[1] | Op[0] | Funct[5];
	assign ALUSrcA = (Op == 2'b00) & (Funct[4:1] == 4'b1101);
	assign ImmSrc[1] = Op[1] & Op[0];
	assign ImmSrc[0] = ~Op[1] & Op[0];
	assign RegW = (~Op[1] & ~Op[0]) | (~Op[1] & Op[0] & Funct[0]);
	assign RegSrc[1] = ~Op[1] & Op[0] & ~Funct[0];
	assign RegSrc[0] = Op[1] & Op[0];
	assign ALUOp = ~Op[1] & ~Op[0];
	
	//ALU Decoder
	assign ALUControl[1] = ALUOp & ((~Funct[4] & ~Funct[3] & ~Funct[2] & ~Funct[1])|(Funct[4] & Funct[3] & ~Funct[2] & ~Funct[1]));
	assign ALUControl[0] = ALUOp & ((~Funct[4] & ~Funct[3] & Funct[2] & ~Funct[1])|(Funct[4] & Funct[3] & ~Funct[2] & ~Funct[1])|(Funct[4] & ~Funct[3] & Funct[2] & ~Funct[1]));
	assign FlagW[1] = ALUOp & Funct[0];
	assign FlagW[0] = ALUOp & Funct[0] & ((~Funct[4] & Funct[3] & ~Funct[2] & ~Funct[1])|(~Funct[4] & ~Funct[3] & Funct[2] & ~Funct[1])|(Funct[4] & ~Funct[3] & Funct[2] & ~Funct[1]));
	assign NoWrite = ALUOp & Funct[0] & Funct[4] & ~Funct[3] & Funct[2] & ~Funct[1];
	
	//PC Logic
	assign PCS = ((Rd == 15) & RegW) | Branch;
	
	//Conditional Logic
	assign CondEx =((Cond == 4'b0000)&Flags[2])|((Cond == 4'b0001)&~Flags[2])|
	((Cond == 4'b0010)&Flags[1])|((Cond == 4'b0011)&~Flags[1])|
	((Cond == 4'b0100)&Flags[3])|((Cond == 4'b0101)&~Flags[3])|
	((Cond == 4'b0110)&Flags[0])|((Cond == 4'b0111)&~Flags[0])|
	((Cond == 4'b1000)&~Flags[2]&Flags[1])|((Cond == 4'b1001)&(Flags[2]|
	~Flags[1]))|((Cond == 4'b1010)&~(Flags[3]^Flags[0]))|
	((Cond == 4'b1011)&(Flags[3]^Flags[0]))|
	((Cond == 4'b1100)&(~Flags[2]&~(Flags[3]^Flags[0])))|
	((Cond == 4'b1101)&(Flags[2]|(Flags[3]^Flags[0])))|(Cond==4'b1110);
	assign PCSrc = PCS & CondEx;
	assign RegWrite = RegW & ~NoWrite & CondEx;
	assign MemWrite = MemW & CondEx;
	assign FlagWrite[1] = FlagW[1] & CondEx;
	assign FlagWrite[0] = FlagW[0] & CondEx;
	
	always @(posedge clock) begin
		if(FlagWrite[1])
			Flags[3:2] <= ALUFlags[3:2];
		if(FlagWrite[0])
			Flags[1:0] <= ALUFlags[1:0];
	end
	
endmodule	