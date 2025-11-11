module full_adder
(
    input x,
    input y,
    input carry_in,
    output sum,
    output carry_out
);
    assign sum = x ^ y ^ carry_in;
    assign carry_out = (x & y) | (x & carry_in) | (y & carry_in);
endmodule
