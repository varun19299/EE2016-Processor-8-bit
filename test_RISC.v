`timescale 1ns / 1ps

/*
Testbench for RISC module
*/
`include "Parameter.v"
`include "RISC.v"

module test_Risc_8_bit;

 // Inputs
 reg clk;

 // Instantiate the Unit Under Test (UUT)
 Risc_8_bit uut (
  .clk(clk)
 );

 initial
  begin
   clk <=0;
   `simulation_time;
   $finish;
  end

 always
  begin
   #5 clk = ~clk;
  end

endmodule
