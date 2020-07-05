`ifndef dmux_4_way
  `include "dmux_4_way.sv"
`endif
`define dmux_8_way 1

module dmux_8_way(
    input       in,
    input [2:0] select,
    output      a,
    output      b,
    output      c,
    output      d,
    output      e,
    output      f,
    output      g,
    output      h
);
   dmux_4_way d1(in & ~select[2], select[1:0], a, b, c, d);
   dmux_4_way d2(in & select[2], select[1:0], e, f, g, h);
endmodule
