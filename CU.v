`timescale 1ns / 1ps

/*
Controls entire data flow.
See READ_ME for details.
Harvard Architecture.
*/

`include "Parameter.v"
`include "DMEM.v"
`include "ALU.v"
`include "IMEM.v"
`include "Register.v"
`include "PC.v"

module CU(
 input clk,
 input reset,
 output[15:0] pc_out,
 output [7:0] alu_result,
 output reg [2:0] state,
 output reg hold,
 output [3:0] opcode,
 output zero);

//for PC
reg [7:0] pc_current;
wire [7:0] pc_next;
reg [6:0] branch_immem;
reg [6:0] jump_line;
reg jump,branch,mem_write,alu_src,mem_to_reg,reg_write;
//reg hold;

//for imem
wire [15:0] instruction;

//for GPRu
reg    WR,RA;
reg  [2:0] rd;
reg  [7:0] rd_data;
reg  [2:0] ra;
wire [7:0] ra_data;
reg  [2:0] rb;
wire [7:0] rb_data;

//for ALU
reg [2:0] alu_control;
reg [7:0] a,b;
wire [7:0] result;
//wire zero;
wire carry;

//for DMEM
reg [7:0] mem_access_addr;
reg [7:0] mem_write_data;
reg mem_write_en;
reg mem_read;
wire [7:0] mem_read_data;

//for CU
//reg [3:0] opcode;
//reg [2:0] state;
reg [5:0] imm;

ProgramCounter PC(pc_current,reset, clk,jump,branch,hold,branch_immem,jump_line,pc_next);

Instruction_Memory IM(.pc(pc_current),.instruction(instruction));

GPRs REG(clk,WR, RA,rd,rd_data,ra,ra_data,rb,rb_data);

ALU alu_unit(a,b,alu_control,result,zero,carry);

Data_Memory DM(clk,mem_access_addr,mem_write_data,mem_write_en,mem_read,mem_read_data);

assign opcode = instruction[15:12];

initial begin
pc_current=0;
hold=0;
state=0;
end

always @(posedge clk)
begin


case(opcode)
4'b0000: begin      //ALU direct data processing
  //hold=1;
  rd=instruction[11:9];
  ra=instruction[8:6];
  rb=instruction[5:3];
  alu_control=instruction[2:0];
  {jump,branch,mem_write,alu_src,mem_to_reg,reg_write}=6'b000001;

  case(state)
  3'b000: begin      //read ra, rb from Instructions
    hold=1;
    RA=1;
    state=state+1;
  end
  3'b001: begin      //latency
    state=state+1;
  end
  3'b010: begin      //set up ALU parameters
    RA=0;
    a=ra_data;
    b=rb_data;
    state=state+1;
  end
  3'b011: begin      //allow ALU to process
    rd_data=result;
    state=state+1;
    WR=1;
  end
  3'b100: begin        //write to register
    WR=1;
    state=state+1;
  end
  3'b101: begin
    WR=0;
    rd=3'd0;
    state=state+1;
  end
  3'b110: begin        //write to register
    //WR=1;
    rd_data={7'd0,carry};
    state=state+1;
    hold=0;
  end
  3'b111: begin        //latency
    WR=0;
    state=0;
    hold=1;
  end
  endcase
end

4'b0100:
  begin      //addi rd<=ra+imm
  //hold=1;
  ra=instruction[8:6];
  rd=instruction[5:3];
  imm={instruction[11:9],instruction[2:0]};
  alu_control=0;
  {jump,branch,mem_write,alu_src,mem_to_reg,reg_write}=6'b000001;

  case(state)
  3'b000: begin        //read ra, imem from Instructions
    hold=1;
    RA=1;
    state=state+1;
  end
  3'b001: begin        //buffer
    state=state+1;
  end
  3'b010: begin        //setup data
    RA=0;
    a=ra_data;
    b={2'b00,imm};
    state=state+1;
  end
  3'b011: begin        //process with ALU
    state=state+1;
  end
  3'b100: begin        //begin write to register
    rd_data=result;
    $display("result",result);
    state=state+1;
  end
  3'b101: begin        //write to register
    WR=1;
    state=state+1;
  end
  3'b110: begin        //write to register
    state=state+1;
    hold=0;
  end
  3'b111:
  begin        //one cycle for latency
    WR=0;
    state=0;
    hold=1;
  end
  endcase
end

4'b0101:
  begin      //subi rd<=ra+imm
  //hold=1;
  ra=instruction[8:6];
  rd=instruction[5:3];
  imm={instruction[11:9],instruction[2:0]};
  alu_control=3'b001;
  {jump,branch,mem_write,alu_src,mem_to_reg,reg_write}=6'b000001;

  case(state)
  3'b000: begin        //read ra, imem from Instructions
    hold=1;
    RA=1;
    state=state+1;
  end
  3'b001: begin        //buffer
    state=state+1;
  end
  3'b010: begin        //setup data
    RA=0;
    a=ra_data;
    b={2'b00,imm};
    state=state+1;
  end
  3'b011: begin        //process with ALU
    state=state+1;
  end
  3'b100: begin        //begin write to register
    rd_data=result;
    $display("result",result);
    state=state+1;
  end
  3'b101: begin        //write to register
    WR=1;
    state=state+1;
  end
  3'b110: begin        //write to register
    state=state+1;
    hold=0;
  end
  3'b111:
  begin        //one cycle for latency
    WR=0;
    state=0;
    hold=1;
  end
  endcase
end

4'b1011: begin      //load value.
//  hold=1;
  ra=instruction[8:6];
  rd=instruction[5:3];
  imm={instruction[11:9],instruction[2:0]};
  alu_control=0;
  {jump,branch,mem_write,alu_src,mem_to_reg,reg_write}=6'b000111;

  case(state)
  3'b000: begin        //read ra, imem from Instructions
    hold=1;
    RA=1;
    state=state+1;
  end
  3'b001: begin        //read from memory
    RA=0;
    mem_access_addr=ra_data+{2'b00,imm};
    state=state+1;
  end
  3'b010: begin        //read from memory
    mem_read=1;
    state=state+1;
  end
  3'b011: begin        //write to register rd
    rd_data=mem_read_data;
    mem_read=0;
    state=state+1;
  end
  3'b100: begin        //write to register rd
    WR=1;
    state=state+1;
    hold=0;
  end
  3'b101:
  begin        //one cycle for latency
    WR=0;
    state=0;
    hold=1;
  end
  endcase
end

4'b1111: begin       //store value
  //hold=1;
  ra=instruction[8:6];
  rb=instruction[5:3];
  imm={instruction[11:9],instruction[2:0]};
  alu_control=0;
  {jump,branch,mem_write,alu_src,mem_to_reg,reg_write}=6'b001100;

  case(state)
  3'b000: begin        //read ra,rb imem from Instructions
    hold=1;
    RA=1;
    state=state+1;
  end
  3'b001: begin        //write to data mem
    mem_access_addr=ra_data+{2'b00,imm};
    state=state+1;
  end
  3'b010: begin        //latency
    RA=0;
    mem_write_data=rb_data;
    mem_write_en=1;
    state=state+1;
  end
  3'b011: begin        //latency
    state=state+1;
    hold=0;
  end
  3'b100: begin        //latency
    mem_write_en=0;
    state=0;
    hold=1;
  end
  endcase

end

4'b1000: begin      //branch if equal
  //hold=1;
  ra=instruction[8:6];
  rb=instruction[5:3];
  imm={instruction[11:9],instruction[2:0]};
  alu_control=3'b001;
  {jump,branch,mem_write,alu_src,mem_to_reg,reg_write}=6'b010000;

  case(state)
  3'b000: begin      //read ra, rb from Instructions
    hold=1;
    RA=1;
    state=state+1;
  end
  3'b001: begin      //allow ALU to process
    state=state+1;

  end
  3'b010: begin      //allow ALU to process
    RA=0;
    a=ra_data;
    b=rb_data;
    state=state+1;
  end
  3'b011: begin        //update pc
    if (zero==1'b1) begin
      branch_immem=imm;
      end
    else
      branch=0;
    state=state+1;
    hold=0;
  end
  3'b100: begin     //release all holds
    state=0;
    hold=1;
  end
endcase

end

4'b1001: begin      //branch if not equal
  //hold=1;
  ra=instruction[8:6];
  rb=instruction[5:3];
  imm={instruction[11:9],instruction[2:0]};
  alu_control=3'b001;
  {jump,branch,mem_write,alu_src,mem_to_reg,reg_write}=6'b010000;

  case(state)
  3'b000: begin      //read ra, rb from Instructions
    hold=1;
    RA=1;
    state=state+1;
  end
  3'b001: begin      //allow ALU to process
    state=state+1;

  end
  3'b010: begin      //allow ALU to process
    RA=0;
    a=ra_data;
    b=rb_data;
    state=state+1;
  end
  3'b011: begin        //update pc
    if (zero==1'b0) begin
      branch_immem=imm;
      end
    else
      branch=0;
    state=state+1;
    hold=0;
  end
  3'b100: begin     //release all holds
    state=0;
    hold=1;
  end
endcase

end

4'b0010: begin        //jump
  case(state)
  3'b000: begin
  hold=0;
  {jump,branch,mem_write,alu_src,mem_to_reg,reg_write}=6'b100000;
  jump_line=instruction[6:0];
  state=state+1;
  end
  3'b001: begin
  hold=1;
  jump=0;
  state=0;
  end
  endcase
end

4'b0111: begin
  $display("End Of Program");
  hold=1;
end


4'b0011: begin      //mov Ra Rb
  //hold=1;
  ra=instruction[11:9];
  rd=instruction[8:6];
  alu_control=0;
  {jump,branch,mem_write,alu_src,mem_to_reg,reg_write}=6'b000001;

  case(state)
  3'b000: begin      //read ra from Instructions
    hold=1;
    RA=1;
    state=state+1;
  end
  3'b001: begin      //latency
    state=state+1;
  end
  3'b010: begin      //set up rd
    RA=0;
    rd_data=ra_data;
    state=state+1;
  end
  3'b011: begin      //allow latency to process
    state=state+1;
    WR=1;
  end
  3'b100: begin        //write to register ra (0)
    WR=0;
    rd=ra;
    rd_data=0;
    state=state+1;
  end
  3'b101: begin
    WR=1;
    state=state+1;
  end
  3'b110: begin        //write to register
    state=state+1;
    hold=0;
  end
  3'b111: begin        //latency
    WR=0;
    state=0;
    hold=1;
  end
  endcase
end

endcase

pc_current=pc_next;
end

 assign pc_out = pc_current;
 assign alu_result = result;
endmodule
