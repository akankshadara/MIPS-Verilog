//to implement a full adder using behavioral modelling
module full_adder_beh(sum, c_out, a, b, c_in);
  input a, b, c_in;
  output c_out, sum;
  
  reg sum, c_out;
  
  always @(a or b or c_in)
    {sum, c_out} = a + b + c_in;
  
endmodule

module test_FA_beh;
  wire sum, cout;
  reg a, b, c_in;
  full_adder_beh fa(sum, c_out, a, b, c_in);
   initial
    begin
       $monitor(,$time,"a=%b,b=%b,c_in=%b|sum=%b,c_out=%b",a,b,c_in,sum,c_out);
   end
   
   initial
   begin
       #0 a=1'b0; b=1'b0; c_in=1'b0;
       #4 a=1'b1; b=1'b0; c_in=1'b0;
       #4 a=1'b0; b=1'b1; c_in=1'b0;
       #4 a=1'b1; b=1'b1; c_in=1'b0;
       #4 a=1'b0; b=1'b0; c_in=1'b1;
       #4 a=1'b1; b=1'b0; c_in=1'b1;
       #4 a=1'b0; b=1'b1; c_in=1'b1;
       #4 a=1'b1; b=1'b1; c_in=1'b1;
   end
endmodule
  
