/*
 * LED breathes sinusoid pattern over 1800 ms every __time_ms__ milliseconds 
 * to __pwm__ brightness and then back off.
 */

module breathing_LED
    #(parameter time_ms = 5000, parameter max_duty = 20)
    (input clk, output breathing_LED);

    wire start_breath;
    wire w_pwm_LED;
    reg [19:0] counter = 0;
    reg [7:0] breathing_index = 0;
    wire [3:0] duty_cycle;
    assign duty_cycle = breathing_index % 10;

    timer_ms #(.time_ms(5000)) start_breath0(.clk(clk), .timer_full(start_breath));

    always @(posedge clk) begin
        // restart
        if( start_breath ) begin
            breathing_index <= breathing_index + 1;
        end
    end

    pwm_LED pwm_breathing_LED(.clk(clk), .duty(duty_cycle), .LED(w_pwm_LED));
    assign breathing_LED = w_pwm_LED;

endmodule

module pwm_LED (input clk, input duty, output LED);
    parameter CLK_FREQ = 25_000_000;
    parameter PWM_FREQ = 1_000_000;
    parameter PWM_CNT = 100 * CLK_FREQ / PWM_FREQ;

    reg [9:0] LED_ON_CNT = 0;
    reg [4:0] pwm_clk_counter = 0;
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
module pwm_LED_LUT #(parameter idx = 0) (output scalar);
    reg [7:0] LED_LUT = [0,3,5,8,11,14,16,19,22,25,28,31,34,37,41,44,47,50,54,57,61,64,67,71,74,78,82,85,89,93,96,100,104,107,111,115,119,122,126,130,134,138,141,145,149,153,156,160,164,167,171,174,178,181,185,188,192,195,198,201,204,207,210,213,216,219,222,224,227,229,231,234,236,238,240,241,243,245,246,248,249,250,251,252,253,253,254,254,255,255,255,255,255,254,254,253,253,252,251,250,249,248,246,245,243,241,240,238,236,234,231,229,227,224,222,219,216,213,210,207,204,201,198,195,192,188,185,181,178,174,171,167,164,160,156,153,149,145,141,138,134,130,126,122,119,115,111,107,104,100,96,93,89,85,82,78,74,71,67,64,61,57,54,50,47,44,41,37,34,31,28,25,22,19,16,14,11,8,5,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    assign scalar = LED_LUT[idx];
endmodule
*/

