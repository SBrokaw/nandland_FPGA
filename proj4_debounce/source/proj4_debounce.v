/* 
 * Merrick, R. (2024). Debounce a Switch
 * Getting Started with FPGAs.
 * https://nandland.com/project-4-debounce-a-switch/
 *
 * Debounce a button and toggle the state of an LED when the switch is released.
 */

module debounce_btn(
    input clk,
    input btn,
    output db_btn);

    parameter CLK_FREQ = 25_000_000;
    parameter DEBOUNCE_MS = 20;
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


module proj4_debounce(
    input clk,
    input btn0,
    output LED0,
    output LED1,
    output LED2,
    output LED3);

    // input registers
    wire db_btn0;
    reg prev_btn0;

    // output registers
    reg r_LED0;
    reg r_LED1;
    reg r_LED2;
    reg r_LED3;

    // debounce btn0
    debounce_btn mod0( .clk(clk), .btn(btn0), .db_btn(db_btn0));

    always @( posedge clk ) begin
        // rising edge detection
        if( !prev_btn0 & db_btn0 ) begin
            r_LED1 <= ~r_LED1;
        end

        // falling edge detection
        if( prev_btn0 & !db_btn0 ) begin
            r_LED0 <= ~r_LED0;
        end

        prev_btn0 <= db_btn0;
        r_LED3 <= db_btn0;
    end

    assign LED0 = r_LED0;
    assign LED1 = r_LED1;
    assign LED3 = r_LED3;

endmodule
