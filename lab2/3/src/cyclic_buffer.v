module cyclic_buffer(
    input wire clk,
    input wire reset,
    input wire btn,
    output wire [6:0] segments
);

    reg [3:0] buffer;
    reg btn_previous;

    wire btn_pressed = btn & (~btn_previous);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            btn_previous <= 0;
            buffer <= 0;
        end else begin
            btn_previous <= btn;
            if (btn_pressed)
                buffer <= (buffer == 4'b1111) ? 0 : buffer + 1;            
        end
    end

    ssegment_display show(
        .value(buffer),
        .segments(segments)
    );
endmodule