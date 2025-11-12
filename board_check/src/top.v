module top (
    input clk,

    // SHR #1 control signals
    output o_STCP_SR1,
    output o_SHCP_SR1,
    output o_DS_SR1,

    // SHR #2 control signals
    output o_STCP_SR2,
    output o_SHCP_SR2,
    output o_DS_SR2,

    // SHR #2 control signals
    output o_STCP_SR3,
    output o_SHCP_SR3,
    output o_DS_SR3,

    // SHR of digit indicator #1
    output o_STCP_DV1,
    output o_SHCP_DV1,
    output o_DS_DV1,

    // SHR of digit indicator #2
    output o_STCP_DV2,
    output o_SHCP_DV2,
    output o_DS_DV2,

    // USER led output pin
    output o_LED1
);

    reg [7:0] data1;
    reg [3:0] data2;
    reg [7:0] data3;
    reg [0:0] write_en;       // write enable signal

    reg [24:0] clk_div2Hz_r;  // clock divider
    reg [0:0]  clk_2Hz_r;     // 2Hz signal reg
    wire       clk_2Hz;

    reg [1:0]  data_idx;      // data index
    reg [3:0]  data_dv;

    reg [0:0] rst;

    // init signals 
    initial begin
        clk_div2Hz_r <= 24'h0;
        clk_2Hz_r    <= 1'b0;
        
        rst         <= 1'b0;
        write_en    <= 1'b0;

        data1        <= 8'h00;
        data3        <= 8'h00;
    end

    // call shift register module
    shift_reg SR1(.clk(clk),
                  .rst(rst),
                  .write_en(write_en),
                  .data(data1), 

                  .o_STCP(o_STCP_SR1), 
                  .o_SHCP(o_SHCP_SR1),
                  .o_DS(o_DS_SR1)
                 );

    shift_reg SR2(.clk(clk),
                  .rst(rst),
                  .write_en(write_en),
                  .data(data1), 

                  .o_STCP(o_STCP_SR2), 
                  .o_SHCP(o_SHCP_SR2),
                  .o_DS(o_DS_SR2)
                 );

    shift_reg SR3(.clk(clk),
                  .rst(rst),
                  .write_en(write_en),
                  .data(data1), 

                  .o_STCP(o_STCP_SR3), 
                  .o_SHCP(o_SHCP_SR3),
                  .o_DS(o_DS_SR3)
                 );

    // call digit view module
    digit_view DV1(.clk(clk),
                  .write_en(write_en),
                  .data(data2), 

                  .o_STCP(o_STCP_DV1), 
                  .o_SHCP(o_SHCP_DV1),
                  .o_DS(o_DS_DV1));

    digit_view DV2(.clk(clk),
                  .write_en(write_en),
                  .data(data2), 

                  .o_STCP(o_STCP_DV2), 
                  .o_SHCP(o_SHCP_DV2),
                  .o_DS(o_DS_DV2));


    // put data to shift register
    always @(posedge clk)
    begin
        if(clk_div2Hz_r < 24'hCDFE60)
        begin
            clk_div2Hz_r = clk_div2Hz_r + 24'h1;
        end

        if(clk_div2Hz_r == 24'hCDFE60)
        begin
            case(data_idx)
                2'd0: begin data1 <= 8'h00; end
                2'd1: begin data1 <= 8'h55; end
                2'd2: begin data1 <= 8'hAA; end
                2'd3: begin data1 <= 8'hFF; end
            endcase

            write_en     <= 1'b1;
            data_idx     <= data_idx + 2'b1;

            clk_2Hz_r    <= ~clk_2Hz_r;            
            clk_div2Hz_r <= 24'h0;
        end
    end
    assign o_LED1  = clk_2Hz_r[0];

    always @(posedge clk_2Hz_r)
    begin
        if(data_dv > 4'd9)
            data_dv = 4'd0;
        else
            data_dv = data_dv + 1;

        data2 <= data_dv;
    end

endmodule
