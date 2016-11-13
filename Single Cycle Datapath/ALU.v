module or_32bit(out, a, b);
  input[31:0] a, b;
  output[31:0] out;
  assign {out} = a|b;
endmodule

module and_32bit(out, a, b);
  input[31:0] a, b;
  output[31:0] out;
  assign {out} = a&b;
endmodule

module FullAdder_32bit(cout, sum, a, b, cin);
  input[31:0] a, b;
  input cin;
  output[31:0] sum;
  output cout;
  
  assign {cout, sum} = a+b+cin;
endmodule


module mux2to1(sel, a, b, out);
  input a, b, sel;
  output out;
  
  wire sel0, a1, a2;
  
  not n1(sel0, sel);
  
  and and1(a1, sel, a);
  and and2(a2, sel0, b);
  
  or or1(out, a1, a2);
  
endmodule



module mux_8bit_2to1(sel, a, b, out);
  input [7:0] a, b;
  output [7:0] out;
  input sel;
  
  mux2to1 m0(sel, a[0], b[0], out[0]);
  mux2to1 m1(sel, a[1], b[1], out[1]);
  mux2to1 m2(sel, a[2], b[2], out[2]);
  mux2to1 m3(sel, a[3], b[3], out[3]);
  mux2to1 m4(sel, a[4], b[4], out[4]);
  mux2to1 m5(sel, a[5], b[5], out[5]);
  mux2to1 m6(sel, a[6], b[6], out[6]);
  mux2to1 m7(sel, a[7], b[7], out[7]);
  
endmodule
  
module mux_32bit(sel, a, b, out);
  input [31:0] a, b;
  input sel;
  output [31:0] out;
  
  mux_8bit_2to1 m1(sel, a[7:0], b[7:0], out[7:0]);
  mux_8bit_2to1 m2(sel, a[15:8], b[15:8], out[15:8]);
  mux_8bit_2to1 m3(sel, a[23:16], b[23:16], out[23:16]);
  mux_8bit_2to1 m4(sel, a[31:24], b[31:24], out[31:24]);
  
endmodule

