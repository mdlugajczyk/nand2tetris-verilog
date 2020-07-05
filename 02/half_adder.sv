`ifndef xor_n2t
  `include "../01/xor_n2t.sv"
`endif
`define half_adder 1

module half_adder(
    input  a,
    input  b,
    output carry,
    output sum
);

   xor_n2t sum_gate(.a(a), .b(b), .out(sum));
   and_n2t carry_gate(.a(a), .b(b), .out(carry));

endmodule
