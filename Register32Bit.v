`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2019 05:52:47 PM
// Design Name: 
// Module Name: Register32Bit
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


module Register32Bit(
    output reg [31:0] out,
    output [31:0] debug,
    input [31:0] in,
    input Clk
    );
    assign debug = out;
    reg [31:0] memory;
    
    initial begin
        memory <= 32'b0;
    end
    
    always @(posedge Clk) begin
        out <= memory;
    end
    
    always @(negedge Clk) begin
        memory <= in;
    end
    
endmodule
