`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2019 05:15:37 PM
// Design Name: 
// Module Name: ZeroExtend16BitTo32
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


module ZeroExtend16BitTo32(
    output [31:0] out,    /* A 32-Bit output word */
    input [15:0] in    /* A 16-Bit input word */
);
    assign out = { {16{1'b0}}, in};
endmodule
