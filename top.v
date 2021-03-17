`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2019 11:24:38 AM
// Design Name: 
// Module Name: top
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
module top(
    input Clk, 
    input Reset,
    output [31:0] program_counter,
    output [31:0] write_data,
    output [31:0] HI_out,
    output [31:0] LO_out
    );
    
    //------------------------------------------Instruction Fetch------------------------------------------------
    wire [31:0] IF_MUX_PC_Out;
    wire [31:0] IF_PC_Out;
    wire [31:0] IF_PCAdder_Out, IFID_PCAdder_Out;
    wire [31:0] IF_InstructionMemory_Out, IFID_Instruction_Out;
    
    wire [31:0] ID_JUMP_Address_Out;
    
    wire [31:0] EX_BRANCH_Adder_Out;
    wire [31:0] ID_ReadData1_Out;
    wire EX_AND_BRANCH_Out;
    wire ID_J_Out, ID_JR_Out, ID_JAL_Out;
    wire [1:0] IF_BJ_Control_Out;

    Branch_jump_control IF_BJ_Control ( .sel_out(IF_BJ_Control_Out),
                                        .Branch(EX_AND_BRANCH_Out),
                                        .J(ID_J_Out),
                                        .JR(ID_JR_Out)
                                        );
    
    // Mux to the Program Counter
    Mux32Bit4To1 IF_MUX_PC( .out(IF_MUX_PC_Out),
                            .in0(IF_PCAdder_Out), // PC+4
                            .in1(EX_BRANCH_Adder_Out), // Branch
                            .in2(ID_JUMP_Address_Out), // Jumping
                            .in3(ID_ReadData1_Out), // JR
                            .sel(IF_BJ_Control_Out) 
                            );
                            
    ProgramCounter IF_ProgramCounter ( .PCResult(IF_PC_Out),
                                       .debugPC(program_counter), // End of Outputs
                                       .PCAdderResult(IF_MUX_PC_Out),
                                       .Reset(Reset),
                                       .Clk(Clk)
                                       );
                                      
    PCAdder IF_PCAdder ( .PCAdderResult(IF_PCAdder_Out),
                         .PCResult(IF_PC_Out)
                         );
   
    InstructionMemory IF_InstructionMemory ( .Instruction(IF_InstructionMemory_Out), // End of Outputs
                                             .PCResult(IF_PC_Out)
                                             );
   
    IFID IFID1 ( .InstructionOut(IFID_Instruction_Out),
                 .PCAdderOut(IFID_PCAdder_Out), // End of Outputs
                 .PCAdderIn(IF_PCAdder_Out),
                 .InstructionIn(IF_InstructionMemory_Out),
                 .Clk(Clk)
                 );
  //---------------------------------------------END OF INSTRUCTION FETCH---------------------------------------
  
  //---------------------------------------DECODE STAGE---------------------------------------------------------
    wire [31:0] ID_SignExtend16BitTo32_Out;
    wire [31:0] ID_ZeroExtend16BitTo32_Out;
    wire [31:0] ID_MUX_SignZeroExtend_Out, IDEX_SignZeroExtend_Out;
  
    wire [31:0] IDEX_ReadData1_Out;
    wire [31:0] ID_ReadData2_Out, IDEX_ReadData2_Out;
    wire [27:0] ID_JUMP_SLL2_Out;
  
    wire [31:0] IDEX_RT_Out, IDEX_RD_Out, IDEX_RS_Out;
    wire [31:0] IDEX_PCAdder_Out;
  
    wire [31:0] WB_MUX_WriteData_Out;
    wire [31:0] MEMWB_RTRD_Out;
    
    // Controller wire Outputs
    wire [1:0] ID_WB_Out, IDEX_WB_Out;
    wire [2:0] ID_M_Out;
    wire [3:0] IDEX_M_Out;
    wire [9:0] ID_EX_Out, IDEX_EX_Out;
    wire ID_I_Out;
    
    
    
    wire MEMWB_RegWrite_Out;
    wire IDEX_BRANCH;
    wire [1:0] ID_LoadStore_Out;
    SignExtend16BitTo32 ID_SignExtend16BitTo32 ( .out(ID_SignExtend16BitTo32_Out),
                                                 .in(IFID_Instruction_Out[15:0])
                                                 );
                                               
    ZeroExtend16BitTo32 ID_ZeroExtend16BitTo32 ( .out(ID_ZeroExtend16BitTo32_Out),
                                                 .in(IFID_Instruction_Out[15:0])
                                                 );
                                               
    Mux32Bit2To1 ID_MUX_SignZeroExtended ( .out(ID_MUX_SignZeroExtend_Out),
                                           .in0(ID_SignExtend16BitTo32_Out),
                                           .in1(ID_ZeroExtend16BitTo32_Out),
                                           .sel(ID_I_Out)  // FINISH
                                           );                                        
                                               
    ShiftLeft2_26To28 ID_JUMP_SLL2 ( .out(ID_JUMP_SLL2_Out),
                                     .in(IFID_Instruction_Out[25:0])
                                     );          
                                   
    Concatenate4and28To32 ID_JUMP_Concatenate( .out(ID_JUMP_Address_Out),
                                               .in4(IFID_PCAdder_Out[31:28]),
                                               .in28(ID_JUMP_SLL2_Out)
                                               );            

    Control ID_CONTROL ( .WB(ID_WB_Out), // ID_WB_Out
                         .M(ID_M_Out),
                         .EX(ID_EX_Out),
                         .I(ID_I_Out),
                         .J(ID_J_Out),
                         .JAL(ID_JAL_Out),
                         .JR(ID_JR_Out),
                         .Load_Store(ID_LoadStore_Out),
                         .Instruction(IFID_Instruction_Out)
                         );
                                          
    RegisterFile ID_RegisterFile ( .ReadData1(ID_ReadData1_Out),
                                   .ReadData2(ID_ReadData2_Out), // End of Outputs
                                   .ReadRegister1(IFID_Instruction_Out[25:21]), // rs
                                   .ReadRegister2(IFID_Instruction_Out[20:16]), // rt
                                   .WriteRegister(MEMWB_RTRD_Out), // From MEMWB
                                   .WriteData(WB_MUX_WriteData_Out), // From Mux in WB stage
                                   .RegWrite(MEMWB_RegWrite_Out), // From MEMWB
                                   .PCAdder(IFID_PCAdder_Out),
                                   .JAL(ID_JAL_Out),
                                   .Clk(Clk)
                                   );
  // FINISH
  
  IDEX IDEX1 ( .WBOut(IDEX_WB_Out),
               .MOut(IDEX_M_Out),
               .EXOut(IDEX_EX_Out),
               .PCAdderOut(IDEX_PCAdder_Out),
               .ReadData1Out(IDEX_ReadData1_Out),
               .ReadData2Out(IDEX_ReadData2_Out),
               .SignZeroExtendOut(IDEX_SignZeroExtend_Out),
               .RTOut(IDEX_RT_Out),
               .RDOut(IDEX_RD_Out),
               .RSOut(IDEX_RS_Out),
               .AndBranchOut(IDEX_BRANCH),
               .WB(ID_WB_Out),
               .M(ID_M_Out),
               .EX(ID_EX_Out),
               .PCAdder(IFID_PCAdder_Out),
               .ReadData1(ID_ReadData1_Out),
               .ReadData2(ID_ReadData2_Out),
               .SignZeroExtend(ID_MUX_SignZeroExtend_Out),
               .RT(IFID_Instruction_Out[20:16]),
               .RD(IFID_Instruction_Out[15:11]),
               .RS(IFID_Instruction_Out[25:21]),
               .Load_Store(ID_LoadStore_Out),
               .Clk(Clk)
               );
  //----------------------------------------EXECUTION--------------------------------------------------
  
  wire [31:0] EX_MUX_ALU_A_Out;
  wire [31:0] EX_MUX_ALU_B_Out;
  
  wire [31:0] EX_LO_Out, EX_HI_Out, debug_HI, debug_LO;
  wire [31:0] EX_ALU_LO_Out, EX_ALU_HI_Out;
  
  wire [4:0] EX_MUX_RTRD_Out, EXMEM_RTRD_Out;
  
  wire [5:0] EX_ALUControl_Out;
  
  wire [31:0] EX_ALU_Result_Out, EXMEM_ALU_Result_Out;
  wire EX_ALU_Zero_Out, EXMEM_ALU_Zero_Out;
  
  wire [31:0] EXMEM_ReadData2_Out;
  wire [31:0] EX_BRANCH_SLL2_Out;
  
  
  wire [31:0] EX_MUX_ALU_SA_Out;
  wire [31:0] EX_MUX_ALU_IMM_Out;
  wire [1:0] EXMEM_WB_Out;
  wire EXMEM_MemRead_Out, EXMEM_MemWrite_Out;
  wire [1:0] MEM_FUnit_MUX_A, MEM_FUnit_MUX_B;
  wire [31:0] EX_SignExtend_SA_Out;
  wire [1:0] EXMEM_LoadStore_Out;
  
  ShiftLeft2_32To32 EX_BRANCH_SLL2 ( .out(EX_BRANCH_SLL2_Out),
                                     .in(IDEX_SignZeroExtend_Out)
                                     );
  
  Adder EX_BRANCH_Adder ( .out(EX_BRANCH_Adder_Out),
                          .a(EX_BRANCH_SLL2_Out),
                          .b(IDEX_PCAdder_Out)
                          );
  
  Mux5Bit2To1 EX_MUX_RTRD (  .out(EX_MUX_RTRD_Out),
                             .in0(IDEX_RT_Out),
                             .in1(IDEX_RD_Out),
                             .sel(IDEX_EX_Out[7]) // RegDst EX[7]
                             );
                             
 SignExtend5to32 EX_SignExtend_SA ( .out(EX_SignExtend_SA_Out),
                                    .in(IDEX_SignZeroExtend_Out[10:6])
                                    );
                                    
 Mux32Bit2To1 EX_MUX_ALU_SA ( .out(EX_MUX_ALU_SA_Out),
                              .in0(IDEX_ReadData1_Out),
                              .in1(EX_SignExtend_SA_Out), //THIS CHANGED
                              .sel(IDEX_EX_Out[9]) // SA_MUX
                              );                          
                              
 Mux32Bit2To1 EX_MUX_ALU_IMM ( .out(EX_MUX_ALU_IMM_Out),
                               .in0(IDEX_ReadData2_Out),
                               .in1(IDEX_SignZeroExtend_Out),
                               .sel(IDEX_EX_Out[8]) // ALUSRC
                               ); 
                               
 Mux32Bit4To1 EX_MUX_ALU_A ( .out(EX_MUX_ALU_A_Out),
                             .in0(EX_MUX_ALU_SA_Out),
                             .in1(WB_MUX_WriteData_Out),
                             .in2(EXMEM_ALU_Result_Out),
                             .in3('b0),
                             .sel(MEM_FUnit_MUX_A) // A_MUX CONTROL
                             );  
                                                                                      
 Mux32Bit4To1 EX_MUX_ALU_B ( .out(EX_MUX_ALU_B_Out),
                             .in0(EX_MUX_ALU_IMM_Out),
                             .in1(WB_MUX_WriteData_Out),
                             .in2(EXMEM_ALU_Result_Out),
                             .in3('b0),
                             .sel(MEM_FUnit_MUX_B) // B_MUX CONTROL
                             );  
                                                                                     
 Register32Bit EX_HI ( .out(EX_HI_Out),
                       .debug(HI_out),
                       .in(EX_ALU_HI_Out),
                       .Clk(Clk)
                       );
                       
  Register32Bit EX_LO ( .out(EX_LO_Out),
                        .debug(LO_out),
                        .in(EX_ALU_LO_Out),
                        .Clk(Clk)
                        );   
                                                                       
  ALUControl EX_ALUControl ( .ALUcnt(EX_ALUControl_Out),
                             .ALUOp(IDEX_EX_Out[6:0]),
                             .funct(IDEX_SignZeroExtend_Out[5:0])
                             );
  
  
  ALU32Bit EX_ALU ( .ALUResult(EX_ALU_Result_Out),
                    .Zero(EX_ALU_Zero_Out),
                    .HIOut(EX_ALU_HI_Out),
                    .LOOut(EX_ALU_LO_Out),
                    .ALUControl(EX_ALUControl_Out),
                    .A(EX_MUX_ALU_A_Out),
                    .B(EX_MUX_ALU_B_Out),
                    .HI(EX_HI_Out),
                    .LO(EX_LO_Out)
                    );
  
  and ( EX_AND_BRANCH_Out, EX_ALU_Zero_Out, IDEX_BRANCH); 
  
  EXMEM EXMEM1 ( .WBOut(EXMEM_WB_Out),
                 .MemReadOut(EXMEM_MemRead_Out),
                 .MemWriteOut(EXMEM_MemWrite_Out),
                 .ALUResultOut(EXMEM_ALU_Result_Out), //EXMEM_ALU_Result_Out
                 .ReadData2Out(EXMEM_ReadData2_Out),
                 .WriteRegisterOut(EXMEM_RTRD_Out),
                 .LoadStoreOut(EXMEM_LoadStore_Out),
                 .WB(IDEX_WB_Out),
                 .M(IDEX_M_Out),
                 .ALUResult(EX_ALU_Result_Out),
                 .ReadData2(IDEX_ReadData2_Out),
                 .WriteRegister(EX_MUX_RTRD_Out),
                 .Clk(Clk)
                 );
//--------------------------------------------------------MEMORY---------------------------------------------------------------
   wire [31:0] MEM_ReadData_Out;
   //wire [31:0] MEMWB_RTRD_Out; declared in ID stage
   wire [31:0] MEMWB_ReadData_Out;
   wire [31:0] MEMWB_ALU_Result_Out;
   wire MEMWB_MemToReg_Out;
   
   
   
   Forwarding_Unit MEM_ForwardingUnit ( .Amux_control(MEM_FUnit_MUX_A),
                                        .Bmux_control(MEM_FUnit_MUX_B),
                                        .Rs(IDEX_RS_Out),
                                        .Rt(IDEX_RT_Out),
                                        .EXMEMRegisterRd(EXMEM_RTRD_Out),
                                        .MEMWBRegisterRd(MEMWB_RTRD_Out),
                                        .EXMEM_WB(EXMEM_WB_Out[0]),
                                        .MEMWB_WB(MEMWB_RegWrite_Out),
                                        .Clk(Clk)
                                        );
   
   DataMemory MEM_DataMemory( .ReadDataOut(MEM_ReadData_Out),
                              .Address(EXMEM_ALU_Result_Out),
                              .WriteData(EXMEM_ReadData2_Out),
                              .MemWrite(EXMEM_MemWrite_Out),
                              .MemRead(EXMEM_MemRead_Out),
                              .LoadStore(EXMEM_LoadStore_Out),
                              .Clk(Clk)
                              );
         
   MEMWB MEMWB1 ( .MemToRegOut(MEMWB_MemToReg_Out),
                  .RegWriteOut(MEMWB_RegWrite_Out),
                  .ReadDataOut(MEMWB_ReadData_Out),
                  .ALUResultOut(MEMWB_ALU_Result_Out),
                  .WriteRegisterOut(MEMWB_RTRD_Out),
                  .debugWrite_data(write_data),
                  .WB(EXMEM_WB_Out),
                  .ReadData(MEM_ReadData_Out),
                  .ALUResult(EXMEM_ALU_Result_Out),
                  .WriteRegister(EXMEM_RTRD_Out),
                  .Clk(Clk)
                  );  

//-------------------------------------------WRITE BACK----------------------------------------
   // wire [31:0] WB_MUX_WriteData_Out; declared in ID stage
   Mux32Bit2To1 WB_MUX_WriteData ( .out(WB_MUX_WriteData_Out),
                                   .in0(MEMWB_ReadData_Out),
                                   .in1(MEMWB_ALU_Result_Out),
                                   .sel(MEMWB_MemToReg_Out)
                                   );      
endmodule