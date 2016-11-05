module mux16_to_1(out,in,sel);
    output out;
    input [15:0] in;
    input [3:0] sel;
    
    wire [3:0] mid;
    
    mux4to1 mux1(mid[0],in[3:0],sel[1:0]);
    mux4to1 mux2(mid[1],in[7:4],sel[1:0]);
    mux4to1 mux3(mid[2],in[11:8],sel[1:0]);
    mux4to1 mux4(mid[3],in[15:12],sel[1:0]);
    mux4to1 mux5(out, mid[3:0], sel[3:2]);  
     
endmodule

module test_16to1_mux;
    reg[15:0] in;
    reg [3:0] sel;
    wire out;
    
    mux16_to_1 mux(out,in,sel);
    initial
    begin
       $monitor("in=%b, out=%b, sel=%b",in,out,sel);
   end
   
   initial
   begin
       in=16'b1000000000000000; sel=4'b1111; 
    #3 in=16'b0100000000000000; sel=4'b1110;
    #3 in=16'b0010000000000000; sel=4'b1101;
    #3 in=16'b0001000000000000; sel=4'b1100;
    #3 in=16'b0000100000000000; sel=4'b1011;
    #3 in=16'b0000010000000000; sel=4'b1010;
    #3 in=16'b0000001000000000; sel=4'b1001;
    #3 in=16'b0000000100000000; sel=4'b1000;
    #3 in=16'b0000000010000000; sel=4'b0111;
    #3 in=16'b0000000001000000; sel=4'b0110;
    #3 in=16'b0000000000100000; sel=4'b0101;
    #3 in=16'b0000000000010000; sel=4'b0100;
    #3 in=16'b0000000000001000; sel=4'b0011;
    #3 in=16'b0000000000000100; sel=4'b0010;
    #3 in=16'b0000000000000010; sel=4'b0001;
    #3 in=16'b0000000000000001; sel=4'b0000;
   end
endmodule