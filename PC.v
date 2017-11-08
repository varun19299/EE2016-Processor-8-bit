module ProgramCounter
(
input [7:0]d_in,
input reset, clk,jump,branch,hold,
input [6:0] branch_immem,
input [6:0] jump_line,
output reg [7:0] d_out
);

`include "Parameter.v"

/*
8 bit register.
 Under normal operations, will always increment by 1 on every clock cycle,
to access the next instruction. In case of a JUMP or BRANCH type of instruction,
 will go to the value specified by the output of the ALU
or the immediate operand in the instruction.

*/

//if hold then only operate

always @(clk) begin
if (hold==1'b0) begin
  if (reset)
  d_out <= 8'b00000000;
  else if (jump==1'b1)
  d_out<=jump_line; //jump_line is 7 bits length
  else if (branch==1'b1)
  d_out<={2'b00,branch_immem}; //immem is max 6 bits long
  else if (d_in== `col_memory)
  d_out<=d_in;        //EOP
  else
  d_out <= d_in + 1;
end

else
d_out<=d_in;
end
endmodule
