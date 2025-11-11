`timescale 1ns/1ps

module test();
    reg x;
    reg y;
    reg carry_in;
    wire sum;
    wire carry_out;
    // uut - unit under test
    full_adder uut(
        .x(x),
        .y(y),
        .carry_in(carry_in),
        .sum(sum),
        .carry_out(carry_out)
    );

    initial begin
        $display("=== Test Full-Adder ===");
        $display("| x | y | carry_in | sum | carry_out |");
        $monitor(" %b    %b       %b      %b       %b     ", x, y, carry_in, sum, carry_out);
        x = 0; y = 0; carry_in = 0;#5;
        x = 0; y = 1; carry_in = 0;#5;
        x = 1; y = 0; carry_in = 0;#5;
        x = 1; y = 1; carry_in = 0;#5;
        x = 0; y = 0; carry_in = 1;#5;
        x = 0; y = 1; carry_in = 1;#5;
        x = 1; y = 0; carry_in = 1;#5;
        x = 1; y = 1; carry_in = 1;#5;
    end
endmodule
