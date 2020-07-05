`ifndef and_n2t
  `include "and_n2t.sv"
`endif
`define and_16 1

module and_16(
   input [15:0] a,
   input [15:0] b,
   output [15:0] out
);

   genvar 	 j;
   generate
      for (j = 0; j < 16; j = j + 1) begin
	 and_n2t a(.a(a[j]), .b(b[j]), .out(out[j]));
      end
   endgenerate
endmodule
