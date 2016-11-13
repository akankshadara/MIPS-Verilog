module test_counter;
  reg clk;
  wire[3:0] count;
  //output[3:0] count;
  
  counter c1(count, clk);
  
  initial 
  begin
    clk = 0;
  end
  
  always
  begin
    #1 clk = ~clk;
 end
 
initial
$monitor($time, "clk=%b, count=%b", clk, count);
initial
begin
#10 $finish;
end
endmodule
  
 
