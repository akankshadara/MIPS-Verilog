module mux4to1(out, in, s);
  input [3:0] in;
  input [1:0] s;
  output out;
  wire n1, n0, a1, a2, a3, a0;
  
  not not0(n0,s[0]);
  not not1(n1,s[1]);
    
  and and0(a0,in[0],n1,n0);
  and and1(a1,in[1],n1,s[0]);
  and and2(a2,in[2],s[1],n0);
  and and3(a3,in[3],s[0],s[1]);
    
  or or1(out,a0,a1,a2,a3);
endmodule

module tb_mux_4to1;
  reg [3:0] in;
  reg [1:0] s;
  wire out;
  mux4to1 m1(out, in, s);
  initial
    begin
      $monitor(,$time,"out=%b, in=%b, sel=%b", out, in, s);
      #5 s=2'b00;
      #5 in=4'b0001;
      #8 s=2'b01;
      #10 in=4'b0010;
      #15 s=2'b10;
      #100 $finish;
  end
endmodule
  
  


