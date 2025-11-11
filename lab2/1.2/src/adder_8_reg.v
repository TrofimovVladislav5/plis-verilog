module adder_8_reg(
    input [7:0] x,
    input [7:0] y,
    input carry_in,
    output [7:0] sum,
    output carry_out
);
    wire[7:0] carry;
    full_adder bit0(.x(x[0]), .y(y[0]), .carry_in(carry_in), .sum(sum[0]), .carry_out(carry[0]));
    full_adder bit1(.x(x[1]), .y(y[1]), .carry_in(carry[0]), .sum(sum[1]), .carry_out(carry[1]));
    full_adder bit2(.x(x[2]), .y(y[2]), .carry_in(carry[1]), .sum(sum[2]), .carry_out(carry[2]));
    full_adder bit3(.x(x[3]), .y(y[3]), .carry_in(carry[2]), .sum(sum[3]), .carry_out(carry[3]));
    full_adder bit4(.x(x[4]), .y(y[4]), .carry_in(carry[3]), .sum(sum[4]), .carry_out(carry[4]));
    full_adder bit5(.x(x[5]), .y(y[5]), .carry_in(carry[4]), .sum(sum[5]), .carry_out(carry[5]));
    full_adder bit6(.x(x[6]), .y(y[6]), .carry_in(carry[5]), .sum(sum[6]), .carry_out(carry[6]));
    full_adder bit7(.x(x[7]), .y(y[7]), .carry_in(carry[6]), .sum(sum[7]), .carry_out(carry[7]));

    assign carry_out = carry[7];
endmodule