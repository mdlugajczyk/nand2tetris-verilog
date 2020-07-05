`ifndef mux_4_way_16
  `include "mux_4_way_16.sv"
`endif
`define mux_8_way_16 1

module mux_8_way_16(
    input  [15:0] a,
    input  [15:0] b,
    input  [15:0] c,
    input  [15:0] d,
    input  [15:0] e,
    input  [15:0] f,
    input  [15:0] g,
    input  [15:0] h,
    input  [2:0]  select,
    output [15:0] out
);
   wire [15:0] 	  output1, output2;
   mux_4_way_16 m1(.a(a), .b(b), .c(c), .d(d), .select(select[1:0]), .out(output1));
   mux_4_way_16 m2(.a(e), .b(f), .c(g), .d(h), .select(select[1:0]), .out(output2));

   mux_16 m3(.a(output1), .b(output2), .select(select[2]), .out(out));
endmodule
