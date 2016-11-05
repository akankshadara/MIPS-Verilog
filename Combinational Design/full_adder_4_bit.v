
module full_adder_4bit(sum, c_in, a, b, c_out);
  input [3:0] a, b;
  input c_in;
  output [3:0] sum;
  output c_out; 
  wire c1,c2,c0;
 
  full_adder_1bit a1(sum[0], c_in, a[0], b[0], c0);
  full_adder_1bit a2(sum[1], c0, a[1], b[1], c1);
  full_adder_1bit a3(sum[2], c1, a[2], b[2], c2);
  full_adder_1bit a4(sum[3], c2, a[3], b[3], c_out);
  
endmodule

module tb_4bit_adder;
   reg[0:3] a,b;
   wire[0:3] sum;
   reg c_in;
   reg cout;
   full_adder_4bit fa1(sum, c_in, a, b, c_out);
   initial
   begin
       $monitor(,$time,"a=%b, b=%b, c_in=%b, sum=%b, c_out=%b", a,b,c_in, sum, c_out);
      #0 a=4'd0; b=4'd1; c_in=1'b0;
      #5 a=4'd1; b=4'd7; c_in=1'b0;
      #100 $finish;
  end
endmodule

