`ifndef half_adder
  `include "half_adder.sv"
`endif
`define full_adder 1

module full_adder(
    input  a,
    input  b,
    input  c,
    output carry,
    output sum
);

   wire    h1_carry, h2_carry;
   wire    sum1;
         
   half_adder h1(.a(a), .b(b), .carry(h1_carry), .sum(sum1));
   half_adder h2(.a(sum1), .b(c), .carry(h2_carry), .sum(sum));

   assign carry = h1_carry | h2_carry;

endmodule


// c a b   s c
// 0 0 0   0 0
// 0 0 1   1 0
// 0 1 0   1 0
// 0 1 1   0 1
// 1 0 0   1 0
// 1 0 1   0 1
// 1 1 0   0 1
// 1 1 1   1 1
