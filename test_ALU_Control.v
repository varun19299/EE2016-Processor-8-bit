`timescale 1ns / 1ps

/*
Testbench for ALU_Control module
*/
`include "Parameter.v"
`include "ALU_control.v"

module test_ALU_Control;

 // Inputs and Outputs
 wire [2:0] ALU_Cnt;
 reg [1:0] ALUOp;
 reg [3:0] Opcode;

 // Instantiate the Unit Under Test (UUT)
 alu_control uut (ALU_Cnt,ALUOp,Opcode);

 initial
  begin

  $dumpfile("./Waveforms/test_ALU_Control.vcd");
  $dumpvars(0,ALU_Cnt,ALUOp,Opcode);


   #50 begin
   {ALUOp,Opcode}=6'b10xxxx;
   end

   #60 begin
   {ALUOp,Opcode}=6'b01xxxx;
   end

   #70 begin
   {ALUOp,Opcode}=6'b10xxxx;
   end

   #80 begin
   {ALUOp,Opcode}=6'b000010;
   end

   #90 begin
   {ALUOp,Opcode}=6'b000011;
   end

   #100 begin
   {ALUOp,Opcode}=6'b000100;
   end

   #110 begin
   {ALUOp,Opcode}=6'b000101;
   end

   #120 begin
   {ALUOp,Opcode}=6'b000110;
   end

   #130 begin
   {ALUOp,Opcode}=6'b000111;
   end

   #140 begin
   {ALUOp,Opcode}=6'b001000;
   end

   #150 begin
   {ALUOp,Opcode}=6'b001001;
   end

   `simulation_time;
   $finish;
  end

endmodule
