`timescale 1ns / 1ps

/*
Testbench for RISC module
*/
`include "Parameter.v"
`include "CU.v"

module test_CU;

 // Inputs
 reg clk;
 reg reset;
 wire [15:0] pc_out;
 wire [7:0] alu_result;
 wire [2:0] state;
 wire hold;
 wire [3:0] opcode;
 wire zero;

 // Instantiate the Unit Under Test (UUT)
 CU uut (
  clk,reset,pc_out,alu_result,state,hold,opcode,zero
 );

 initial
  begin
  reset=1;
  $dumpfile(`waveform_output);
  $dumpvars(0, clk,reset,pc_out,alu_result,state,hold,opcode,zero);

   clk <=0;
   `simulation_time;
   $finish;
  end

 always
  begin
   #5 clk = ~clk; reset=0;
  end

endmodule
