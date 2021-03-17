`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2019 12:03:18 PM
// Design Name: 
// Module Name: Mux32Bit4To1
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


module Mux32Bit4To1(
    output reg [31:0] out,
    input [31:0] in0,
    input [31:0] in1,
    input [31:0] in2,
    input [31:0] in3,
    input [1:0] sel
    );
    
    always @* begin
        case (sel)
            2'b00 : out <= in0;
            2'b01 : out <= in1;
            2'b10 : out <= in2;
            2'b11 : out <= in3;
        endcase
    end
endmodule
