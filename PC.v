module ProgramCounter
(
input [7:0]d_in,
input reset, clk,jump,
input [7:0] jump_line,
output reg [7:0] d_out
);

/*
8 bit register.
 Under normal operations, will always increment by 1 on every clock cycle,
to access the next instruction. In case of a JUMP or BRANCH type of instruction,
 will go to the value specified by the output of the ALU
or the immediate operand in the instruction.

*/

always @(posedge clk)
if (reset)
d_out <= 8'b00000000;
else if (jump)
d_out<=jump_line;
else
d_out <= d_in + 1;
endmodule
