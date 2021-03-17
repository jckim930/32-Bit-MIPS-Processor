`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2019 08:06:00 PM
// Design Name: 
// Module Name: ALUControl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALUControl(
    output reg [5:0]ALUcnt,
    input [6:0] ALUOp,
    input [5:0] funct
    );
    
    reg [11:0]temp;
   
    always @(*)begin
         temp = {ALUOp[6:1],funct};
         
         casex({temp})
//___________Arithmetics General_________________________________________________         
            // Arithmetics: ADD, ADDU, ADDI, ADDIU,
            12'b000000100000 : ALUcnt <= 6'b000000;//ADD
            12'b001001xxxxxx : ALUcnt <= 6'b000000;//ADDIU
            12'b000000100001 : ALUcnt <= 6'b000000;//ADDU
            12'b001000xxxxxx : ALUcnt <= 6'b000000;//ADDI
            
            12'b000000100010 : ALUcnt <= 6'b000001;//SUB
            //Multiplications
            12'b011100000010 : ALUcnt <= 6'b000010;//MUl
            // Arithmetics : MULT, MULTU
            12'b000000011000 : ALUcnt <= 6'b011000;//MULT
            12'b000000011001 : ALUcnt <= 6'b000011;//MULTU
            
            // Arithmetics: MADD
            12'b011100000000 : ALUcnt <= 6'b000100;//MADD
            
            // Arithmetics: MSUB
            12'b011100000100 : ALUcnt <= 6'b000101;//MSUB
//___________End Arithmetics______________________________________________________

//___________LOGICALS GENERAL____________________________________________________
            // Logicals: AND, ANDI....IMMEDIATE ZERO EXTENDED
            12'b000000100100 : ALUcnt <= 6'b000110;//AND
            12'b001100xxxxxx : ALUcnt <= 6'b000110;//ANDI
            
            //Logicals: OR & ORI...IMMEDIATE IS ZERO EXTENDED
            12'b000000100101 : ALUcnt <= 6'b000111;//OR
            12'b001101xxxxxx : ALUcnt <= 6'b000111;//ORI
            
            // Logicals: NOR
            12'b000000100111 : ALUcnt <= 6'b001000;//NOR
            
            // Logicals: XOR, XORI
            12'b000000100110 : ALUcnt <= 6'b001001;//XOR
            12'b001110xxxxxx : ALUcnt <= 6'b001001;//XORI
            
            // Logicals: SLL, SLLV
            12'b000000000000 : ALUcnt <= 6'b001010;//SLL
            12'b000000000100 : ALUcnt <= 6'b001010;//SLV
            
            // Logicals: SRL, SRL
            12'b000000000010 :begin
                case({ALUOp[0]})
                1'b0 : ALUcnt <= 6'b001011;//SRL
                1'b1 : ALUcnt <= 6'b001111;//ROTR
                endcase
             end
            12'b000000000110 :begin
                case({ALUOp[0]})
                1'b0 : ALUcnt <= 6'b001011;//SRL
                1'b1 : ALUcnt <= 6'b001111;//ROTRV
                endcase
             end
            
            // Logicals: SLT, SLTI
            12'b000000101010 : ALUcnt <= 6'b001100;//SLT
            12'b001010xxxxxx : ALUcnt <= 6'b001100;//SLTI
            
            // Logicals: MOVN
            12'b000000001011 : ALUcnt <= 6'b001101;//MOVN
            
            // Logicals: MOVZ
            12'b000000001010 : ALUcnt <= 6'b001110;//MOVZ
            
            // Logicals: ROTRV, ROTR ASSUMES B IS RT
            //12'b000000000010 : ALUcnt <= 5'b01111;//ROTR
            //12'b000000000110 : ALUcnt <= 5'b01111;//ROTRV
            
            // Logicals : SRA, SRAV
            12'b000000000011 : ALUcnt <= 6'b010000;//SRA
            12'b000000000111 : ALUcnt <= 6'b010000;//SRAV
            
            // Logicals : SEB, SEH
            12'b011111100000 : begin
                case({ALUOp[0]})
                1'b0 : ALUcnt <= 6'b010010;//SEH
                1'b1 : ALUcnt <= 6'b010001;//SEB
                endcase
            end
            
            //PLACE HOLDER SLTU SLTIU
            12'b001011xxxxxx : ALUcnt <= 6'b010011;//SLTIU
            12'b000000101011 : ALUcnt <= 6'b010011;//SLTU
            
            // Data: MTHI
            12'b000000010001 : ALUcnt <= 6'b010100;//MTHI
            
            // Data: MTLO
            12'b000000010011 : ALUcnt <= 6'b010101;//MTLO
            
            // Data: MFHI
            12'b000000010000 : ALUcnt <= 6'b010110;//MFHI
            
            // Data: MFLO
            12'b000000010010 : ALUcnt <= 6'b010111;//MFLO
            
//______________________SW/LW_________________________________________            
            12'b100011xxxxxx : ALUcnt <= 6'b000000;//LW
            
            12'b101011xxxxxx : ALUcnt <= 6'b000000;//SW
            
            12'b101000xxxxxx : ALUcnt <= 6'b000000;//SB
            
            12'b100001xxxxxx : ALUcnt <= 6'b000000;//LH
            
            12'b100000xxxxxx : ALUcnt <= 6'b000000;//LB
            
            12'b101001xxxxxx : ALUcnt <= 6'b000000;//SH
            
//_______________________Branches______________________________________________
            
            12'b000001xxxxxx :begin
                case(ALUOp[0])
                1'b0 : ALUcnt <= 6'b011001;//BGEZ
                1'b1 : ALUcnt <= 6'b011110;//BLTZ
                endcase
            end
            
            12'b000100xxxxxx : ALUcnt <= 6'b011010;//BEQ
            
            12'b000101xxxxxx : ALUcnt <= 6'b011011;//BNE
            
            12'b000111xxxxxx : ALUcnt <= 6'b011100;//BGTZ
            
            12'b000110xxxxxx : ALUcnt <= 6'b011101;//BLEZ
            
//________________________JUMPS________________________________________________________            
            
            12'b000010xxxxxx: ALUcnt <= 6'b011111;//J
            
            12'b000011xxxxxx: ALUcnt <= 6'b011111;//JAL
            
            12'b000000001000: ALUcnt <= 6'b011111;//JR
            //LUI******************************************
            
            12'b001111xxxxxx: ALUcnt <= 6'b100000;//LUI
            
            
         endcase
    end 

endmodule
