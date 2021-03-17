`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2019 05:38:22 PM
// Design Name: 
// Module Name: ShiftLeft2_26To28
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


module ShiftLeft2_26To28(
    output [27:0] out,
    input [25:0] in
    );
    
    assign out = (in << 2);
endmodule
