`ifndef and_n2t
    `include "../01/and_n2t.sv"
`endif
`ifndef dmux_8_way
    `include "../01/dmux_8_way.sv"
`endif
`ifndef mux_8_way_16
    `include "../01/mux_8_way_16.sv"
`endif
`ifndef register_n2t
    `include "register_n2t.sv"
`endif
`define ram_8 1

module ram_8(
    input  [15:0] in,
    input  [2:0]  address,
    input         load,
    input         clock,
    output [15:0] out
);

   wire [7:0] 	  load_signals;
   wire [7:0][15:0] register_outputs;

   genvar 	    j;
   generate
      for (j = 0; j < 8; j = j + 1) begin
	 register_n2t register(.in(in), .load(load_signals[j]), .clk(clock), .out(register_outputs[j]));
      end
   endgenerate
   
   dmux_8_way dmux_load(.in(load), .select(address),
   			.a(load_signals[0]), .b(load_signals[1]), .c(load_signals[2]), .d(load_signals[3]), 
   			.e(load_signals[4]), .f(load_signals[5]), .g(load_signals[6]), .h(load_signals[7]));
   mux_8_way_16 mux_output(.a(register_outputs[0]), .b(register_outputs[1]), .c(register_outputs[2]), .d(register_outputs[3]), 
   			.e(register_outputs[4]), .f(register_outputs[5]), .g(register_outputs[6]), .h(register_outputs[7]),
   			.select(address), .out(out));
   
endmodule
