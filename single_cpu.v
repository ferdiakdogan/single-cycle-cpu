// Copyright (C) 2017  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 17.1.0 Build 590 10/25/2017 SJ Lite Edition"
// CREATED		"Tue Mar 26 14:36:05 2019"

module single_cpu(
	clock,
	fifteen,
	we3,
	Zero,
	r0
);


input wire	clock;
input wire	[3:0] fifteen;
output wire	we3;
output wire	Zero;
output wire	[7:0] r0;

wire	[3:0] ALUFlags;
wire	[31:0] Instr;
wire	[1:0] RegSrc;
wire	SYNTHESIZED_WIRE_0;
wire	[31:0] SYNTHESIZED_WIRE_29;
wire	[31:0] SYNTHESIZED_WIRE_30;
wire	SYNTHESIZED_WIRE_3;
wire	[31:0] SYNTHESIZED_WIRE_4;
wire	[31:0] SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	[31:0] SYNTHESIZED_WIRE_31;
wire	[31:0] SYNTHESIZED_WIRE_32;
wire	SYNTHESIZED_WIRE_9;
wire	[31:0] SYNTHESIZED_WIRE_11;
wire	[31:0] SYNTHESIZED_WIRE_12;
wire	[31:0] SYNTHESIZED_WIRE_13;
wire	[1:0] SYNTHESIZED_WIRE_14;
wire	[31:0] SYNTHESIZED_WIRE_15;
wire	SYNTHESIZED_WIRE_17;
wire	[31:0] SYNTHESIZED_WIRE_18;
wire	[0:31] SYNTHESIZED_WIRE_19;
wire	[31:0] SYNTHESIZED_WIRE_33;
wire	SYNTHESIZED_WIRE_23;
wire	[3:0] SYNTHESIZED_WIRE_24;
wire	[3:0] SYNTHESIZED_WIRE_25;
wire	[31:0] SYNTHESIZED_WIRE_26;
wire	[1:0] SYNTHESIZED_WIRE_28;

assign	we3 = SYNTHESIZED_WIRE_23;
assign	SYNTHESIZED_WIRE_19 = 0;




mux2to1	b2v_inst(
	.select(SYNTHESIZED_WIRE_0),
	.in_1(SYNTHESIZED_WIRE_29),
	.in_2(SYNTHESIZED_WIRE_30),
	.out(SYNTHESIZED_WIRE_15));
	defparam	b2v_inst.W = 32;


mux2to1	b2v_inst10(
	.select(SYNTHESIZED_WIRE_3),
	.in_1(SYNTHESIZED_WIRE_4),
	.in_2(SYNTHESIZED_WIRE_5),
	.out(SYNTHESIZED_WIRE_13));
	defparam	b2v_inst10.W = 32;


data_memory	b2v_inst12(
	.clock(clock),
	.WE(SYNTHESIZED_WIRE_6),
	.ALUResult(SYNTHESIZED_WIRE_31),
	.WriteData(SYNTHESIZED_WIRE_32),
	.ReadData(SYNTHESIZED_WIRE_11));
	defparam	b2v_inst12.ADDR_WIDTH = 32;
	defparam	b2v_inst12.DATA_WIDTH = 32;


mux2to1	b2v_inst13(
	.select(SYNTHESIZED_WIRE_9),
	.in_1(SYNTHESIZED_WIRE_31),
	.in_2(SYNTHESIZED_WIRE_11),
	.out(SYNTHESIZED_WIRE_30));
	defparam	b2v_inst13.W = 32;


alu	b2v_inst14(
	.A(SYNTHESIZED_WIRE_12),
	.B(SYNTHESIZED_WIRE_13),
	.cntl(SYNTHESIZED_WIRE_14),
	.CO(ALUFlags[1]),
	.OVF(ALUFlags[0]),
	.N(ALUFlags[3]),
	.Z(ALUFlags[2]),
	.out(SYNTHESIZED_WIRE_31));
	defparam	b2v_inst14.W = 32;


program_counter	b2v_inst2(
	.clock(clock),
	.in(SYNTHESIZED_WIRE_15),
	.out(SYNTHESIZED_WIRE_33));


barrel_shifter	b2v_inst21(
	.control(Instr[11:5]),
	.in(SYNTHESIZED_WIRE_32),
	.out(SYNTHESIZED_WIRE_4));


controller_sc	b2v_inst22(
	.clock(clock),
	.ALUFlags(ALUFlags),
	.Cond(Instr[31:28]),
	.Funct(Instr[25:20]),
	.Op(Instr[27:26]),
	.Rd(Instr[15:12]),
	.PCSrc(SYNTHESIZED_WIRE_0),
	.RegWrite(SYNTHESIZED_WIRE_23),
	.MemWrite(SYNTHESIZED_WIRE_6),
	.MemtoReg(SYNTHESIZED_WIRE_9),
	.ALUSrc(SYNTHESIZED_WIRE_3),
	.ALUSrcA(SYNTHESIZED_WIRE_17),
	.ALUControl(SYNTHESIZED_WIRE_14),
	.ImmSrc(SYNTHESIZED_WIRE_28),
	.RegSrc(RegSrc));


mux2to1	b2v_inst23(
	.select(SYNTHESIZED_WIRE_17),
	.in_1(SYNTHESIZED_WIRE_18),
	.in_2(SYNTHESIZED_WIRE_19),
	.out(SYNTHESIZED_WIRE_12));
	defparam	b2v_inst23.W = 32;



instruction_memory	b2v_inst3(
	.in(SYNTHESIZED_WIRE_33),
	.out(Instr));
	defparam	b2v_inst3.ADDR_WIDTH = 32;
	defparam	b2v_inst3.DATA_WIDTH = 32;


adder	b2v_inst4(
	.in(SYNTHESIZED_WIRE_33),
	.out(SYNTHESIZED_WIRE_29));


adder	b2v_inst5(
	.in(SYNTHESIZED_WIRE_29),
	.out(SYNTHESIZED_WIRE_26));


mux2to1	b2v_inst6(
	.select(RegSrc[0]),
	.in_1(Instr[19:16]),
	.in_2(fifteen),
	.out(SYNTHESIZED_WIRE_24));
	defparam	b2v_inst6.W = 4;


mux2to1	b2v_inst7(
	.select(RegSrc[1]),
	.in_1(Instr[3:0]),
	.in_2(Instr[15:12]),
	.out(SYNTHESIZED_WIRE_25));
	defparam	b2v_inst7.W = 4;


register_file	b2v_inst8(
	.clock(clock),
	.we3(SYNTHESIZED_WIRE_23),
	.a1(SYNTHESIZED_WIRE_24),
	.a2(SYNTHESIZED_WIRE_25),
	.a3(Instr[15:12]),
	.r15(SYNTHESIZED_WIRE_26),
	.wd3(SYNTHESIZED_WIRE_30),
	.r0(r0),
	.rd1(SYNTHESIZED_WIRE_18),
	.rd2(SYNTHESIZED_WIRE_32));


extend	b2v_inst9(
	.ExtIn(Instr[23:0]),
	.ImmSrc(SYNTHESIZED_WIRE_28),
	.ExtImm(SYNTHESIZED_WIRE_5));

assign	Zero = ALUFlags[2];

endmodule
