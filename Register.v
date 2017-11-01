`timescale 1ns / 1ps

/*
Description:

GPRs module.
This is a set of 8 registers, each storing an 8 bit value.
There are 2 output values ra and rb,
whose values are selected based on the instruction word,
as in the instruction definitions given above.
There is one port by which data can be written into one of the registers,
but make sure to give an enable signal to control whether or not to update the value.
*/

module GPRs( //general purpose register
 input    clk,
 // write port
 input    reg_write_en,
 input  [2:0] reg_write_dest,
 input  [7:0] reg_write_data,
 //read port 1
 input  [2:0] reg_read_addr_1,
 output  [7:0] reg_read_data_1,
 //read port 2
 input  [2:0] reg_read_addr_2,
 output  [7:0] reg_read_data_2
);
 reg [7:0] reg_array [7:0];
 integer i;
 // write port
 //reg [2:0] i;
 initial begin
  for(i=0;i<8;i=i+1)
   reg_array[i] <= 7'd0;
 end
 always @ (posedge clk ) begin
   if(reg_write_en) begin
    reg_array[reg_write_dest] <= reg_write_data;
   end
 end


 assign reg_read_data_1 = reg_array[reg_read_addr_1];
 assign reg_read_data_2 = reg_array[reg_read_addr_2];


endmodule
