`ifndef bit_n2t
    `include "bit_n2t.sv"
`endif
`define register_n2t 1

module register_n2t(
    input  [15:0] in,
    input         load,
    input         clk,
    output [15:0] out
);

   genvar 	  i;
   generate
      for (i = 0; i < 16; i = i + 1) begin
	 bit_n2t b(.in(in[i]), .load(load), .clk(clk), .out(out[i]));
      end
   endgenerate

endmodule
