`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - Mux32Bit2To1.v
// Description - Performs signal multiplexing between 2 32-Bit words.
////////////////////////////////////////////////////////////////////////////////

module Mux32Bit2To1(
    output [31:0] out,
    input [31:0] in0,
    input [31:0] in1,
    input sel
    );

    assign out = sel ? in1 : in0;
endmodule
