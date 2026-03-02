/* 
 * Merrick, R. (2024). The Flip-Flop (aka Register).
 * Getting Started with FPGAs.
 * https://nandland.com/project-3-the-flip-flop-aka-register/
 */

module proj3_first_register(
    input clk,
    input btn0,
    output LED0,
    output LED1);

    reg r_LED0 = 1'b0;
    reg r_btn0 = 1'b0;
    reg r_sync_btn0 = 1'b0;
    reg r_prev_btn0 = 1'b0;
    reg [19:0] debounce_cnt = 0;
    reg db_btn0 = 1'b0;

    always @(posedge clk) begin
        // synchronize button by double-flopping
        r_sync_btn0 <= btn0;
        r_btn0 <= r_sync_btn0;

        // debounce with timer
        if( r_btn0 == db_btn0 ) begin
            debounce_cnt <= 0;
        end
        else if( debounce_cnt == 20'hfffff ) begin
            db_btn0 <= r_btn0;

            // falling edge detection
            if( !r_btn0 && r_prev_btn0 ) begin
                r_LED0 <= !r_LED0;
            end
        end
        else begin
            debounce_cnt <= debounce_cnt + 1;
        end

        // update prev. state
        r_prev_btn0 <= db_btn0;

    end

    assign LED0 = r_LED0;
    assign LED1 = btn0;

endmodule
