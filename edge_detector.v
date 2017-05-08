module edge_detector
    #(parameter
        N = 'd8         /* Debounce by waiting N-1 clk count */
    )
    (
        input clk, reset,
        input d,
        output reg rise_tick,
        output reg fall_tick
    );

    reg [N-1:0] d_reg, d_next;

    always@(posedge clk, posedge reset) begin
        if(reset) begin
            d_reg <= {N{d}};
        end
        else begin
            d_reg <= d_next;
        end
    end
    always@* begin
        d_next = {d_reg[N-2:0], d};
    end

    always@* begin
        rise_tick = 1'b0;
        fall_tick = 1'b0;
        if((d_reg[N-2:0] == {N-1{1'b1}}) && (d_reg[N-1]==1'b0) && d==1'b1) begin
            rise_tick = 1'b1;
        end
        if((d_reg[N-2:0] == {N-1{1'b0}}) && (d_reg[N-1]==1'b1) && d==1'b0) begin
            fall_tick = 1'b1;
        end 
    end 

endmodule
