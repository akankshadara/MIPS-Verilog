//Use FULLADDER() to implement ADDSUB() module which takes two 4-
//bit numbers and one control input M as input argument and produces an
//4-bit sum/sub with an overflow bit V.   
module adder_sub(a, b, sub, carry, overflow, sum);
  input [3:0] a, b;
  output [3:0] sum;
  input sub;
  output carry, overflow;
  
  wire c0, c1, c2;
  wire [3:0] b_final;
  
  //get complement of b
  xor x0(b_final[0], b[0], sub);
  xor x1(b_final[1], b[1], sub);
 xor x2(b_final[2], b[2], sub);
  xor x3(b_final[3], b[3], sub);
  
  full_adder_beh a1(sum[0], c0, a[0], b_final[0], sub);
  full_adder_beh a2(sum[1], c1, a[1], b_final[1], c_in);
  full_adder_beh a3(sum[2], c2, a[2], b_final[2], c_in);
  full_adder_beh a4(sum[3], carry, a[3], b_final[3], c_in);
  
  xor(overflow, carry, c2);
  
endmodule;

module test_adder_sub_beh;
  reg[3:0] a,b;
   wire[3:0] sum;
   reg sub;
   wire carry, overflow;
   adder_sub a1(a, b, sub, carry, overflow, sum);
   initial
   begin
      $display("add_sub");
       $monitor(,$time,"a=%b, b=%b, sub=%b, sum=%b, c_out=%b, overflow=%b", a, b, sub, sum, carry, overflow);
      #0 a=4'd2; b=4'd1; sub = 1'b1;
      #5 a=4'd7; b=4'd6; sub = 1'b1;
      #100 $finish;
  end
endmodule