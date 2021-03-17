`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2019 05:09:50 PM
// Design Name: 
// Module Name: Forwarding_Unit
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


module Forwarding_Unit(
    output reg[1:0] Amux_control,
    output reg[1:0] Bmux_control,
    input [4:0] Rs, 
    input [4:0] Rt, 
    input [4:0] EXMEMRegisterRd, 
    input [4:0] MEMWBRegisterRd,
    input EXMEM_WB, 
    input MEMWB_WB, 
    input Clk
    );

    always @(posedge Clk)begin
    Amux_control = 2'b00;
    Bmux_control = 2'b00;
    //EX Hazard
        //A mux Forwarding
      /*  if((EXMEM_WB != 0)&&(EXMEMRegisterRd != 0))begin
            if(EXMEMRegisterRd == Rs)begin
            Amux_control <= 2'b10;
            end
        end
        // B mux Forwarding
        if((EXMEM_WB != 0)&&(EXMEMRegisterRd != 0))begin
            if(EXMEMRegisterRd == Rt)begin
                    Bmux_control <= 2'b10;
            end
        end
        
   //MEM Hazard
        //A mux 
        if((MEMWBRegisterRd !=0)&&(MEMWB_WB != 0))begin
            if(MEMWBRegisterRd == Rs)begin
            Amux_control <= 2'b01;
            end
        end
        //B mux
        if((MEMWBRegisterRd !=0)&&(MEMWB_WB != 0))begin
            if(MEMWBRegisterRd == Rt)begin
            Bmux_control <= 2'b01;
            end
        end */       
    end


endmodule
