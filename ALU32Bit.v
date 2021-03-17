`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: N-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.red
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports all arithmetic operations 
// needed by the MIPS instructions given in Labs5-8.docx document. 
//   The 'ALUResult' will output the corresponding result of the operation 
//   based on the 32-Bit inputs, 'A', and 'B'. 
//   The 'Zero' flag is high when 'ALUResult' is '0'. 
//   The 'ALUControl' signal should determine the function of the ALU 
//   You need to determine the bitwidth of the ALUControl signal based on the number of 
//   operations needed to support. 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(
	output reg [31:0] ALUResult,	// answer
	output Zero,	    // Zero=1 if ALUResult == 0
	output reg [31:0] HIOut,
	output reg [31:0] LOOut,
	input [5:0] ALUControl, // control bits for ALU operation                              // you need to adjust the bitwidth as needed
	input [31:0] A,	    // inputs
	input [31:0] B,		// inputs
	input [31:0] HI,
	input [31:0] LO
);
    reg [63:0] temp;
    
	assign Zero = ALUResult ? 0 : 1;

	always @* begin
	   HIOut = HI;
	   LOOut = LO;
	   case(ALUControl)
	       // Arithmetics: ADD, ADDU, ADDI, ADDIU,
	       // Logicals: LW, SW, SB, LH, LB, SH
	       6'b000000 : begin 
	           temp = A + B; 
	           ALUResult = temp[31:0];
	        end
	       // Arithmetics: SUB
	       6'b000001 : begin
	           temp = A - B;
	           ALUResult =  temp[31:0];
	       end
	       // Arithmetics: MUL
	       6'b000010 : begin // MUL
	           temp = A * B;
	           ALUResult = temp[31:0];
	       end
		   // Arithmetics : MULTU
	       6'b000011 : begin
	           temp = A * B;
	           HIOut <= temp[63:32];
	           LOOut <= temp[31:0];
	       end
	       // Arithmetics: MADD
	       6'b000100 : begin
	           temp = {HI, LO};
	           temp = $signed(temp) + ($signed(A) * $signed(B));
	           HIOut <= temp[63:32];
	           LOOut <= temp[31:0];
	       end
	       // Arithmetics: MSUB
	       6'b000101 : begin
	           temp = {HI, LO};
	           temp = $signed(temp) - ($signed(A) * $signed(B));
	           HIOut <= temp[63:32];
	           LOOut <= temp[31:0];
	       end
           // Logicals: AND, ANDI....IMMEDIATE ZERO EXTENDED
	       6'b000110 : begin // AND & ANDI...IMMEDIATE IS ZERO EXTENDED
	           ALUResult = A & B;
	       end
	       //Logicals: OR & ORI...IMMEDIATE IS ZERO EXTENDED
	       6'b000111 : begin 
	           ALUResult = A | B;
	       end
	       // Logicals: NOR
	       6'b001000 : begin 
	           ALUResult = ~(A | B);
	       end
	       // Logicals: XOR, XORI
	       6'b001001 : begin 
	           ALUResult = A ^ B;
	       end
	       // Logicals: SLL, SLLV
	       6'b001010 : begin 
	           ALUResult = B << A;
	       end
	       // Logicals: SRL, SRLV
	       6'b001011 : begin 
	           ALUResult = B >> A;
	       end
	       // Logicals: SLT, SLTI
	       6'b001100 : begin
	           ALUResult = ($signed(A) < $signed(B)) ? 1 : 0;
	       end
		   // Logicals: MOVN
	       6'b001101 : begin
				ALUResult = B ? A : 0;  
		   end
		   // Logicals: MOVZ
		   6'b001110 : begin
				ALUResult = B ? 0 : A;
		   end
		   // Logicals: ROTRV, ROTR ASSUMES B IS RT
		   6'b001111 : begin
				ALUResult = ((B >> A) | (B << (32 - A)));
		   end
		   // Logicals : SRA, SRAV
		   6'b010000 : begin
				ALUResult = B >>> A;
		   end
		   // Logicals : SEB
		   6'b010001 : begin
				ALUResult = { {24{B[7]}}, B[7:0] };
		   end
		   // Logicals: SEH
		   6'b010010 : begin
				ALUResult = { {16{B[15]}}, B[15:0] };
		   end
		   // Logicals: SLTU/SLTIU
		   6'b010011 : begin
		      ALUResult = (A < B) ? 1 : 0;
		   end
		   // Data: MTHI
		   6'b010100 : begin
		      HIOut = A;
		   end
		   // Data: MTLO
		   6'b010101 : begin
		      LOOut = A;
		   end
		   // Data: MFHI
		   6'b010110 : begin
		      ALUResult = HI; 
		   end
		   // Data: MFLO
		   6'b010111 : begin
		      ALUResult = LO;
		   end
		   // Arithmetic: MULT
		   6'b011000 : begin
	           temp = $signed(A) * $signed(B);
	           HIOut <= temp[63:32];
	           LOOut <= temp[31:0];
	       end
		   
	       // Logicals: BGEZ
	       6'b011001 : begin
	           ALUResult = (A >= 0) ? 0 : 1;
	       end
	       // Logicals: BEQ
	       6'b011010 : begin
	           ALUResult = (A == B) ? 0 : 1;
	       end
		   // Logicals: BNE
	       6'b011011 : begin
	           ALUResult = (A != B) ? 0 : 1;
	       end
	       // BGTZ
	       6'b011100 : begin
	           ALUResult = (A > 0) ? 0 : 1;
	       end
	       // BLEZ
	       6'b011101 : begin
	           ALUResult = (A <= 0) ? 0 : 1;
	       end
	       // BLTZ
	       6'b011110 : begin
	           ALUResult = (A < 0) ? 0 : 1;
	       end
	       // J, JR, JAL
	       6'b011111 : begin
	           ALUResult = 'b0;
	       end
	       // lui
	       6'b100000 : begin
	           ALUResult[31:16] = A;
	           ALUResult[15:0] = 'b0;
	       end
	   endcase 
	end
endmodule

