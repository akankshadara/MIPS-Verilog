module decoder_3to8(x1,y1,z1,out);
  output[7:0] out;
  input x1,y1,z1;
  
  wire x0, y0, z0;
  
  not xn(x0, x1);
  not yn(y0, y1);
  not zn(z0, z1);
  
  and a0(out[0], x0, y0, z0);
  and a1(out[1], x0, y0, z1);
  and a2(out[2], x0, y1, z0);
  and a3(out[3], x0, y1, z1);
  and a4(out[4], x1, y0, z0);
  and a5(out[5], x1, y0, z1);
  and a6(out[6], x1, y1, z0);
  and a7(out[7], x1, y1, z1);
  
endmodule

module test_decoder;
  reg x, y, z;
  wire [7:0] out;
  decoder_3to8 d (x,y,z,out);
  initial
    begin
      $monitor(,$time,"x:%b y:%b z:%b out:%b",x,y,z, out);
      #0 x=1'b0;y=1'b0;z=1'b0;
      #4 x=1'b0;y=1'b0;z=1'b1;
      #4 x=1'b0;y=1'b1;z=1'b0;
      #4 x=1'b0;y=1'b1;z=1'b1;
      #4 x=1'b1;y=1'b0;z=1'b0;
      #4 x=1'b1;y=1'b0;z=1'b1;
      #4 x=1'b1;y=1'b1;z=1'b0;
      #4 x=1'b1;y=1'b1;z=1'b1;
  end
endmodule