`ifndef ram_64
    `include "ram_64.sv"
`endif
`define ram_512 1

module ram_512(
    input  [15:0] in,
    input  [8:0]  address,
    input         load,
    input         clock,
    output [15:0] out
);

   wire [7:0][15:0] outputs;
   wire [7:0] 	    loads;

   genvar j;
   generate
      for (j = 0; j < 8; j = j + 1) begin
	 ram_64 ram(.in(in), .address(address[5:0]), .load(loads[j]), .clock(clock), .out(outputs[j]));
      end
   endgenerate

   dmux_8_way dmux_load(.in(load), .select(address[8:6]),
   			.a(loads[0]), .b(loads[1]), .c(loads[2]), .d(loads[3]), 
   			.e(loads[4]), .f(loads[5]), .g(loads[6]), .h(loads[7]));
   mux_8_way_16 mux_output(.a(outputs[0]), .b(outputs[1]), .c(outputs[2]), .d(outputs[3]), 
   			   .e(outputs[4]), .f(outputs[5]), .g(outputs[6]), .h(outputs[7]),
   			   .select(address[8:6]), .out(out));
    
endmodule
