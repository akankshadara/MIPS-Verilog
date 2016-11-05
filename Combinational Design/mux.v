module mux2to1_gate (a, b, s, out);
  input a, b, s;
  output out;
  wire a1, a2, sn;
  
  
  not n1(sn, s);
  and and1(a1, a, s);
  and and2(a2, b, sn);
  
  or or1(out, a1, a2);
endmodule


//data flow modelling
module mux2to1_df(a,b,s,f);
  input a, b, s;
  output f;
  assign f = s? a:b;
endmodule


//behavioralmodelling 
module mux2to1_beh(a,b,s,f);  
  input a,b,s;
  output f;
  
  reg f;
  always@(s or a or b)
       if(s==1) f=a;
       else f = b;
endmodule


module testbench;
  reg a, b, s;
  wire f;
  mux2to1_gate m(a, b, s, f);
  initial
    begin
      $monitor(,$time, "a=%b, b=%b, s=%b, f=%b", a,b,s,f);
      #0 a=1'b0; b=1'b1;
      #2 s=1'b1;
      #5 s=1'b0;
      #10 a=1'b1; b=1'b0;
      #15  s=1'b1;
      #20  s=1'b0;
      #100 $finish;
  end
endmodule
    

         