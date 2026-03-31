/*
 * Universal Asynchronous Receiver/Transmitter (UART)
 * implementation on the FPGA Go Board.
 */

module UART_Rx
    #(parameter clkrate = 25_000_000,
    parameter baudrate = 115200,
    parameter data_bits = 8,
    parameter parity_bit = 1,
    parameter stop_bits = 1,
    parameter flow_ctrl = 0)
    (input clk,
    input data,
    output rx_pkt);

    parameter clk_cnt = clkrate / baudrate;

    reg [data_bits - 1: 0] rx = 0;
    reg [3:0] rx_state = 0;
    reg [11:0] counter = 0;


endmodule
