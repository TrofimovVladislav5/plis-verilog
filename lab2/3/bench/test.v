`timescale 1ns/1ps

module test;
    reg clk;
    reg reset;
    reg btn;
    wire [6:0] segments;

    cyclic_buffer uut (
        .clk(clk),
        .reset(reset),
        .btn(btn),
        .segments(segments)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        reset = 1;
        btn = 0;
        #20;    
        reset = 0;
        #10 btn = 1; #10 btn = 0;
        #10 btn = 1; #10 btn = 0; 
        #10 btn = 1; #10 btn = 0; 
        #10 btn = 1; #10 btn = 0; 
        #10 btn = 1; #10 btn = 0; 
        #10 btn = 1; #10 btn = 0; 
        #10 btn = 1; #10 btn = 0; 
        #10 btn = 1; #10 btn = 0; 
        #10 btn = 1; #10 btn = 0; 
        #10 btn = 1; #10 btn = 0; 
        #10 btn = 1; #10 btn = 0; 
        #10 btn = 1; #10 btn = 0; 
        #10 btn = 1; #10 btn = 0; 
        #10 btn = 1; #10 btn = 0; 
        #10 btn = 1; #10 btn = 0; 
        #10 btn = 1; #10 btn = 0; 
        #10 btn = 1; #10 btn = 0; 
        #10 btn = 1; #10 btn = 0; 

        #100;
    end

    initial begin
        $display("Time | Buffer | Segments");
        $monitor("%0t | %d | %b", $time, uut.buffer, segments);
    end

endmodule
