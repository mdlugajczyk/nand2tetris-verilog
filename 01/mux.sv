`ifndef and_n2t
  `include "and_n2t.sv"
`endif
`define mux 1

module mux(
    input  a,
    input  b,
    input  select,
    output out
);
   assign out = (~select & a) | (select & b);
endmodule
