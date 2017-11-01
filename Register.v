`timescale 1ns / 1ps

`include "Parameter.v"

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
 integer f;
 // write port
 //reg [2:0] i;
 initial begin
  for(i=0;i<8;i=i+1)
   reg_array[i] <= 7'd0;
   if (i==4) begin
      reg_array[i]<=7'd3;
   end
 end

 initial
  begin
   f = $fopen(`filename);
   `simulation_time;
   $fclose(f);
  end

 always @ (posedge clk ) begin
 //output registers
 $monitor(f,"time = %d\n", $time,
 "\treg[0] = %b\n", reg_array[0],
 "\treg[1] = %b\n", reg_array[1],
 "\treg[2] = %b\n", reg_array[2],
 "\treg[3] = %b\n", reg_array[3],
 "\treg[4] = %b\n", reg_array[4],
 "\treg[5] = %b\n", reg_array[5],
 "\treg[6] = %b\n", reg_array[6],
 "\treg[7] = %b\n", reg_array[7]);

   if(reg_write_en) begin
    reg_array[reg_write_dest] <= reg_write_data;
   end
 end


 assign reg_read_data_1 = reg_array[reg_read_addr_1];
 assign reg_read_data_2 = reg_array[reg_read_addr_2];



endmodule
