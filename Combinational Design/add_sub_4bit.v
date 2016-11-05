   
module adder_sub_4bit(sum, c_in, a, b, sub, c_out);
  
  input [3:0] a, b;
  input c_in, sub;
  output [3:0] sum;
  output c_out; 
  wire c1,c2,c0, c_in1;
  wire [3:0] neg_b, b1;
  
  not n0(neg_b[0], b[0]);
  not n1(neg_b[1], b[1]);
  not n2(neg_b[2], b[2]);
  not n3(neg_b[3], b[3]);
  
  mux2to1_gate mux0 (neg_b[0], b[0], sub, b1[0]); //sel 1 for negative
  mux2to1_gate mux1 (neg_b[1], b[1], sub, b1[1]);
  mux2to1_gate mux2 (neg_b[2], b[2], sub, b1[2]);
  mux2to1_gate mux3 (neg_b[3], b[3], sub, b1[3]);
 
  //mux2to1_gate mux4 (1'b1, c_in, sel, c_in1);
  
  full_adder_1bit a1(sum[0], c_in, a[0], b1[0], c0);
  full_adder_1bit a2(sum[1], c0, a[1], b1[1], c1);
  full_adder_1bit a3(sum[2], c1, a[2], b1[2], c2);
  full_adder_1bit a4(sum[3], c2, a[3], b1[3], c_out);
  
endmodule

module test_add_sub;
  reg[0:3] a,b;
   wire[0:3] sum;
   reg c_in, sub;
   wire cout;
   adder_sub_4bit a1(sum, c_in, a, b, sub, c_out);
   initial
   begin
      $display("add_sub");
       $monitor(,$time,"a=%b, b=%b, c_in=%b, sum=%b, c_out=%b, sub=%b", a, b, c_in, sum, c_out, sub);
      #0 a=4'd2; b=4'd1; c_in=1'b1; sub = 1'b1;
      #5 a=4'd7; b=4'd6; c_in=1'b1; sub = 1'b1;
      #100 $finish;
  end
endmodule