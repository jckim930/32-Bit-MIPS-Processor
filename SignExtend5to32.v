`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2019 05:58:48 PM
// Design Name: 
// Module Name: SignExtend5to32
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


module SignExtend5to32(
    input [4:0] in,    /* A 16-Bit input word */
    output [31:0] out    /* A 32-Bit output word */
    );
    assign out = in[5] ? (in | 32'hffffffe0 ) : (in & 32'h0000001f);
endmodule
