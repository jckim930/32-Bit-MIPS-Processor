`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2019 09:41:05 PM
// Design Name: 
// Module Name: Branch_jump_control
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


module Branch_jump_control(
    output reg [1:0] sel_out,
    input Branch,
    input J,
    input JR
    );
    
    always @(*)begin
        sel_out = 2'b00;
    
        if(Branch ==1)
        sel_out <= 2'b01;
        else
            if(J == 1) 
                sel_out <= 2'b10;
            else
                if(JR == 1)
                    sel_out <= 2'b11; 
    end
endmodule