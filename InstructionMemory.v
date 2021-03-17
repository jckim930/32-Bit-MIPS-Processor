`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369A - Computer Architecture
// Laboratory  1
// Module - InstructionMemory.v
// Description - 32-Bit wide instruction memory.
//
// INPUT:-
// Address: 32-Bit address input port.
//
// OUTPUT:-
// Instruction: 32-Bit output port.
//
// FUNCTIONALITY:-
// Similar to the DataMemory, this module should also be byte-addressed
// (i.e., ignore bits 0 and 1 of 'Address'). All of the instructions will be 
// hard-coded into the instruction memory, so there is no need to write to the 
// InstructionMemory.  The contents of the InstructionMemory is the machine 
// language program to be run on your MIPS processor.
//
//
//we will store the machine code for a code written in C later. for now initialize 
//each entry to be its index * 3 (memory[i] = i * 3;)
//all you need to do is give an address as input and read the contents of the 
//address on your output port. 
// 
//Using a 32bit address you will index into the memory, output the contents of that specific 
//address. for data memory we are using 1K word of storage space. for the instruction memory 
//you may assume smaller size for practical purpose. you can use 128 words as the size and 
//hardcode the values.  in this case you need 7 bits to index into the memory. 
//
//be careful with the least two significant bits of the 32bit address. those help us index 
//into one of the 4 bytes in a word. therefore you will need to use bit [8-2] of the input address. 


////////////////////////////////////////////////////////////////////////////////

module InstructionMemory(
    output reg [31:0] Instruction, // Instruction at memory location Address
    input [31:0] PCResult        // Input Address 
);
    
    integer i;
    reg [31:0] memory [0:400];
    /* Please fill in the implementation here */
    initial begin
		for (i = 0; i < 400; i = i + 1) begin
			memory[i] = 'b0;
		end
   memory[0] <= 32'h34040000;    //    main:        ori    $a0, $zero, 0
   memory[1] <= 32'h00000000;    //            nop
   memory[2] <= 32'h00000000;    //            nop
   memory[3] <= 32'h00000000;    //            nop
   memory[4] <= 32'h00000000;    //            nop
   memory[5] <= 32'h00000000;    //            nop
   memory[6] <= 32'h08000018;    //            j    start
   memory[7] <= 32'h00000000;    //            nop
   memory[8] <= 32'h00000000;    //            nop
   memory[9] <= 32'h00000000;    //            nop
   memory[10] <= 32'h00000000;    //            nop
   memory[11] <= 32'h00000000;    //            nop
   memory[12] <= 32'h2004000a;    //            addi    $a0, $zero, 10
   memory[13] <= 32'h00000000;    //            nop
   memory[14] <= 32'h00000000;    //            nop
   memory[15] <= 32'h00000000;    //            nop
   memory[16] <= 32'h00000000;    //            nop
   memory[17] <= 32'h00000000;    //            nop
   memory[18] <= 32'h2004000a;    //            addi    $a0, $zero, 10
   memory[19] <= 32'h00000000;    //            nop
   memory[20] <= 32'h00000000;    //            nop
   memory[21] <= 32'h00000000;    //            nop
   memory[22] <= 32'h00000000;    //            nop
   memory[23] <= 32'h00000000;    //            nop
   memory[24] <= 32'h8c900004;    //    start:        lw    $s0, 4($a0)
   memory[25] <= 32'h00000000;    //            nop    $s0=6
   memory[26] <= 32'h00000000;    //            nop
   memory[27] <= 32'h00000000;    //            nop
   memory[28] <= 32'h00000000;    //            nop
   memory[29] <= 32'h00000000;    //            nop
   memory[30] <= 32'h8c900008;    //            lw    $s0, 8($a0)
   memory[31] <= 32'h00000000;    //            nop    $s0=9
   memory[32] <= 32'h00000000;    //            nop
   memory[33] <= 32'h00000000;    //            nop
   memory[34] <= 32'h00000000;    //            nop
   memory[35] <= 32'h00000000;    //            nop
   memory[36] <= 32'hac900000;    //            sw    $s0, 0($a0)
   memory[37] <= 32'h00000000;    //            nop memory[1] = 9
   memory[38] <= 32'h00000000;    //            nop  
   memory[39] <= 32'h00000000;    //            nop
   memory[40] <= 32'h00000000;    //            nop
   memory[41] <= 32'h00000000;    //            nop
   memory[42] <= 32'hac90000c;    //            sw    $s0, 12($a0)
   memory[43] <= 32'h00000000;    //            nop    memory[4]=9
   memory[44] <= 32'h00000000;    //            nop
   memory[45] <= 32'h00000000;    //            nop
   memory[46] <= 32'h00000000;    //            nop
   memory[47] <= 32'h00000000;    //            nop
   memory[48] <= 32'h8c910000;    //            lw    $s1, 0($a0) 
   memory[49] <= 32'h00000000;    //            nop
   memory[50] <= 32'h00000000;    //            nop $s1=9
   memory[51] <= 32'h00000000;    //            nop
   memory[52] <= 32'h00000000;    //            nop
   memory[53] <= 32'h00000000;    //            nop
   memory[54] <= 32'h8c92000c;    //            lw    $s2, 12($a0)
   memory[55] <= 32'h00000000;    //            nop
   memory[56] <= 32'h00000000;    //            nop  $s2=9
   memory[57] <= 32'h00000000;    //            nop
   memory[58] <= 32'h00000000;    //            nop
   memory[59] <= 32'h00000000;    //            nop
   memory[60] <= 32'h12000017;    //            beq    $s0, $zero, branch1
   memory[61] <= 32'h00000000;    //            nop
   memory[62] <= 32'h00000000;    //            nop    $s0=9
   memory[63] <= 32'h00000000;    //            nop
   memory[64] <= 32'h00000000;    //            nop
   memory[65] <= 32'h00000000;    //            nop
   memory[66] <= 32'h02008820;    //            add    $s1, $s0, $zero
   memory[67] <= 32'h00000000;    //            nop
   memory[68] <= 32'h00000000;    //            nop    $s1=9
   memory[69] <= 32'h00000000;    //            nop
   memory[70] <= 32'h00000000;    //            nop
   memory[71] <= 32'h00000000;    //            nop
   memory[72] <= 32'h1211000b;    //            beq    $s0, $s1, branch1
   memory[73] <= 32'h00000000;    //            nop
   memory[74] <= 32'h00000000;    //            nop
   memory[75] <= 32'h00000000;    //            nop
   memory[76] <= 32'h00000000;    //            nop
   memory[77] <= 32'h00000000;    //            nop
   memory[78] <= 32'h0800013e;    //            j    error
   memory[79] <= 32'h00000000;    //            nop
   memory[80] <= 32'h00000000;    //            nop
   memory[81] <= 32'h00000000;    //            nop
   memory[82] <= 32'h00000000;    //            nop
   memory[83] <= 32'h00000000;    //            nop
   memory[84] <= 32'h2010ffff;    //    branch1:    addi    $s0, $zero, -1
   memory[85] <= 32'h00000000;    //            nop  $s0=-1
   memory[86] <= 32'h00000000;    //            nop
   memory[87] <= 32'h00000000;    //            nop //b=rt ,a=rs
   memory[88] <= 32'h00000000;    //            nop
   memory[89] <= 32'h00000000;    //            nop
   memory[90] <= 32'h0601ffbd;    //            bgez    $s0, start
   memory[91] <= 32'h00000000;    //            nop
   memory[92] <= 32'h00000000;    //            nop
   memory[93] <= 32'h00000000;    //            nop
   memory[94] <= 32'h00000000;    //            nop
   memory[95] <= 32'h00000000;    //            nop
   memory[96] <= 32'h22100001;    //            addi    $s0, $s0, 1
   memory[97] <= 32'h00000000;    //            nop
   memory[98] <= 32'h00000000;    //            nop
   memory[99] <= 32'h00000000;    //            nop
   memory[100] <= 32'h00000000;    //            nop
   memory[101] <= 32'h00000000;    //            nop
   memory[102] <= 32'h0601000b;    //            bgez    $s0, branch2
   memory[103] <= 32'h00000000;    //            nop
   memory[104] <= 32'h00000000;    //            nop
   memory[105] <= 32'h00000000;    //            nop
   memory[106] <= 32'h00000000;    //            nop
   memory[107] <= 32'h00000000;    //            nop
   memory[108] <= 32'h0800013e;    //            j    error
   memory[109] <= 32'h00000000;    //            nop
   memory[110] <= 32'h00000000;    //            nop
   memory[111] <= 32'h00000000;    //            nop
   memory[112] <= 32'h00000000;    //            nop
   memory[113] <= 32'h00000000;    //            nop
   memory[114] <= 32'h2010ffff;    //    branch2:    addi    $s0, $zero, -1
   memory[115] <= 32'h00000000;    //            nop   $s0= -1
   memory[116] <= 32'h00000000;    //            nop
   memory[117] <= 32'h00000000;    //            nop
   memory[118] <= 32'h00000000;    //            nop
   memory[119] <= 32'h00000000;    //            nop
   memory[120] <= 32'h1e000017;    //            bgtz    $s0, branch3
   memory[121] <= 32'h00000000;    //            nop
   memory[122] <= 32'h00000000;    //            nop
   memory[123] <= 32'h00000000;    //            nop
   memory[124] <= 32'h00000000;    //            nop
   memory[125] <= 32'h00000000;    //            nop
   memory[126] <= 32'h20100001;    //            addi    $s0, $zero, 1
   memory[127] <= 32'h00000000;    //            nop  $s0=1
   memory[128] <= 32'h00000000;    //            nop
   memory[129] <= 32'h00000000;    //            nop
   memory[130] <= 32'h00000000;    //            nop
   memory[131] <= 32'h00000000;    //            nop
   memory[132] <= 32'h1e00000b;    //            bgtz    $s0, branch3
   memory[133] <= 32'h00000000;    //            nop
   memory[134] <= 32'h00000000;    //            nop
   memory[135] <= 32'h00000000;    //            nop
   memory[136] <= 32'h00000000;    //            nop
   memory[137] <= 32'h00000000;    //            nop
   memory[138] <= 32'h0800013e;    //            j    error
   memory[139] <= 32'h00000000;    //            nop
   memory[140] <= 32'h00000000;    //            nop
   memory[141] <= 32'h00000000;    //            nop
   memory[142] <= 32'h00000000;    //            nop
   memory[143] <= 32'h00000000;    //            nop
   memory[144] <= 32'h06000017;    //    branch3:    bltz    $s0, branch4
   memory[145] <= 32'h00000000;    //            nop
   memory[146] <= 32'h00000000;    //            nop
   memory[147] <= 32'h00000000;    //            nop
   memory[148] <= 32'h00000000;    //            nop
   memory[149] <= 32'h00000000;    //            nop
   memory[150] <= 32'h2010ffff;    //            addi    $s0, $zero, -1
   memory[151] <= 32'h00000000;    //            nop  $s0= -1
   memory[152] <= 32'h00000000;    //            nop
   memory[153] <= 32'h00000000;    //            nop
   memory[154] <= 32'h00000000;    //            nop
   memory[155] <= 32'h00000000;    //            nop
   memory[156] <= 32'h0600000b;    //            bltz    $s0, branch4
   memory[157] <= 32'h00000000;    //            nop
   memory[158] <= 32'h00000000;    //            nop
   memory[159] <= 32'h00000000;    //            nop
   memory[160] <= 32'h00000000;    //            nop
   memory[161] <= 32'h00000000;    //            nop
   memory[162] <= 32'h0800013e;    //            j    error
   memory[163] <= 32'h00000000;    //            nop
   memory[164] <= 32'h00000000;    //            nop
   memory[165] <= 32'h00000000;    //            nop
   memory[166] <= 32'h00000000;    //            nop
   memory[167] <= 32'h00000000;    //            nop
   memory[168] <= 32'h2011ffff;    //    branch4:    addi    $s1, $zero, -1
   memory[169] <= 32'h00000000;    //            nop   $s1= -1
   memory[170] <= 32'h00000000;    //            nop
   memory[171] <= 32'h00000000;    //            nop
   memory[172] <= 32'h00000000;    //            nop
   memory[173] <= 32'h00000000;    //            nop
   memory[174] <= 32'h16110011;    //            bne    $s0, $s1, branch5
   memory[175] <= 32'h00000000;    //            nop
   memory[176] <= 32'h00000000;    //            nop
   memory[177] <= 32'h00000000;    //            nop
   memory[178] <= 32'h00000000;    //            nop
   memory[179] <= 32'h00000000;    //            nop
   memory[180] <= 32'h1600000b;    //            bne    $s0, $zero, branch5
   memory[181] <= 32'h00000000;    //            nop
   memory[182] <= 32'h00000000;    //            nop
   memory[183] <= 32'h00000000;    //            nop
   memory[184] <= 32'h00000000;    //            nop
   memory[185] <= 32'h00000000;    //            nop
   memory[186] <= 32'h0800013e;    //            j    error
   memory[187] <= 32'h00000000;    //            nop
   memory[188] <= 32'h00000000;    //            nop
   memory[189] <= 32'h00000000;    //            nop
   memory[190] <= 32'h00000000;    //            nop
   memory[191] <= 32'h00000000;    //            nop
   memory[192] <= 32'h20100080;    //    branch5:    addi    $s0, $zero, 128
   memory[193] <= 32'h00000000;    //            nop  $s0=128
   memory[194] <= 32'h00000000;    //            nop
   memory[195] <= 32'h00000000;    //            nop
   memory[196] <= 32'h00000000;    //            nop
   memory[197] <= 32'h00000000;    //            nop
   memory[198] <= 32'ha0900000;    //            sb    $s0, 0($a0)
   memory[199] <= 32'h00000000;    //            nop
   memory[200] <= 32'h00000000;    //            nop    store 128
   memory[201] <= 32'h00000000;    //            nop
   memory[202] <= 32'h00000000;    //            nop
   memory[203] <= 32'h00000000;    //            nop
   memory[204] <= 32'h80900000;    //            lb    $s0, 0($a0)
   memory[205] <= 32'h00000000;    //            nop    $s0=-128
   memory[206] <= 32'h00000000;    //            nop
   memory[207] <= 32'h00000000;    //            nop
   memory[208] <= 32'h00000000;    //            nop
   memory[209] <= 32'h00000000;    //            nop
   memory[210] <= 32'h1a00000b;    //            blez    $s0, branch6 ///idk why it's fetching 0x80 instead of 0xffffff80
   memory[211] <= 32'h00000000;    //            nop
   memory[212] <= 32'h00000000;    //            nop
   memory[213] <= 32'h00000000;    //            nop
   memory[214] <= 32'h00000000;    //            nop
   memory[215] <= 32'h00000000;    //            nop
   memory[216] <= 32'h0800013e;    //            j    error
   memory[217] <= 32'h00000000;    //            nop
   memory[218] <= 32'h00000000;    //            nop
   memory[219] <= 32'h00000000;    //            nop
   memory[220] <= 32'h00000000;    //            nop
   memory[221] <= 32'h00000000;    //            nop
   memory[222] <= 32'h2010ffff;    //    branch6:    addi    $s0, $zero, -1
   memory[223] <= 32'h00000000;    //            nop   $s0=-1
   memory[224] <= 32'h00000000;    //            nop
   memory[225] <= 32'h00000000;    //            nop
   memory[226] <= 32'h00000000;    //            nop
   memory[227] <= 32'h00000000;    //            nop
   memory[228] <= 32'ha4900000;    //            sh    $s0, 0($a0)
   memory[229] <= 32'h00000000;    //            nop
   memory[230] <= 32'h00000000;    //            nop
   memory[231] <= 32'h00000000;    //            nop
   memory[232] <= 32'h00000000;    //            nop
   memory[233] <= 32'h00000000;    //            nop
   memory[234] <= 32'h20100000;    //            addi    $s0, $zero, 0
   memory[235] <= 32'h00000000;    //            nop  $s0=0
   memory[236] <= 32'h00000000;    //            nop
   memory[237] <= 32'h00000000;    //            nop
   memory[238] <= 32'h00000000;    //            nop
   memory[239] <= 32'h00000000;    //            nop
   memory[240] <= 32'h84900000;    //            lh    $s0, 0($a0)
   memory[241] <= 32'h00000000;    //            nop
   memory[242] <= 32'h00000000;    //            nop
   memory[243] <= 32'h00000000;    //            nop
   memory[244] <= 32'h00000000;    //            nop
   memory[245] <= 32'h00000000;    //            nop
   memory[246] <= 32'h1a00000b;    //            blez    $s0, branch7
   memory[247] <= 32'h00000000;    //            nop
   memory[248] <= 32'h00000000;    //            nop
   memory[249] <= 32'h00000000;    //            nop
   memory[250] <= 32'h00000000;    //            nop
   memory[251] <= 32'h00000000;    //            nop
   memory[252] <= 32'h0800013e;    //            j    error
   memory[253] <= 32'h00000000;    //            nop
   memory[254] <= 32'h00000000;    //            nop
   memory[255] <= 32'h00000000;    //            nop
   memory[256] <= 32'h00000000;    //            nop
   memory[257] <= 32'h00000000;    //            nop
   memory[258] <= 32'h2010ffff;    //    branch7:    addi    $s0, $zero, -1
   memory[259] <= 32'h00000000;    //            nop $s0= -1
   memory[260] <= 32'h00000000;    //            nop
   memory[261] <= 32'h00000000;    //            nop
   memory[262] <= 32'h00000000;    //            nop
   memory[263] <= 32'h00000000;    //            nop
   memory[264] <= 32'h3c100001;    //            lui    $s0, 1
   memory[265] <= 32'h00000000;    //            nop  $s0=65536
   memory[266] <= 32'h00000000;    //            nop
   memory[267] <= 32'h00000000;    //            nop
   memory[268] <= 32'h00000000;    //            nop
   memory[269] <= 32'h00000000;    //            nop
   memory[270] <= 32'h0601000b;    //            bgez    $s0, branch8
   memory[271] <= 32'h00000000;    //            nop
   memory[272] <= 32'h00000000;    //            nop
   memory[273] <= 32'h00000000;    //            nop
   memory[274] <= 32'h00000000;    //            nop
   memory[275] <= 32'h00000000;    //            nop
   memory[276] <= 32'h0800013e;    //            j    error
   memory[277] <= 32'h00000000;    //            nop
   memory[278] <= 32'h00000000;    //            nop
   memory[279] <= 32'h00000000;    //            nop
   memory[280] <= 32'h00000000;    //            nop
   memory[281] <= 32'h00000000;    //            nop
   memory[282] <= 32'h08000126;    //    branch8:    j    jump1
   memory[283] <= 32'h00000000;    //            nop
   memory[284] <= 32'h00000000;    //            nop
   memory[285] <= 32'h00000000;    //            nop
   memory[286] <= 32'h00000000;    //            nop
   memory[287] <= 32'h00000000;    //            nop
   memory[288] <= 32'h2210fffe;    //            addi    $s0, $s0, -2
   memory[289] <= 32'h00000000;    //            nop
   memory[290] <= 32'h00000000;    //            nop
   memory[291] <= 32'h00000000;    //            nop
   memory[292] <= 32'h00000000;    //            nop
   memory[293] <= 32'h00000000;    //            nop
   memory[294] <= 32'h0c000132;    //    jump1:        jal    jal1
   memory[295] <= 32'h00000000;    //            nop
   memory[296] <= 32'h00000000;    //            nop
   memory[297] <= 32'h00000000;    //            nop
   memory[298] <= 32'h00000000;    //            nop
   memory[299] <= 32'h00000000;    //            nop
   memory[300] <= 32'h08000018;    //            j    start
   memory[301] <= 32'h00000000;    //            nop
   memory[302] <= 32'h00000000;    //            nop
   memory[303] <= 32'h00000000;    //            nop
   memory[304] <= 32'h00000000;    //            nop
   memory[305] <= 32'h00000000;    //            nop
   memory[306] <= 32'h03e00008;    //    jal1:   nop     //jr    $ra
   memory[307] <= 32'h00000000;    //            nop
   memory[308] <= 32'h00000000;    //            nop
   memory[309] <= 32'h00000000;    //            nop
   memory[310] <= 32'h00000000;    //            nop
   memory[311] <= 32'h00000000;    //            nop
   memory[312] <= 32'h0800013e;    //            j    error
   memory[313] <= 32'h00000000;    //            nop
   memory[314] <= 32'h00000000;    //            nop
   memory[315] <= 32'h00000000;    //            nop
   memory[316] <= 32'h00000000;    //            nop
   memory[317] <= 32'h00000000;    //            nop
   memory[318] <= 32'h00000008;    //    error:        jr    $zero
   memory[319] <= 32'h00000000;    //            nop
   memory[320] <= 32'h00000000;    //            nop
   memory[321] <= 32'h00000000;    //            nop
   memory[322] <= 32'h00000000;    //            nop
   memory[323] <= 32'h00000000;    //            nop
   memory[324] <= 32'h3402000a;    //            ori    $v0, $zero, 10
   memory[325] <= 32'h00000000;    //            nop
   memory[326] <= 32'h00000000;    //            nop
   memory[327] <= 32'h00000000;    //            nop
   memory[328] <= 32'h00000000;    //            nop
   memory[329] <= 32'h00000000;    //            nop
   memory[330] <= 32'h00000000;    //            nop
   memory[331] <= 32'h00000000;    //            nop
   memory[332] <= 32'h00000000;    //            nop
   memory[333] <= 32'h00000000;    //            nop
   memory[334] <= 32'h00000000;    //            nop
   memory[335] <= 32'h00000000;    //            nop



    end
    
    always @* begin
        Instruction <= memory[PCResult[10:2]];
    end
endmodule