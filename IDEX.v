`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Spencer Kittredge
// 
// Create Date: 10/18/2019 06:45:28 PM
// Design Name: 
// Module Name: IDEX
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


module IDEX(
    output reg [1:0] WBOut,
    output reg [3:0] MOut,
    output reg [9:0] EXOut,
    output reg [31:0] PCAdderOut,
    output reg [31:0] ReadData1Out,
    output reg [31:0] ReadData2Out,
    output reg [31:0] SignZeroExtendOut,
    output reg AndBranchOut,
    output reg [4:0] RTOut,
    output reg [4:0] RDOut,
    output reg [4:0] RSOut,
    input [1:0] WB,
    input [2:0] M,
    input [9:0] EX,
    input [31:0] PCAdder,
    input [31:0] ReadData1,
    input [31:0] ReadData2,
    input [31:0] SignZeroExtend,
    input [4:0] RT,
    input [4:0] RD,
    input [4:0] RS,
    input [1:0] Load_Store, // WB = {{Load_St}, {WB}}
    input Clk
    );

    initial begin
        WBOut <= 'b0;
        MOut <= 'b0;
        EXOut <= 'b0;
        PCAdderOut <= 'b0;
        ReadData1Out <= 'b0;
        ReadData2Out <= 'b0;
        SignZeroExtendOut <= 'b0;
        RTOut <= 'b0;
        RDOut <= 'b0;
        RSOut <= 'b0;
    end
    
    always @(posedge Clk)begin
        WBOut <= WB;
        MOut <= {Load_Store, M[1:0]};
        EXOut <= EX;
        
        PCAdderOut <= PCAdder;
        
        ReadData1Out <= ReadData1;
        ReadData2Out <= ReadData2;
        
        SignZeroExtendOut <= SignZeroExtend;
        
        RTOut <= RT;
        RDOut <= RD;
        RSOut <= RS;
        AndBranchOut <= M[2];
    end
endmodule