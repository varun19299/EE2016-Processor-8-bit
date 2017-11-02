`timescale 1ns / 1ps

/*
Testbench for ALU module
*/
`include "Parameter.v"
`include "ALU.v"

module test_ALU;

 // Inputs
 reg [7:0] a;
 reg  [7:0] b;
 reg [2:0] cnt;
 wire [7:0] c;
 wire zero;

 // Instantiate the Unit Under Test (UUT)
 ALU uut (a,b,cnt,c,zero
 );

 initial
  begin

  $dumpfile("./Waveforms/test_ALU.vcd");
  $dumpvars(0, a,b,cnt,c,zero);

   a=8'd0;
   b=8'd0;
   cnt=3'd0;

   #20 begin
   a=8'd2;
   b=8'd5;
   cnt=3'd0;
   end

   #30 begin
   a=8'd10;
   b=8'd13;
   cnt=3'd0;
   end

   #40 begin

   a=8'd2;
   b=8'd1;
   cnt=3'd1;

   end

   #50 begin
   a=8'd10;
   b=8'd13;
   cnt=3'd2;
   end

   #60 begin
   a=8'd10;
   b=8'd13;
   cnt=3'd3;
   end

   #70 begin
   a=8'd10;
   b=8'd13;
   cnt=3'd4;
   end

   #80 begin
   a=8'd10;
   b=8'd13;
   cnt=3'd5;
   end

   #90 begin
   a=8'd10;
   b=8'd13;
   cnt=3'd6;
   end

   #100 begin
   a=8'd10;
   b=8'd13;
   cnt=3'd7;
   end

   #110 begin
   a=8'd2;
   b=8'd5;
   cnt=3'd0;
   end


   `simulation_time;
   $finish;
  end

endmodule
