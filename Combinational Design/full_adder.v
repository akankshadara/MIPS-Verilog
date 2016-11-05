module full_adder_1bit(sum, c_in, a, b, c_out);
  
input a, b,c_in;
output sum, c_out;
  
wire c1, s1, c2;

  xor(s1, a, b);
  and(c1, a, b);
  
  and(c2, c_in, c1);
 
  xor(sum, c2, s1);
 
  or(c_out, c1, c2); 
endmodule

module tb_fadder_1bit;
  reg a, b, c_in ;
  wire c_out, sum;
  full_adder_1bit fa(sum, c_in, a, b, c_out);
  initial
    begin
      $monitor(,$time,"a=%b, b=%b, c_in=%b, sum=%b, c_out=%b", a,b,c_in, sum, c_out);
      #0 a=1'b0; b=1'b1; c_in=1'b0;
      #5 a=1'b1; b=1'b1; c_in=1'b0;
      #100 $finish;
  end
endmodule
