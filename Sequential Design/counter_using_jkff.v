module counter(count, clk);
  //4-bit synchronous counter
  input clk;
  output[3:0] count;
  wire[3:0] count;
  wire w1, w2;
  
  jk_ff ff1(1, 1, clk, count[0]);
  jk_ff ff2(count[0], count[0], clk, count[1]);
  and a1 (w1, count[0], count[1]);
  jk_ff ff3(w1, w1, clk, count[2]);
  and a2(w2, w1, count[2]);
  jk_ff ff4(w2, w2, clk, count[3]);
  
endmodule

  
  
  
  
