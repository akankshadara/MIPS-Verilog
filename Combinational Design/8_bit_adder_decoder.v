module adder_8bit_decoder(sum, c_in, a, b, c_out)
    input c_in;
    input [7:0] a;
    input [7:0] b;
    output [7:0] sum;
    output c_out; 
    wire [6:0] c;
    
    one_bit_adder_decoder a0(sum[0],c_in,a[0],b[0],c[0]);
    generate
		genvar j;
		for(j=1;j<7;j=j+1)
			begin:fa_loop
					one_bit_adder_decoder a1(sum[j],c[j],a[j],b[j],c[j-1]);
			end
	  endgenerate
endmodule

module tb_8bit_adder_dec;
   reg[7:0] a,b;
   wire[7:0] sum;
   reg c_in;
   reg cout;
   adder_8bit_decoder a1(sum, c_in, a, b, c_out);
   initial
   begin
       $monitor(,$time,"a=%b, b=%b, c_in=%b, sum=%b, c_out=%b", a,b,c_in, sum, c_out);
      #0 a=8'd15; b=8'd1; c_in=1'b0;
      #5 a=8'd1; b=8'd7; c_in=1'b0;
      #100 $finish;
  end
endmodule