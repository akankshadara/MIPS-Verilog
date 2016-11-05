module bit8_FA(sum,cout,in1,in2,cin);
	output [7:0] sum;
	output cout;
	input cin;
	input [7:0] in1,in2;
	wire [6:0] carry_mid;
	
	FADDER f1(sum[0],carry_mid[0],in1[0],in2[0],cin);
	
	generate
		genvar j;
		for(j=1;j<7;j=j+1)
			begin:fa_loop
				full_adder_1_bit f2(sum[j],carry_mid[j],in1[j],in2[j],carry_mid[j-1]);
			end
	endgenerate
	
	full_adder_1_bit f3(sum[7],cout,in1[7],in2[7],carry_mid[6]);			
endmodule

module bit32_FA(sum,cout,in1,in2,cin);
	output [31:0] sum;
	output cout;
	input [31:0] in1,in2;
	input cin;
	wire [2:0] carry_mid;

	bit8_FA f1(sum[7:0],carry_mid[0],in1[7:0],in2[7:0],cin);
	bit8_FA f2(sum[15:8],carry_mid[1],in1[15:8],in2[15:8],carry_mid[0]);
	bit8_FA f3(sum[23:16],carry_mid[2],in1[23:16],in2[23:16],carry_mid[1]);
	bit8_FA f4(sum[31:24],cout,in1[31:24],in2[31:24],carry_mid[2]);
endmodule
