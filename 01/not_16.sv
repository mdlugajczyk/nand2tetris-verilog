`ifndef not_n2t
   `include "not_n2t.sv"
`endif
`define not_16 1

module not_16(
    input [15:0] in,
    output [15:0] out
);

   genvar 	  j;
   generate
      for (j = 0; j < 16; j = j + 1) begin
	 not_n2t n(.in(in[j]), .out(out[j]));
      end
   endgenerate

endmodule
