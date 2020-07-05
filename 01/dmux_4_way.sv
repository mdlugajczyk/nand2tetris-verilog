`ifndef dmux
  `include "dmux.sv"
`endif
`define dmux_4_way 1

module dmux_4_way(
    input       in,
    input [1:0] sel,
    output      a,
    output      b,
    output      c,
    output      d
);

   dmux d1(in & ~sel[1], sel[0], a, b);
   dmux d2(in & sel[1], sel[1] & sel[0], c, d);
endmodule
