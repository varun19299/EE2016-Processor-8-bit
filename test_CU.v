`timescale 1ns / 1ps

/*
Testbench for CU module
*/
`include "Parameter.v"
`include "CU.v"

module test_CU;

 // Inputs
 reg [3:0] opcode;
 wire [1:0] alu_op;
 wire jump,beq,bne,mem_read,mem_write,alu_src,reg_dst,mem_to_reg,reg_write;


 // Instantiate the Unit Under Test (UUT)
 Control_Unit uut (opcode,alu_op,jump,beq,bne,mem_read,mem_write,
   alu_src,reg_dst,mem_to_reg,reg_write);

 initial
  begin

  $dumpfile("./Waveforms/test_CU.vcd");
  $dumpvars(0, opcode,alu_op,jump,beq,bne,mem_read,mem_write,
    alu_src,reg_dst,mem_to_reg,reg_write);

   opcode=4'd0;

   #20 begin
   opcode=4'd0;
   end

   #30 begin
   opcode=4'd1;
   end

   #40 begin
   opcode=4'd2;
   end

   #50 begin
   opcode=4'd3;
   end

   #60 begin
   opcode=4'd4;
   end

   #70 begin
   opcode=4'd5;
   end

   #80 begin
   opcode=4'd6;
   end

   #90 begin
   opcode=4'd7;
   end

   #100 begin
   opcode=4'd8;
   end

   #110 begin
   opcode=4'd9;
   end

   #120 begin
   opcode=4'd11;
   end

   #130 begin
   opcode=4'd12;
   end

   #140 begin
   opcode=3'd13;
   end

   `simulation_time;
   $finish;
  end

endmodule
