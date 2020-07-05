`ifndef inc_16
    `include "../02/inc_16.sv"
`endif
`ifndef mux_16
    `include "../01/mux_16.sv"
`endif
`ifndef or_n2t
    `include "../01/or_n2t.sv"
`endif
`ifndef register_n2t
    `include "register_n2t.sv"
`endif
`define pc 1

module pc(
    input  [15:0] in,
    input         load,
    input         inc,
    input         reset,
    input         clk,
    output [15:0] out
);

   wire [15:0] 	  incremented;

   inc_16 increment(.in(out), .out(incremented));

   wire [15:0] 	  inc_mux_output;
   mux_16 inc_mux(.a(out), .b(incremented), .select(inc), .out(inc_mux_output));
   wire [15:0] 	  load_mux_output;
   mux_16 load_mux(.a(inc_mux_output), .b(in), .select(load), .out(load_mux_output));
   wire [15:0] 	  reset_mux_output;
   mux_16 reset_mux(.a(load_mux_output), .b(16'b0), .select(reset), .out(reset_mux_output));

   register_n2t r(.in(reset_mux_output), .load(1'b1), .clk(clk), .out(out));
   

endmodule
