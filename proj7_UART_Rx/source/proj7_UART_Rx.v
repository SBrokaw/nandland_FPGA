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

    // breathing LED indicator
    reg r_breathing_LED;
    wire breathe;
    timer_ms #(.time_ms(5000)) breath_timer(.clk(clk), .timer_full(breathe));
    always @( posedge clk ) begin
        if( breathe ) r_breathing_LED <= ~r_breathing_LED;
    end

    // UART
    reg [7:0] packet = 0;
    UART_Rx #(.clkrate(CLKRATE), .baudrate(115200), .data_bits(8), 
              .parity_bit(True), .stop_bits(1))
        UART_Rx0(.clk(clk), .data(data), .rx_pkt(packet));

endmodule
