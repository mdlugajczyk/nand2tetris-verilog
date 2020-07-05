`ifndef mux
  `include "mux.sv"
`endif
`define mux_16 1

module mux_16(
    input  [15:0] a,
    input  [15:0] b,
    input         select,
    output [15:0] out
);

   genvar 	  j;
   generate
      for (j = 0; j < 16; j = j + 1) begin
	 mux m(.a(a[j]), .b(b[j]), .select(select), .out(out[j]));
      end
   endgenerate

endmodule
