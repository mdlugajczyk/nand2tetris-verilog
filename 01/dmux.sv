`ifndef and_n2t
  `include "and_n2t.sv"
`endif
`define dmux 1

module dmux(
    input  in,
    input  select,
    output a,
    output b
);

   assign a = ~select & in;
   assign b = select & in;

endmodule
