module mealy_machine(clk, reset, inp, out);
  input clk, reset, inp;
  output out;
  reg out;
  reg [1:0] state;
  
  always @(posedge clk, posedge reset)
  begin
    if(reset) 
      begin
        state <= 2'b00;
        out <= 1'b0;
      end
    else 
      begin
        case(state)
          2'b00: 
            begin
              if(inp) 
                begin 
                  state <= 2'b01;
                  out <= 1'b0;
                end
              else
                begin
                  state <= 2'b10;
                  out <= 1'b1;
                end
            end
          2'b01:
            begin
              if(inp) 
                begin 
                  state <= 2'b00;
                  out <= 1'b1;
                end
              else
                begin
                  state <= 2'b10;
                  out <= 1'b0;
                end
            end
          2'b10:
            begin
              if(inp) 
                begin 
                  state <= 2'b01;
                  out <= 1'b0;
                end
              else
                begin
                  state <= 2'b00;
                  out <= 1'b1;
                end
            end
            
          default:
            begin
              state <= 2'b00;
              out <= 1'b0;
          end
      endcase
      
  end
end
endmodule
            
module test_mealy;
  
  reg clk, reset, inp;
  wire out;
  reg [15:0] sequence;
  integer i;
  
  mealy_machine mm(clk, reset, inp, out);
  
  initial
  begin
    clk = 0;
    reset = 1;
    sequence = 16'b0101_0111_0111_0010;
    #5 reset = 0;
   
  for(i=0; i<16; i = i+1)
  begin
    #2 clk = 1;
    #2 clk = 0;
    $display("State = ", mm.state, " Input = ", inp, ", Output = ",out);
  end
testing;
end
task testing;
for(i=0; i<=15; i=i+1)
  begin
    inp = $random % 2;
    #2 clk = 1;
    #2 clk = 0;
    $display("State = ", mm.state, " Input = ", inp, ", Output = ",out);
  end
endtask
endmodule 

