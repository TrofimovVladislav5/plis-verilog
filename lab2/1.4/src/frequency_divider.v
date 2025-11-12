module frequency_divider #(
    parameter N = 4
) (
    input wire clk,
    input wire reset,
    output wire out_clk
);

    localparam LENGTH = $clog2(N);
    reg [LENGTH - 1:0] counter;

    always @(posedge clk) begin
        if (reset) begin
            counter <= 0;
        end else if (counter == N  - 1) begin
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end

    assign out_clk = counter[LENGTH - 1];
endmodule