`ifndef mux_16
  `include "mux_16.sv"
 `endif
`define mux_4_way_16 1

module mux_4_way_16(
    input  [15:0] a,
    input  [15:0] b,
    input  [15:0] c,
    input  [15:0] d,
    input  [1:0]  select,
    output [15:0] out
);
   wire [15:0] 	  output1, output2;
   mux_16 m1(.a(a), .b(b), .select(select[0]), .out(output1));
   mux_16 m2(.a(c), .b(d), .select(select[0]), .out(output2));

   mux_16 m3(.a(output1), .b(output2), .select(select[1]), .out(out));
endmodule
