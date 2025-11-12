module digit_view (
    input clk,
    input write_en,
    input [3:0] data,

    output o_STCP,  // shift register clock input
    output o_SHCP,  // storage register clock input
    output o_DS     // serial data output
);
    
    reg [3:0]   reg_data;
    reg [7:0]   sr_reg_data;

    shift_reg SR(.clk(clk),
                  .write_en(write_en),
                  .data(sr_reg_data), 

                  .o_STCP(o_STCP), 
                  .o_SHCP(o_SHCP),
                  .o_DS(o_DS)
             );

    always @(posedge clk) begin
        if(write_en)
        begin
            reg_data <= data;
            case (reg_data)                       
                5'd0:  begin sr_reg_data <= 8'b00010001; end
                5'd1:  begin sr_reg_data <= 8'b11010111; end
                5'd2:  begin sr_reg_data <= 8'b00110010; end
                5'd3:  begin sr_reg_data <= 8'b10010010; end
                5'd4:  begin sr_reg_data <= 8'b11010100; end
                5'd5:  begin sr_reg_data <= 8'b10011000; end
                5'd6:  begin sr_reg_data <= 8'b00011000; end
                5'd7:  begin sr_reg_data <= 8'b11010011; end
                5'd8:  begin sr_reg_data <= 8'b00010000; end
                5'd9:  begin sr_reg_data <= 8'b10010000; end
            endcase
        end
    end
    assign write_dn = o_SHCP;

endmodule