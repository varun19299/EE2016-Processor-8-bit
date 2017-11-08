//ALU

module ALU (
  input  [7:0] a,  //src1
   input  [7:0] b,  //src2
   input  [2:0] alu_control, //function sel

   output reg [7:0] result,  //result
   output reg zero,
   output reg carry);

// a and b are 8 bit values stored in registers
always @(*)
begin
 case(alu_control)
 3'b000: {carry,result} = a + b; // add
 3'b001: result = a - b; // sub
 3'b010: result = ~a;
 3'b011: result = a<<b;
 3'b100: result = a>>b;
 3'b101: result = a & b; // and
 3'b110: result = a | b; // or
 3'b111: begin if (a<b) result = 8'd1;
    else result = 8'd0;
    end
 default:result = a + b; // add
 endcase

 zero = (result==8'd0) ? 1'b1: 1'b0;
end


endmodule
