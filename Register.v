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
 input    WR,
 input  RA,
 input  [2:0] rd,
 input  [7:0] rd_data,
 //read port 1
 input  [2:0] ra,
 output reg [7:0] ra_data,
 //read port 2
 input  [2:0] rb,
 output reg [7:0] rb_data
);

 reg [7:0] reg_array [7:0];
 integer i;
 integer f;
 // write port
 //reg [2:0] i;
 initial begin
  for(i=0;i<8;i=i+1)
   reg_array[i] <= 8'd0;
 end

 initial
  begin
   f = $fopen(`filename);
   `simulation_time;
   $fclose(f);
  end

 always @(posedge clk) begin
 //output registers


   if(WR) begin
    reg_array[rd] <= rd_data;
   end
   else if(RA) begin
    ra_data = reg_array[ra];
    rb_data = reg_array[rb];

   end

   $monitor(f,"time = %d\n", $time,
   "\treg[0] = %b\n", reg_array[0],
   "\treg[1] = %b\n", reg_array[1],
   "\treg[2] = %b\n", reg_array[2],
   "\treg[3] = %b\n", reg_array[3],
   "\treg[4] = %b\n", reg_array[4],
   "\treg[5] = %b\n", reg_array[5],
   "\treg[6] = %b\n", reg_array[6],
   "\treg[7] = %b\n", reg_array[7]);
 end

endmodule
