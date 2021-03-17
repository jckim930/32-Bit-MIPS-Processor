`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2019 08:43:08 PM
// Design Name: 
// Module Name: MEMWB
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


module MEMWB(
    output reg MemToRegOut,
    output reg RegWriteOut,
    output reg [31:0] ReadDataOut, 
	output reg [31:0] ALUResultOut,
    output reg [4:0] WriteRegisterOut,
    output [31:0] debugWrite_data,
    input [1:0] WB, 
    input [31:0] ReadData,
	input [31:0] ALUResult,
    input [4:0] WriteRegister,
    input Clk
    );
    //temp storeage
    assign debugWrite_data = ALUResultOut;
    initial begin

        ReadDataOut <= 0; 
        ALUResultOut <= 0;
        WriteRegisterOut <= 0;
       
        MemToRegOut <= 0;
    end
    
    always @(posedge Clk)begin
        
        ReadDataOut <= ReadData;
        ALUResultOut <= ALUResult;
                
        WriteRegisterOut <= WriteRegister;
        
        MemToRegOut <= WB[0];
        RegWriteOut <= WB[1];
    end 
endmodule