`timescale 1ns / 1ps

/*
Testbench for RISC module
*/
`include "Parameter.v"
`include "Control.v"

module test_Risc_8_bit;

 // Inputs
 reg clk;
 wire [15:0] pc_out;
 wire [7:0] alu_result;

 // Instantiate the Unit Under Test (UUT)
 CU uut (
  clk,pc_out,alu_result
 );

 initial
  begin
  $dumpfile("./Waveforms/test_Control.vcd");
  $dumpvars(0, clk,pc_out,alu_result);

   clk <=0;
   `simulation_time;
   $finish;
  end

 always
  begin
   #5 clk = ~clk;
  end

endmodule
