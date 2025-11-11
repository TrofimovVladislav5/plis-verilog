module d_trigger (
    input  clk,   
    input  D,     
    output reg Q, 
    output Qn   
);
    always @(posedge clk) begin
        Q <= D;
    end

    assign Qn = ~Q;
endmodule
