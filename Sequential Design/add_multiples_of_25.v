//mux to take in x and give out corres multiple of 25
module mux_16entries(out, x);
  input[3:0] x;
  output[8:0] out; 
  assign {out} = x*5'b11001;
endmodule  
 

//adder register: acc module
module adder_register(inp_25multiple, acc, clk, Acc_rst1, Acc_rst2);
      input[8:0] inp_25multiple;
      output[12:0] acc;
      reg[12:0] acc;  
      input Acc_rst1, Acc_rst2, clk;
      
     always@(posedge clk)
    begin
        if(Acc_rst1)begin
            acc<=acc+inp_25multiple;
        end
    end
      
      always@(Acc_rst2)
      acc <= inp_25multiple;
      
      always@(negedge Acc_rst1)
      begin
        acc =  acc - inp_25multiple;
      end
endmodule                
               
  
//d flip flop: behavioral modelling
module d_ff(q, d, clk, reset);
  input clk, reset;
  output q;
  input d;
  reg q;
  initial
  begin
    q <= 1'b0;
end
  always @(posedge clk)
  begin
    if (reset) 
    begin 
    q <= 1'b0;
    end
    else
    begin
     if(q==1'b0)begin
                q<=1'b1;
            end
            else
            begin
                q<=1'b0;
        end
    end
  end
endmodule

//produces acc reset signals
module ACC_RST(clk, reset, rst1, rst2);
    input clk,reset;
    output rst1, rst2;
    wire q1,q2;
    d_ff m1(q1,clk,reset);
    d_ff m2(q2,q1,reset);
    d_ff m3(rst1,q2,reset);
    d_ff m4(rst2,rst1,reset);
     
endmodule
//integrate all modules
module intg(X, clk, reset, Y);
  input[3:0] X;
  input clk, reset;
  output[12:0] Y;
  //wire Acc_rst1, Acc_rst2;
  wire[8:0] multiple;
  wire rst1, rst2;
  
  mux_16entries a0(multiple, X);
  ACC_RST a1(clk, reset, rst1, rst2);
  //modD4 m1(Q,clk,reset);
  adder_register a2(multiple,Y, clk, rst1, rst2);

endmodule

//testbenches

module tb_16entries;
  reg[3:0] x;
  wire [8:0] out;
  mux_16entries m(out, x);
  initial
  begin
    $monitor($time, "x:%b, out:%b", x, out);
    #1 x=4'd2; 
    #2 x=4'd5;
    #3 x=4'd15;
    #4 $finish;
  end
endmodule

module tb;
  reg[3:0] X;
  reg clk, reset;
  wire[12:0] Y;
  intg i(X, clk, reset, Y);
  
  initial
  clk = 0;
  
  always
  #5 clk = ~clk;
   
  initial
  begin
    $monitor($time, "Y:%b, X:%b, clk:%b", Y,  X, clk);
    reset = 0;
    #4 X=4'd10;
    #10 X=4'd5;
    #10 X=4'd12;
    #10 X=4'd1;
    #12 $finish;
  end
endmodule

  
