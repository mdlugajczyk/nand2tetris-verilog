`ifndef ram_4K
    `include "ram_4K.sv"
`endif
`ifndef dmux_4_way
    `include "../01/dmux_4_way.sv"
`endif
`ifndef mux_4_way_16
    `include "../01/mux_4_way_16.sv"
`endif
`define ram_16K 1

module ram_16K(
    input  [15:0] in,
    input  [13:0] address,
    input         load,
    input         clock,
    output [15:0] out
);

   wire [3:0][15:0] outputs;
   wire [3:0] 	    loads;

   genvar j;
   generate
      for (j = 0; j < 4; j = j + 1) begin
	 ram_4K ram(.in(in), .address(address[11:0]), .load(loads[j]), .clock(clock), .out(outputs[j]));
      end
   endgenerate

   dmux_4_way dmux_load(.in(load), .sel(address[13:12]),
   			.a(loads[0]), .b(loads[1]), .c(loads[2]), .d(loads[3]));
   mux_4_way_16 mux_output(.a(outputs[0]), .b(outputs[1]), .c(outputs[2]), .d(outputs[3]), 
   			   .select(address[13:12]), .out(out));
endmodule