module bit32_4to1mux(sel, a, b, c, out);
  input[31:0] a, b, c;
  output[31:0] out;
  input[1:0] sel;
  
  generate
    genvar j;
    for(j=0; j<32; j=j+1)
    begin: mux_loop
      mux4to1 m(sel, a[j], b[j], c[j], 1'b0, out[j]);
   end
 endgenerate
endmodule 
  


module ALU_32bit(resumodule or_32bit(out, a, b);
  input[31:0] a, b;
  output[31:0] out;
  assign {out} = a|b;
endmodule

module and_32bit(out, a, b);
  input[31:0] a, b;
  output[31:0] out;
  assign {out} = a&b;
endmodule

module FullAdder_32bit(cout, sum, a, b, cin);
  input[31:0] a, b;
  input cin;
  output[31:0] sum;
  output cout;
  
  assign {cout, sum} = a+b+cin;
endmodule


module mux2to1(sel, a, b, out);
  input a, b, sel;
  output out;
  
  wire sel0, a1, a2;
  
  not n1(sel0, sel);
  
  and and1(a1, sel, a);
  and and2(a2, sel0, b);
  
  or or1(out, a1, a2);
  
endmodule



module mux_8bit_2to1(sel, a, b, out);
  input [7:0] a, b;
  output [7:0] out;
  input sel;
  
  mux2to1 m0(sel, a[0], b[0], out[0]);
  mux2to1 m1(sel, a[1], b[1], out[1]);
  mux2to1 m2(sel, a[2], b[2], out[2]);
  mux2to1 m3(sel, a[3], b[3], out[3]);
  mux2to1 m4(sel, a[4], b[4], out[4]);
  mux2to1 m5(sel, a[5], b[5], out[5]);
  mux2to1 m6(sel, a[6], b[6], out[6]);
  mux2to1 m7(sel, a[7], b[7], out[7]);
  
endmodule
  
module mux_32bit(sel, a, b, out);
  input [31:0] a, b;
  input sel;
  output [31:0] out;
  
  mux_8bit_2to1 m1(sel, a[7:0], b[7:0], out[7:0]);
  mux_8bit_2to1 m2(sel, a[15:8], b[15:8], out[15:8]);
  mux_8bit_2to1 m3(sel, a[23:16], b[23:16], out[23:16]);
  mux_8bit_2to1 m4(sel, a[31:24], b[31:24], out[31:24]);
  
endmodule

module bit32_4to1mux(sel, a, b, c, out);
  input[31:0] a, b, c;
  output[31:0] out;
  input[1:0] sel;
  
  generate
    genvar j;
    for(j=0; j<32; j=j+1)
    begin: mux_loop
      mux4to1 m(sel, a[j], b[j], c[j], 1'b0, out[j]);
   end
 endgenerate
endmodule 
  


module ALU_32bit(result,cout,a,b,cin,binv,op);
  input[31:0] a,b;
  input cin, binv;
  input[1:0] op;
  output[31:0] result;
  output cout;
  
  wire[31:0] not_b, mux_b, and_out, or_out, add_out;
  
  assign not_b = ~b;
  
  mux_32bit m1(binv, not_b, b, mux_b);
  
  and_32bit a1(and_out, a, mux_b);
  or_32bit o1(or_out, a, mux_b);
  FullAdder_32bit fa(cout, add_out, a, mux_b, cin);
  
  bit32_4to1mux m2(op, and_out, or_out, add_out, result);
endmodule


module AND_array(RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp2, Op);
  //main control unit of the datapath
  input [5:0] Op;
  output RegDst, ALUSrc,MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp2;
  wire Rformat, lw, sw, beq;
  
  assign Rformat = (~Op[0])&(~Op[1])&(~Op[2])&(~Op[3])&(~Op[4])&(~Op[5]);
  assign lw = (Op[0])&(Op[1])&(~Op[2])&(~Op[3])&(~Op[4])&(Op[5]);
  assign sw = (Op[0])&(Op[1])&(~Op[2])&(Op[3])&(~Op[4])&(Op[5]);
  assign beq = (~Op[0])&(~Op[1])&(Op[2])&(~Op[3])&(~Op[4])&(~Op[5]);
   
  assign RegDst = Rformat;
  assign ALUSrc = lw|sw;
  assign MemtoReg = lw;
  assign RegWrite = Rformat|lw;
  assign MemRead = lw;
  assign MemWrite = sw;
  assign Branch = beq;  
  assign ALUOp0 = Rformat;
  assign ALUOp1 = beq;
  
endmodule
    
    
module ALU_control(ALUOp, funct, Op);
  input[3:0] funct;
  input[1:0] ALUOp;
  output [2:0] Op;
  
  //dataflow modelling
  assign Op[0] = (ALUOp[1]) & (funct[0]|funct[3]);
  assign Op[1] = (~ALUOp[1]) | (~funct[2]);
  assign Op[2] = (ALUOp[0]) | (ALUOp[1]&funct[1]);
endmodule

module ALU_32bit(result,cout,a,b,cin,binv,op);
  input[31:0] a,b;
  input cin, binv;
  input[1:0] op;
  output[31:0] result;
  output cout;
  
  wire[31:0] not_b, mux_b, and_out, or_out, add_out;
  
  assign not_b = ~b;
  
  mux_32bit m1(binv, not_b, b, mux_b);
  
  and_32bit a1(and_out, a, mux_b);
  or_32bit o1(or_out, a, mux_b);
  FullAdder_32bit fa(cout, add_out, a, mux_b, cin);
  
  bit32_4to1mux m2(op, and_out, or_out, add_out, result);

endmodule


module AND_array(RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp2, Op);
  //main control unit of the datapath
  input [5:0] Op;
  output RegDst, ALUSrc,MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp2;
  wire Rformat, lw, sw, beq;
  
  assign Rformat = (~Op[0])&(~Op[1])&(~Op[2])&(~Op[3])&(~Op[4])&(~Op[5]);
  assign lw = (Op[0])&(Op[1])&(~Op[2])&(~Op[3])&(~Op[4])&(Op[5]);
  assign sw = (Op[0])&(Op[1])&(~Op[2])&(Op[3])&(~Op[4])&(Op[5]);
  assign beq = (~Op[0])&(~Op[1])&(Op[2])&(~Op[3])&(~Op[4])&(~Op[5]);
   
  assign RegDst = Rformat;
  assign ALUSrc = lw|sw;
  assign MemtoReg = lw;
  assign RegWrite = Rformat|lw;
  assign MemRead = lw;
  assign MemWrite = sw;
  assign Branch = beq;  
  assign ALUOp0 = Rformat;
  assign ALUOp1 = beq;
  
endmodule
    
    
module ALU_control(ALUOp, funct, Op);
  input[3:0] funct;
  input[1:0] ALUOp;
  output [2:0] Op;
  
  //dataflow modelling
  assign Op[0] = (ALUOp[1]) & (funct[0]|funct[3]);
  assign Op[1] = (~ALUOp[1]) | (~funct[2]);
  assign Op[2] = (ALUOp[0]) | (ALUOp[1]&funct[1]);
endmodule

