/*
 * LED breathes sinusoid pattern over 1800 ms every __time_ms__ milliseconds 
 * to __pwm__ brightness and then back off.
 */

module breathing_LED
    #(parameter time_ms = 5000, parameter max_duty = 20)
    (input clk, output breathing_LED, output [7:0] duty_cycle_monitor);
    parameter CLK_FREQ = 25_000_000;
    parameter INCREMENT_BREATH_INDEX = 100 * CLK_FREQ / 1000; // 200 ms for testing without LUT
    // parameter INCREMENT_BREATH_INDEX = 1800 / 255 * CLK_FREQ / 1000; //increment 255 steps in 1800 ms

    wire start_breath;
    wire w_pwm_LED;
    reg [22:0] counter;
    reg [7:0] breathing_index;
    wire [7:0] logduty255;
    wire [7:0] duty_cycle;

    timer_ms #(.time_ms(time_ms)) start_breath0(.clk(clk), .timer_full(start_breath));

    always @(posedge clk) begin
        // restart
        if( start_breath ) begin
            breathing_index <= 0;
            counter <= 0;
        end
        else if( counter >= INCREMENT_BREATH_INDEX ) begin
            breathing_index <= breathing_index + 1;
            counter <= 0;
        end
        else begin
            counter <= counter + 1;
        end
    end

    // pwm_LED_LUT breathing_LUT(.idx(breathing_index), .scalar(logduty255));
    assign logduty255 = breathing_index * 10; // for testing without LUT
    // assign duty_cycle = logduty255 * 100 / 255;
    assign duty_cycle = 100;
    pwm_LED pwm_breathing_LED(.clk(clk), .duty(duty_cycle), .LED(w_pwm_LED));

    /* outputs */
    assign breathing_LED = w_pwm_LED;
    wire [7:0] seven_seg_monitor;
    assign seven_seg_monitor = duty_cycle;
    assign duty_cycle_monitor = seven_seg_monitor;

endmodule

module pwm_LED (input clk, input [6:0] duty, output LED);
    parameter CLK_FREQ = 25_000_000;
    parameter PWM_FREQ = 1_000_000;
    parameter PWM_CNT = 100 * CLK_FREQ / PWM_FREQ;

    reg [9:0] LED_ON_CNT = 0;
    reg [6:0] pwm_counter = 0;
    reg r_LED;

    // toggle LED at PWM frequency with __duty__ duty cycle
    always @(posedge clk) begin
        LED_ON_CNT = duty * CLK_FREQ / PWM_FREQ;
        if( pwm_counter >= PWM_CNT ) begin
            pwm_counter <= 0;
        end
        else if( pwm_counter < LED_ON_CNT ) begin
            pwm_counter <= pwm_counter + 1;
            r_LED <= 1;
        end
        else if( pwm_counter >= LED_ON_CNT ) begin
            pwm_counter <= pwm_counter + 1;
            r_LED <= 0;
        end
    end

    assign LED = r_LED;

endmodule

/* 
 * Lookup Table (LUT) for the 0 to 255 scaled output value
 * of an LED designed to mimic human breath: a sinusoid of log() 
 * scaled values over 1800 milliseconds. 255 entries in the LUT.
 */
// module pwm_LED_LUT (input [7:0] idx, output [7:0] scalar);
//     reg [7:0] LED_LUT [0:254];
//     initial begin
//         $readmemh("breathing_LED_LUT.mem", LED_LUT);
//     end
//     assign scalar = LED_LUT[idx];
// endmodule

