`ifndef or_8_way
  `include "../01/or_8_way.sv"
`endif
`ifndef mux_16
  `include "../01/mux_16.sv"
`endif
`ifndef add_16
  `include "add_16.sv"
`endif
`ifndef and_16
  `include "../01/and_16.sv"
`endif
`ifndef not_16
  `include "../01/not_16.sv"
`endif
`define alu 1

module alu(
    input  [15:0] x,
    input  [15:0] y,
    input         zx,
    input         nx,
    input         zy,
    input         ny,
    input         f,
    input         no,
    output [15:0] out,
    output        zr,
    output        ng
);
   
   // setting x
   wire [15:0] 	  not_x;
   wire [15:0] 	  x_after_zx;
   wire [15:0] 	  final_x;
      

   mux_16 set_x_after_zx(.a(x), .b(16'b0), .select(zx), .out(x_after_zx));
   not_16 not_x_16(.in(x_after_zx), .out(not_x));
   mux_16 set_final_x(.a(x_after_zx), .b(not_x), .select(nx), .out(final_x));

   wire [15:0] 	  not_y;
   wire [15:0] 	  y_after_zy;
   wire [15:0] 	  final_y;
   mux_16 set_y_after_zy(.a(y), .b(16'b0), .select(zy), .out(y_after_zy));
   not_16 not_y_16(.in(y_after_zy), .out(not_y));
   mux_16 set_final_y(.a(y_after_zy), .b(not_y), .select(ny), .out(final_y));

   wire [15:0] 	  addition;
   wire [15:0] 	  logical_and;

   add_16 adder(.a(final_x), .b(final_y), .out(addition));
   and_16 ander(.a(final_x), .b(final_y), .out(logical_and));

   wire [15:0] 	  tmp_out;
   wire [15:0] 	  negated_out;
   
   mux_16 f_mux(.a(logical_and), .b(addition), .select(f), .out(tmp_out));
   not_16 not_out(.in(tmp_out), .out(negated_out));


   mux_16 out_selector(.a(tmp_out), .b(negated_out), .select(no), .out(out));


   wire 	  out_first_half_zero, out_second_half_zero;

   or_8_way first_half_zero(.in(out[15:8]), .out(out_first_half_zero));
   or_8_way second(.in(out[7:0]), .out(out_second_half_zero));

   wire 	  zr_tmp;
   
   or_n2t zr_or(.a(out_first_half_zero), .b(out_second_half_zero), .out(zr_tmp));
   not_n2t zr_not(.in(zr_tmp), .out(zr));

   assign ng = out[15];
   
   
/** The ALU. */
// Manipulates the x and y inputs as follows:
// if (zx == 1) sets x = 0 // 16-bit true constant
// if (nx == 1) sets x = !x // bitwise Not
// if (zy == 1) sets y = 0 // 16-bit true constant
// if (ny == 1) sets y = !y // bitwise Not
// if (f == 1) sets out = x + y // int. 2's-complement addition
// if (f == 0) sets out = x & y // bitwise And
// if (no == 1) sets out = !out // bitwise Not
// if (out == 0) sets zr = 1 // 1-bit true constant
// if (out < 0) sets ng = 1 // 1-bit true constant
endmodule
