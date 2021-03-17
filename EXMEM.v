`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2019 07:36:45 PM
// Design Name: 
// Module Name: EXMEM
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


module EXMEM(
    output reg [1:0] WBOut, 
	output reg MemReadOut,
	output reg MemWriteOut,
    output reg [31:0] ALUResultOut,
    output reg [31:0] ReadData2Out,
    output reg [4:0] WriteRegisterOut,
    output reg [1:0] LoadStoreOut,
    input [1:0] WB, 
	input [3:0] M, 
	input Zero,
    input [31:0] ALUResult,
    input [31:0] ReadData2,
    input [4:0] WriteRegister,
	input Clk
    );

    initial begin
        //ouput initialization
        
        WBOut <= 0;
        MemReadOut <= 0; 
        MemWriteOut <= 0;
        ALUResultOut <= 0;
        ReadData2Out <= 0;
        WriteRegisterOut <= 0;
        LoadStoreOut <= 0;
        
    end
    
    always @(posedge Clk) begin
        WBOut <= WB;
		MemReadOut <= M[0];		// 2
		MemWriteOut <= M[1];	// 3
		LoadStoreOut <= M[3:2];

        ALUResultOut <= ALUResult;
        ReadData2Out <= ReadData2;
        WriteRegisterOut <= WriteRegister;
    end
endmodule
