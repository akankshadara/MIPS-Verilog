module one_bit_adder_decoder(sum, c_in, a, b, c_out);
  output sum, c_out;
  input a,b;
  input c_in;
  wire[7:0] w;
  
  decoder_3to8 d1(a, b, c_in, w);
  or a1(sum, w[1], w[2], w[4], w[7]);
  or a2(c_out, w[3], w[5], w[6], w[7]);
  
endmodule

module tb_add_1bit;
  reg a, b, c_in ;
  wire c_out, sum;
  one_bit_adder_decoder add(sum, c_in, a, b, c_out);
  initial
    begin
      $monitor(,$time,"a=%b, b=%b, c_in=%b, sum=%b, c_out=%b", a,b,c_in, sum, c_out);
      #0 a=1'b0; b=1'b1; c_in=1'b0;
      #5 a=1'b1; b=1'b1; c_in=1'b0;
      #100 $finish;
  end
endmodule
  
