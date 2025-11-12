module shift_reg(
    input clk,          // common CLK signal 27MHz
    input rst,
    input write_en,
    input [7:0] data,

    output write_dn,    // write data done

    output reg o_STCP,  // shift register clock input
    output reg o_SHCP,  // storage register clock input
    output reg o_DS     // serial data output
);

    reg [0:0] write_dn_r;
    reg [7:0] reg_data; // buffered data register
    reg [5:0] counter;  // push data step count

    initial begin
        counter    <= 5'd0;
        write_dn_r <= 1'b1;
    end

    
    always @(posedge clk) begin
        if (counter < 5'd17)       
            counter <= counter + 1'b1;
        else
            counter <= 5'd0;
    end

    always @(posedge clk) begin
        if(write_en)
        begin
            case (counter)
                5'd1:  begin o_SHCP <= 'b0; o_DS <= reg_data[7]; o_STCP <=  'b0; end
                5'd2:  begin o_STCP <= 'b1; end
                5'd3:  begin o_DS   <= reg_data[6]; o_STCP <=  'b0;  end
                5'd4:  begin o_STCP <= 'b1; end
                5'd5:  begin o_DS   <= reg_data[5]; o_STCP <=  'b0;  end
                5'd6:  begin o_STCP <= 'b1; end
                5'd7:  begin o_DS   <= reg_data[4]; o_STCP <=  'b0;  end
                5'd8:  begin o_STCP <= 'b1; end
                5'd9:  begin o_DS   <= reg_data[3]; o_STCP <=  'b0;  end
                5'd10: begin o_STCP <= 'b1; end
                5'd11: begin o_DS   <= reg_data[2]; o_STCP <=  'b0;  end
                5'd12: begin o_STCP <= 'b1; end
                5'd13: begin o_DS   <= reg_data[1]; o_STCP <=  'b0;  end
                5'd14: begin o_STCP <= 'b1; end
                5'd15: begin o_DS   <= reg_data[0]; o_STCP <=  'b0;  end
                5'd16: begin o_STCP <= 'b1; end
                5'd17: begin o_SHCP <= 'b1; reg_data <= data; end
            endcase
        end
    end
    assign write_dn = o_SHCP;

endmodule
