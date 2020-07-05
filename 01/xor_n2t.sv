`ifndef and_n2t
  `include "and_n2t.sv"
`endif
`define xor_n2t 1

module xor_n2t(input a, input b, output out);

   wire not_a, not_b;
   wire a1_out, a2_out;
      
   not_n2t n1(.in(a), .out(not_a));
   not_n2t n2(.in(b), .out(not_b));

   and_n2t a1(.a(a), .b(not_b), .out(a1_out));
   and_n2t a2(.a(not_a), .b(b), .out(a2_out));
   or_n2t o(.a(a1_out), .b(a2_out), .out(out));
   
endmodule
