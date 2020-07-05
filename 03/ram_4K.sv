`ifndef ram_512_optimized
    `include "ram_512_optimized.sv"
`endif
`ifndef mux_8_way_16
    `include "../01/mux_8_way_16.sv"
`endif
`ifndef dmux_8_way
    `include "../01/dmux_8_way.sv"
`endif
`define ram_4K

module ram_4K(
    input  [15:0] in,
    input  [11:0]  address,
    input         load,
    input         clock,
    output [15:0] out
);

   wire [7:0][15:0] outputs;
   wire [7:0] 	    loads;

   genvar j;
   generate
      for (j = 0; j < 8; j = j + 1) begin
	 ram_512_optimized ram(.in(in), .address(address[8:0]), .load(loads[j]), .clock(clock), .out(outputs[j]));
      end
   endgenerate

   dmux_8_way dmux_load(.in(load), .select(address[11:9]),
   			.a(loads[0]), .b(loads[1]), .c(loads[2]), .d(loads[3]), 
   			.e(loads[4]), .f(loads[5]), .g(loads[6]), .h(loads[7]));
   mux_8_way_16 mux_output(.a(outputs[0]), .b(outputs[1]), .c(outputs[2]), .d(outputs[3]), 
   			   .e(outputs[4]), .f(outputs[5]), .g(outputs[6]), .h(outputs[7]),
   			   .select(address[11:9]), .out(out));
        
endmodule
