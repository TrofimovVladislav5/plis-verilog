module test;
    reg [3:0] value;
    wire [6:0] segments;

    ssegment_display ssd(
        .value(value), 
        .segments(segments)
    );

    initial begin
        value = 4'h0;
        $display("Time | Value | Segments");
        $display("---------------------------");
        $monitor("%t |  %h   | %b", $time, value, segments);
        #10 value = 4'h1;
        #10 value = 4'h8;
        #10 value = 4'hA;
    end
endmodule