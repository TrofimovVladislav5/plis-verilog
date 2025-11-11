module d_trigger (
    input  clk, 
    input rst,  
    input  D,     
    output reg Q, 
    output Qn   
);
    always @(posedge clk or negedge rst) begin
        if (!rst) 
            Q <= 1'b0;
        else 
            Q <= D;
    end

    assign Qn = ~Q;
endmodule
