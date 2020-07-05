`ifndef or_n2t
  `include "or_n2t.sv"
`endif
`define or_8_way 1

module or_8_way(
    input [7:0] in,
    output      out
);

   assign out = in[0] | in[1] | in[2] | in[3] | in[4] | in[5] | in[6] | in[7];
endmodule
