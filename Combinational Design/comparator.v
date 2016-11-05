module sign_num(neg,num);  
//this module is used to get the sign of an input 4-digit number 
input [3:0] num;
output neg;
reg neg;
always @(num)
  if(num[3] == 1)
    begin
      neg = 1;
    end
  else
    neg = 0;
endmodule


module comparator(a, b, signA, signB, AgtB, AeqB, AltB);
  //This module implement the compare code for input of two 3-digit 
  //numbers using signa().
  input [3:0] a,b;
  output signA, signB, AgtB, AeqB, AltB;
  reg AgtB, AeqB, AltB;
  
  sign_num signa(signA, a);
  sign_num signb(signB, b);
  
  always @ (a or b or signA or signB)
  
  //check for 4 different cases
  
  if(signA==1 && signB==0)
    begin
      AltB = 1;
      AeqB = 0;
      AgtB = 0;
    end
else if(signA==0 && signB==1)
  begin
    AltB=0;
    AeqB=0;
    AgtB=1;
  end
else if(a>b)
  begin 
    AltB=0;
    AeqB=0;
    AgtB=1;
  end
else if(a==b)
  begin
    AltB=0;
    AeqB=1;
    AgtB=0;
  end
else 
  begin
    AltB=1;
    AeqB=0; 
    AgtB=0;
end
endmodule

module testbench_comparator;
  wire inp, clk;
  wire out;
  reg [3:0] a,b;
  wire a1, b1, c1, signA, signB, AgtB, AeqB;
  initial
  begin 
    a = 4'b0000;
    b = 4'b0000;
 	end
 
comparator c(a, b, signA, signB, AgtB, AeqB, AltB);
initial
begin
  $monitor(,$time,"A=%b, B=%b, AgtB=%b, AeqB=%b, AltB=%b", a, b, AgtB, AeqB, AltB);  
    #1  a=-8; b=-5;
    #1  a=2; b=7;
    #1 a=5; b=-1;
    #5 $finish;
end
endmodule
  
