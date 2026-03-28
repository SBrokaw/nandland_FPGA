/*
 * Timer asserts after __count__ clock cycles.
 */

module clk_counter
    #(parameter count = 25_000_000 / 5600)
    (input clk,
    output timer_full);

    parameter CLK_FREQ = 25_000_000;
    parameter TIMER_CNT = count;

    reg [31:0] counter = 0;
    reg r_timer_full = 0;

    always @( posedge clk ) begin
        if( counter >= TIMER_CNT ) begin
            r_timer_full <= 1;
            counter <= 0;
        end
        else begin
            r_timer_full <= 0;
            counter <= counter + 1;
        end
    end

    assign timer_full = r_timer_full;

endmodule
