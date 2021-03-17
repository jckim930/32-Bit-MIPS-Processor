`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2019 08:57:11 PM
// Design Name: 
// Module Name: ShiftLeft2_32To32
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


module ShiftLeft2_32To32(
    output [31:0] out,
    input [31:0] in
    );
    
    assign out = (in << 2);
endmodule
