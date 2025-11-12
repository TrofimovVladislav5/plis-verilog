`timescale 1ns/1ps

module test;

    parameter COEFFICIENT_DIV = 8;
    parameter CLK_PERIOD = 10;

    reg clk;
    reg reset;
    wire out_clk;

    frequency_divider #(.N(COEFFICIENT_DIV)) uut (
        .clk(clk),
        .reset(reset),
        .out_clk(out_clk)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;

        $display("---------------------------");
        $display("Test divider on N=%0d", COEFFICIENT_DIV);
        $display("---------------------------");
        $display("Time | Reset | CLK | OUT_CLK");
        $display("----------------------------");

        #CLK_PERIOD;
        reset = 0;
        $display("%t |  %b  |  %b  |    %b", $time, reset, clk, out_clk);
        
        #400;
        
        $display("----------------------------");
    end

    always @(posedge clk) begin
        $display("%t |  %b  |  %b  |    %b", $time, reset, clk, out_clk);
    end
endmodule