`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2019 05:48:03 PM
// Design Name: 
// Module Name: Concatenate4and28To32
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


module Concatenate4and28To32(
    output [31:0] out,
    input [3:0] in4,
    input [27:0] in28
    );
    assign out = { {in4}, {in28} };
endmodule
