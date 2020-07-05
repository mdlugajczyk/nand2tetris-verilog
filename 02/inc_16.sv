`ifndef half_adder
  `include "half_adder.sv"
`endif
`define inc_16 1

module inc_16(input [15:0] in, output [15:0] out);

   wire[15:0] carry;

   half_adder ha(.a(in[0]), .b(1'b1), .carry(carry[0]), .sum(out[0]));
   
   genvar     j;
   generate
      for (j = 1; j < 16; j = j + 1) begin
	 half_adder ha(.a(in[j]), .b(carry[j-1]), .carry(carry[j]), .sum(out[j]));
      end
   endgenerate

endmodule
