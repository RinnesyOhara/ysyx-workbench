module top(
  input clk,
  input rst,
  output [15:0] led
);
    
  light dut(
    .clk 	(clk  ),
    .rst 	(rst  ),
    .led 	(led  )
  );
  
endmodule