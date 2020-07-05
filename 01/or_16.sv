`ifndef or_n2t
  `include "or_n2t.sv"
`endif
`define or_16 1

module or_16(
    input[15:0] a,
    input[15:0] b,
    output[15:0] out
);

   genvar 	 j;
   generate
      for (j = 0; j < 16; j = j + 1) begin
	 or_n2t o(.a(a[j]), .b(b[j]), .out(out[j]));
      end
   endgenerate

endmodule
