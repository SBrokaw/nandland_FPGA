/* 
 * Merrick, R. (2024). The Flip-Flop (aka Register).
 * Getting Started with FPGAs.
 * https://nandland.com/project-3-the-flip-flop-aka-register/
 *
 * This project should toggle the state of an LED, only when the Switch is released.
 */

module proj3_first_register(
    input clk,
    input btn0,
    output LED0,
    output LED1,
    output LED2,
    output LED3);

    // btn0
    reg r_sync_btn0 = 1'b0; // double flop
    reg r_btn0 = 1'b0;      // syncronized button
    reg db_btn0 = 1'b0;     // debounced
    reg r_prev_btn0 = 1'b0; // previous debounced state

    reg [19:0] debounce_cnt = 0;
    reg r_LED0 = 1'b0;
    reg [23:0] counter = 0;

    always @(posedge clk) begin
        counter <= counter + 1;
        // synchronize button by double-flopping
        r_sync_btn0 <= btn0;
        r_btn0 <= r_sync_btn0;

        // debounce with timer
        if( r_btn0 != db_btn0 ) begin
            debounce_cnt <= debounce_cnt + 1;
            if( debounce_cnt >= 20'h3ffff ) begin
                db_btn0 <= r_btn0;
                debounce_cnt <= 0;
            end
        end
        else begin
            debounce_cnt <= 0;
        end

        // falling edge detection
        r_prev_btn0 <= db_btn0;
        if( !db_btn0 && r_prev_btn0 ) begin
            r_LED0 <= ~r_LED0;
        end

    end

    // output
    assign LED0 = r_LED0;

    // LED gut checks
    assign LED1 = counter[21];
    assign LED2 = counter[22];
    assign LED3 = btn0;

endmodule
