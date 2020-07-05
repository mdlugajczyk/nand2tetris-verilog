`ifndef full_adder
   `include "full_adder.sv"
`endif
`define add_16 1

module add_16(
    input  [15:0] a,
    input  [15:0] b,
    output [15:0] out
);

   wire[15:0] 	  carry;
   reg 		  zero;

   full_adder a1(.a(a[0]), .b(b[0]), .c(1'b0), .carry(carry[0]), .sum(out[0]));

   genvar 	  j;
   generate
      for (j = 1; j < 16; j = j + 1) begin
	 full_adder adder(.a(a[j]), .b(b[j]), .c(carry[j-1]), .carry(carry[j]), .sum(out[j]));
      end

   endgenerate
endmodule
