`timescale 1ns/1ps

module test();
    reg [7:0]x;
    reg [7:0]y;
    reg carry_in;
    wire [7:0] sum;
    wire carry_out;

    adder_8_reg uut(
        .x(x),
        .y(y),
        .carry_in(carry_in),
        .sum(sum),
        .carry_out(carry_out)
    );

    initial begin
        $display("|   x   |   y   | carry_in |  sum  | carry_out |");
        $display("--------------------------------------");
        $monitor("| %3d  | %3d  |  %b  | %3d  |  %b  |", x, y, carry_in, sum, carry_out);
        // Case 1: 0 + 0
        x = 8'd0; y = 8'd0; carry_in = 0; #5;
        // Case 2: 255 + 0
        x = 8'd255; y = 8'd0; carry_in = 0; #5;
        // Case 3:  255 + 1
        x = 8'd255; y = 8'd1; carry_in = 0; #5;
        // Case 4: 85 + 170
        x = 8'd85; y = 8'd170; carry_in = 0; #5;
    end
endmodule