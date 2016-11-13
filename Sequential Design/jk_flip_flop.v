module jk_flip_flop(j, k, clk, Q);
  input j, k, clk;
  output Q;
  reg Q;  
  always@(posedge clk)
  begin
    Q <= (j&&~Q)||(~k&&Q);
  end
endmodule
  
module test_jk_ff;
  reg j, k, clk;
  wire Q;
  
  jk_flip_flop jkff(j, k, clk, Q);
  
  initial
    clk = 0;
    
  
  always
  #2 clk = ~clk;
  
  initial begin
 j=0; k=0; 
 #2
 j=1; k=1; 
 #2
 j=0; k=1;
 #2
 j=1; k=0;
end

initial
$monitor($time, "j:%b k:%b Q:%b, clk:%b", j, k, Q, clk);
  
endmodule 