/*
 * LED breathes sinusoid pattern over 1800 ms every __time_ms__ milliseconds 
 * to __pwm__ brightness and then back off.
 */

module breathing_LED
    #(parameter time_ms = 5000, parameter pwm = 20)
    (input clk, output breathing_LED);

    reg r_breathing_LED;
    wire start_breath;
    timer_ms #(.time_ms(5000)) start_breath0(.clk(clk), .timer_full(start_breath));
    always @(posedge start_breath) begin
        r_breathing_LED <= ~r_breathing_LED;
        // pwm_LED #(.pwm(pwm)) pwm_breathing_LED(.clk(clk), .LED(breathing_LED));
    end

    assign breathing_LED = r_breathing_LED;

endmodule
