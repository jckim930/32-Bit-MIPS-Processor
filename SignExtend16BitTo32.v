`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2019 12:05:35 PM
// Design Name: 
// Module Name: SignExtend16BitTo32
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


module SignExtend16BitTo32(
    input [15:0] in,    /* A 16-Bit input word */
    output [31:0] out    /* A 32-Bit output word */
);
    assign out = in[15] ? (in | 32'hffff0000) : (in & 32'h0000ffff);
endmodule