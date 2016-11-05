module bcd_gray_gate(inp,out);
    output [3:0] out;
    input [3:0] inp;
    
    and a1(out[3],inp[3],1);
    xor x1(out[2],inp[3],inp[2]);
    xor x2(out[1],inp[2],inp[1]);
    xor x3(out[0],inp[1],inp[0]);
    
endmodule

module tb_bcd_gray;
  reg[3:0] in;
  wire[3:0] out;
  bcd_gray_gate g1(in, out);
  initial
  begin
    $monitor(, $time, "in:%b ,out:%b", in, out);
    #0 in=4'd0;
    #2 in=4'd1;
    #3 in=4'd2;
    #4 in=4'd3;
    #5 in=4'd4;
  end
endmodule
  