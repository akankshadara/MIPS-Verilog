module jkff_test;
  reg j,k,clk;
  wire q;
  jk_ff f(j,k,clk, q);
  initial 
  begin
     clk=0;
  end

 always
    #1 clk=~clk;

  initial
  $monitor($time,"j=%b,k=%b,q=%b",j,k,q);
  initial
  begin
      j=0;k=0;
      #4 j=0;k=0;
      #2 j=1;k=0;
      #2 j=0;k=1;
      #2 j=1;k=1;
  end
endmodule
