/*
 * Merrick, R. (2024). UART Receiver.
 * Getting Started with FPGAs.
 * https://nandland.com/project-7-uart-part-1-receive-data-from-computer/ 
 *
 * Universal Asynchronous Receiver/Transmitter (UART)
 * implementation on the FPGA Go Board.
 */

module proj7_UART_Rx
    (input clk,
    input raw_data,
    input raw_reset_btn,
    output [6:0] seven_seg0,
    output [6:0] seven_seg1,
    output breathing_LED,
    output activity_LED);

    /* breathing LED indicator */
    wire ding_activity;
    wire w_breathing_LED;
    wire [7:0] duty_cycle_monitor;
    wire [3:0] duty0;
    wire [3:0] duty1;
    breathing_LED #(.time_ms(5000), .max_duty(20)) breathe0(
        .clk(clk), .breathing_LED(w_breathing_LED), .duty_cycle_monitor(duty_cycle_monitor));
    timer_ms #(.time_ms(200)) activity_timer(.clk(clk), .timer_full(ding_activity));
    reg r_activity_LED;

    // seven seg monitors for LED duty cycle
    assign duty0 = duty_cycle_monitor[3:0];
    assign duty1 = duty_cycle_monitor[7:4];
    seven_seg seg0(.num(duty0), .segments(seven_seg0));
    seven_seg seg1(.num(duty1), .segments(seven_seg1));

    /* dummy check blinking LED */
    always @(posedge clk) begin
        if(ding_activity) r_activity_LED <= ~r_activity_LED;
    end

    /* outputs */
    assign breathing_LED = w_breathing_LED;
    assign activity_LED = r_activity_LED;

endmodule
