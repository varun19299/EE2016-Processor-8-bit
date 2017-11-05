`timescale 1ns / 1ps

/*
Description:

This can be a combinational unit - it takes just the address bus
(8 bit value) as input,
and gives out a 16-bit value that is the instruction to be decoded.
The address is provided by the Program Counter (PC).
*/

`include "Parameter.v"

module Instruction_Memory(
 input[`pc_length-1:0] pc,
 output[15:0] instruction
);

//for 16 bit processor

 reg [`col_memory - 1:0] instruction_memory [`row_i - 1:0];
 wire [$clog2(`col_memory)-1 : 0] rom_addr = pc[$clog2(`col_memory)-1 : 0];
 initial
 begin
  $readmemb(`program_file, instruction_memory,0,14);
 end
 assign instruction =  instruction_memory[rom_addr];

endmodule
