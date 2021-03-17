`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2019 10:38:37 PM
// Design Name: 
// Module Name: IFID
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


module IFID(
    output reg [31:0] InstructionOut,
    output reg [31:0] PCAdderOut,
    input [31:0] PCAdderIn,
    input [31:0] InstructionIn,
    input Clk
);
    
    //temp storage
    reg [31:0] temp [0:1];
    integer i;
    
    initial begin
         for(i=0; i<= 1; i = i+1)
          temp[i] <= 'b0;
    end
    
    always @(posedge Clk)begin
        PCAdderOut <= PCAdderIn;
        InstructionOut <= InstructionIn;
    end


endmodule
