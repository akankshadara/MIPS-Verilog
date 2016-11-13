module jk_ff(j, k, clk, q);
  input j, k, clk;
  output q;
  reg q;
  
  always@(posedge clk)
  begin
    q <= (j&~q)|(~k&q);
  end
endmodule


  
