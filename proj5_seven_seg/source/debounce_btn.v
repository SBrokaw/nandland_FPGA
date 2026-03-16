/*
 * Debounce a Button
 */

module debounce_btn(
    input clk,
    input btn,
    output db_btn);

    parameter DEBOUNCE_MS = 20;
    parameter CLK_FREQ = 25_000_000;
    parameter DEBOUNCE_CNT = DEBOUNCE_MS * CLK_FREQ / 1000;

    reg [19:0] counter;
    reg r_sync_btn;
    reg r_btn;
    reg r_db_btn = 0;

    always @( posedge clk ) begin
        // synchronize btn
        r_sync_btn <= btn;
        r_btn <= r_sync_btn; 

        // debounce with timer
        if( r_btn != r_db_btn ) begin
            counter <= counter + 1;
            if( counter >= DEBOUNCE_CNT ) begin
                r_db_btn <= r_btn;
                counter <= 0;
            end
        end
        else begin
            counter <= 0;
        end
    end

    assign db_btn = r_db_btn;

endmodule
