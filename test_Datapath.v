`timescale 1ns / 1ps

/*
Testbench for ALU_Control module
*/
`include "Parameter.v"
`include "Datapath.v"

module test_Datapath;

 // Inputs and Outputs
 reg clk;
 reg jump,beq,mem_read,mem_write,alu_src,reg_dst,mem_to_reg,reg_write,bne;
 reg [1:0] alu_op;
 wire [3:0] opcode;

 // Instantiate the Unit Under Test (UUT)
 Datapath_Unit uut (clk,jump,beq,mem_read,mem_write,alu_src,reg_dst,mem_to_reg,reg_write,bne
   , alu_op,opcode);

 initial
  begin
  clk <=0;


  $dumpfile("./Waveforms/test_Datapath.vcd");
  $dumpvars(0,clk,jump,beq,mem_read,mem_write,alu_src,reg_dst,mem_to_reg,reg_write,bne
    , alu_op,opcode);


   #50 begin
   //Load Store expect xxxx
   {reg_dst,alu_src,mem_to_reg,reg_write,mem_read,mem_write,beq,bne,alu_op,jump}=11'b10010000000;
   end

   #60 begin
   //Branch expect xxxx
   {reg_dst,alu_src,mem_to_reg,reg_write,mem_read,mem_write,beq,bne,alu_op,jump}=11'b10010001000;
   end

   #70 begin
   //Load Store expect xxxx
   {reg_dst,alu_src,mem_to_reg,reg_write,mem_read,mem_write,beq,bne,alu_op,jump}=11'b00000000001;
   end

   `simulation_time;
   $finish;
  end

  always
   begin
    #5 clk = ~clk;
   end

endmodule
