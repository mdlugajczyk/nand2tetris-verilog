`ifndef mux
    `include "../01/mux.sv"
`endif
`ifndef dff
    `include "dff.sv"
`endif
`define bit_n2t 1

module bit_n2t(
    input  in,
    input  load,
    input  clk,
    output out
);

   wire    dff_input, dff_output;
   
   mux m(.a(out), .b(in), .select(load), .out(dff_input));
   dff d(.in(dff_input), .clk(clk), .out(out));

endmodule
