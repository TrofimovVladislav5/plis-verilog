module half_sum
(
    input x,
    input y,
    output sum,
    output carry_out
);
    assign sum = x ^ y;
    assign carry_out = x & y;
endmodule
