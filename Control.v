`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2019 01:36:47 PM
// Design Name: 
// Module Name: Control
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


module Control(Instruction, WB, M, EX, I,/*MemToReg,*/J,JAL,JR,Load_Store);
    input [31:0] Instruction;
    
    output reg[1:0] WB;
    output reg I;
    output reg [2:0]M;
    output reg [9:0] EX;//sends 10-bit signal of  1-bit SAmuxcontrol,1-bit ALUsrc, 1-bit Regdst, 6-bit OP,1-bit ID
    //output reg LWSW;
    //output reg MemToReg;
    output reg J;
    output reg JAL;
    output reg JR;
    output reg [1:0]Load_Store;
    
    
    initial begin
    M = 3'b000;
    I = 1'b0;
    //LWSW =1'b0;
   // MemToReg = 1'b1; 
    J = 1'b0;
    JAL = 1'b0;
    JR = 1'b0;
    EX = 0;
    Load_Store = 2'b00;
    
    end
    
    
   // reg [5:0]ALUop;
    always @(*)begin
        M = 3'b000;
        I = 1'b0;
        //LWSW =1'b0;
       // MemToReg = 1'b1; 
        J = 1'b0;
        JAL = 1'b0;
        JR = 1'b0;
        WB = 2'b10;
        Load_Store = 2'b00;
        ;
     
        case({Instruction[31:26]})
            6'b000000 :begin                
                case({Instruction[5:0]})
                    6'b011000 :begin
                    EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//MULT
                    WB <= 2'b10;
                    end
                    6'b011001 :begin
                    EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//MULTU
                    WB <= 2'b10;
                    end
                    6'b010001 :begin
                     EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0}; //MOVE TO HI FIGURE OUT LATER!!!!MTHI
                     WB <= 2'b10;
                     end
                    6'b010011 :begin
                     EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//MOVET TO LO ALSO FIGURE OUT LATER!!MTLO
                     WB <= 2'b10;
                     end
                    6'b010000 :begin
                     EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//Move from hi MFHI
                     WB <= 2'b11;
                     end
                    6'b010010 :begin
                     EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//move from lo MFLO
                     WB <= 2'b11;
                     end
                    6'b000000 :begin
                     EX <= {1'b1,1'b0,1'b1,Instruction[31:26],1'b0};//sll
                     WB <= 2'b11;
                     end
                    6'b000100 :begin
                     EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//sllv
                     WB <= 2'b11;
                     end
                    6'b000010 :begin
                       case(Instruction[21])
                       1'b0 :begin
                        EX <= {1'b1,1'b0,1'b1,Instruction[31:26],1'b0};//srl
                        WB <= 2'b11;
                        end
                        1'b1 : begin
                        EX <= {1'b1,1'b0,1'b1,Instruction[31:26],1'b1};//ROTR
                        WB <= 2'b11;
                        end
                        endcase
                     end
                    6'b000110 :begin
                    case(Instruction[6])
                    1'b0 : begin
                     EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//srlv
                     WB <= 2'b11;
                     end
                     1'b1 :begin
                     EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b1};//ROTRV
                     WB <= 2'b11;
                     end
                     endcase
                     end
                    6'b001011 :begin
                     EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//MOVN
                     WB <= 2'b11;
                     end
                    6'b001010 :begin
                     EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//MOVZ
                     WB <= 2'b11;
                     end
                    //6'b000010 :begin
                     //EX <= {1'b1,1'b0,1'b1,Instruction[31:26],1'b1};//ROTR
                     //WB <= 1'b1;
                     //end
                    //6'b000110 :begin
                     //EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b1};//ROTRV
                     //WB <= 1'b1;
                     //end
                    6'b000011 :begin
                     EX <= {1'b1,1'b0,1'b1,Instruction[31:26],1'b0};//SRA
                     WB <= 2'b11;
                     end
                    6'b000111 :begin
                     EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//SRAV
                     WB <= 2'b11;
                     end
                    6'b100000 :begin
                     EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//ADD
                     WB <= 2'b11;
                     end
                    6'b100001 :begin
                    EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//ADDU
                    WB <= 2'b11;
                    end
                    6'b100100 : begin
                    EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//AND
                    WB <= 2'b11;
                    end
                    6'b100101 :begin
                    EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//OR
                    WB <= 2'b11;
                    end
                    6'b100111 :begin
                    EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//NOR
                    WB <= 2'b11;
                    end
                    6'b100110 :begin
                     EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//XOR
                     WB <= 2'b11;
                    end
                    6'b101010 :begin
                    EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//SLT
                    WB <= 2'b11;
                    end
                    6'b101011 :begin
                    EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//SLTU
                    WB <= 2'b11;
                    end
                    6'b100010 :begin//new**
                    EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//SUB
                    WB <= 2'b11;
                    end
                    6'b001000 :begin
                    EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//JR*******************************
                    WB <= 2'b10;
                    M <=3'b000;
                    //J <= 1'b1;
                    JR <= 1'b1;
                    end
                    
                endcase;
            end
            
            
            6'b001001 :begin
             EX <= {1'b0,1'b1,1'b0,Instruction[31:26],1'b0};//ADDIU
             WB <= 2'b11;
             end
            6'b001000 :begin
              EX <= {1'b0,1'b1,1'b0,Instruction[31:26],1'b0};//ADDI
              WB <= 2'b11;
                            
              end
            6'b011100 : begin
                case({Instruction[5:0]})
                    6'b000010 :begin
                     EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//MUL
                     WB <= 2'b11;
                     end
                    6'b000000 :begin
                     EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//MADD
                     WB <= 2'b10;
                     end
                    6'b000100 :begin
                     EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//MSUB
                     WB <= 2'b10;
                     end
                    
                endcase
            end
            6'b001100 :begin
             EX <= {1'b0,1'b1,1'b0,Instruction[31:26],1'b0};//ANDI
             WB <= 2'b11;
             I <= 1'b1;
             end
            6'b001101 :begin
             EX <= {1'b0,1'b1,1'b0,Instruction[31:26],1'b0};//ORI
             WB <= 2'b11;
             I <= 1'b1;
             end
            6'b001110 :begin
             EX <= {1'b0,1'b1,1'b0,Instruction[31:26],1'b0};//XORI
             WB <= 2'b11;
             I <= 1'b1;
             end
            6'b011111 :  begin
                case({Instruction[10:6]})
                5'b11000 :begin
                 EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//SEH
                 WB <= 2'b11;
                 end
                5'b10000 :begin
                 EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b1};//SEB
                 WB <= 2'b11;
                 end
                
                endcase
            end
            6'b001010 :begin
             EX <= {1'b0,1'b1,1'b0,Instruction[31:26],1'b0};//SLTI
             WB <= 2'b11;
             end
            6'b001011 :begin
             EX <= {1'b0,1'b1,1'b0,Instruction[31:26],1'b0};//SLTIU
             WB <= 2'b11;
             end
           
          /* default : begin
           EX <= {1'b0,1'b0,1'b1,Instruction[31:26],1'b0};//ADD with no storage
           WB <= 1'b0;
           end */
//_________________________LW,SW,Jumps,Brances start________________________________________________________________________________________________________

    //******Loads & Store's Start
            6'b100011 :begin
            EX<= {1'b0,1'b1,1'b0,Instruction[31:26],1'b0};//LW
            WB <= 2'b01;
            M <= 3'b001;
            //MemToReg <= 1'b0;
            Load_Store <=2'b00;
            //MemToReg <= 1'b0;
            
            end
            
            6'b101011 :begin
             EX<= {1'b0,1'b1,1'b0,Instruction[31:26],1'b0};//SW
             WB <= 2'b10;
             M <= 3'b010;
             Load_Store <=2'b00;
             //MemToReg <= 1'b0;
                                    
            end
            
            6'b101000 :begin
            EX<= {1'b0,1'b1,1'b0,Instruction[31:26],1'b0};//SB
            WB <= 2'b10;
            M <= 3'b010;
            Load_Store <=2'b01;
            //MemToReg <= 1'b1; 
            
            end
            
            6'b100001 :begin
            EX<= {1'b0,1'b1,1'b0,Instruction[31:26],1'b0};//LH
            WB <= 2'b01;
            M <= 3'b001;
            //MemToReg <= 1'b0;
            Load_Store <=2'b10;
            //MemToReg <= 1'b0;
            
            end
            
            6'b100000 :begin
            EX<= {1'b0,1'b1,1'b0,Instruction[31:26],1'b0};//LB
            WB <= 2'b01;
            M <= 3'b001;
            //MemToReg <= 1'b0;
            Load_Store <=2'b01;
            //MemToReg <= 1'b0;
            
            end
            
            6'b101001 :begin
            EX<= {1'b0,1'b1,1'b0,Instruction[31:26],1'b0};//SH
            WB <= 2'b10;
            M <= 3'b010;
            Load_Store <=2'b10;
            //MemToReg <= 1'b1;
             
            end
//********** Branches *************************************************************************
            6'b000001 :begin
                case({Instruction[20:16]})
                    5'b00001 :begin
                    EX <= {1'b0,1'b0,1'b0,Instruction[31:26],1'b0};//BGEZ
                    WB <= 2'b10;
                    M <=3'b100;
                    end
                    
                    5'b00000 :begin
                    EX <= {1'b0,1'b0,1'b0,Instruction[31:26],1'b1};//BLTZ
                    WB <= 2'b10;
                    M <=3'b100;
                    end
                endcase
                //Might need editing
            end            
            
            6'b000100 : begin
            EX <= {1'b0,1'b0,1'b0,Instruction[31:26],1'b0};//BEQ
            WB <= 2'b10;
            M <=3'b100;
            //Might need editing
            end
            
            6'b000101 : begin
            EX <= {1'b0,1'b0,1'b0,Instruction[31:26],1'b0};//BNE
            WB <= 2'b10;
            M <=3'b100;
            //Might need editing
            end
            
            6'b000111 :begin
            EX <= {1'b0,1'b0,1'b0,Instruction[31:26],1'b0};//BGTZ
            WB <= 2'b10;
            M <=3'b100;
            //Might need editing
            end 
            
            6'b000110 : begin
            EX <= {1'b0,1'b0,1'b0,Instruction[31:26],1'b1};//BLTZ
            WB <= 2'b10;
            M <=3'b100;
            end
//********************JUMPS*************************************
            6'b000010 :begin
            EX <= {1'b0,1'b0,1'b0,Instruction[31:26],1'b0};//J
            WB <= 2'b10;
            M <=3'b000;
            J <= 1'b1;
            
            end
            
            6'b000011 :begin
            EX <= {1'b0,1'b0,1'b0,Instruction[31:26],1'b0};//JAL
            WB <= 2'b11;
            M <=3'b000;
            J <= 1'b1;
            JAL<= 1'b1;
            end
 //______________LUI______________________________           
           6'b001111 :begin
           EX <= {1'b0,1'b1,1'b0,Instruction[31:26],1'b0};//LUI
           WB <= 2'b11;
           Load_Store <= 2'b11;
           
           end
            
        
        endcase;
    end

endmodule
