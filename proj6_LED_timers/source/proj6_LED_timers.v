/* 
 * Merrick, R. (2024). LED Timers.
 * Getting Started with FPGAs.
 * https://nandland.com/project-6-how-to-simulate-your-fpga-designs/
 *
 * Make the LEDs on the Go Board blink at different 
 * rates.
 */

 module proj6_LED_timers(
    input clk,
    input raw_btn0,
    input raw_btn1,
    output LED0,
    output LED1,
    output LED2,
    output LED3,
    output [6:0] segments0,
    output [6:0] segments1);

    // debounce buttons
    wire btn0;
    wire btn1;
    reg prev_btn0;
    reg prev_btn1;
    debounce_btn db0( .clk(clk), .btn(raw_btn0), .db_btn(btn0));
    debounce_btn db1( .clk(clk), .btn(raw_btn1), .db_btn(btn1));

    // initiate timers
    wire ding_500ms;
    wire ding_1000ms;
    wire ding_2000ms;
    timer #(.time_ms(200)) timer_500ms( .clk(clk), .timer_full(ding_500ms));
    timer #(.time_ms(1000)) timer_1000ms( .clk(clk), .timer_full(ding_1000ms));
    timer #(.time_ms(2000)) timer_2000ms( .clk(clk), .timer_full(ding_2000ms));
    reg r_LED0;
    reg r_LED1;
    reg r_LED2;
    reg [3:0] num = 4'h0;

    /*
     * MAIN clk loop
     */
    always @(posedge clk) begin
        // rising edge detection
        if( !prev_btn0 & btn0 ) begin
            num <= num + 1;
            if( num > 4'hf ) num <= 4'h0;
        end
        prev_btn0 <= btn0;

        // timers control LEDs
        if( ding_500ms ) r_LED2 <= ~r_LED2;
        if( ding_1000ms ) r_LED0 <= ~r_LED0;
        if( ding_2000ms ) r_LED1 <= ~r_LED1;
    end

    // outputs
    seven_seg ss0( .num(num), .segments(segments0));
    seven_seg ss1( .num(num % 2), .segments(segments1));
    assign LED0 = r_LED0;
    assign LED1 = r_LED1;
    assign LED2 = r_LED2;

 endmodule
