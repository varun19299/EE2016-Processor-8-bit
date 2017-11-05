
`ifndef PARAMETER_H_
`define PARAMETER_H_

// Parameter file
`define col 8 // 8 bits data memory.
`define col_memory 16 // 16 bits instruction memory.
`define row_i 15 // instruction memory, instructions number, this number can be changed. Adding more instructions to verify your design is a good idea.
`define row_d 8 // The number of data registers in data memory.
//We only use 8 data. Do not change this number.
// Please only change the value of each data inside test.data file. Total number is fixed at 8.
`define filename "./demo/1_11_17_16_44.o"
`define simulation_time #300
`define data_file "./demo/data_2.txt"
`define program_file "./demo/assemble/b.txt"
`define pc_length 8 //length of program counter
`endif
