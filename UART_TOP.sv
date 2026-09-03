`timescale 1ns/1ps

module UART_TOP #(
    parameter integer CLK_FREQ  = 1_000_000,
    parameter integer BAUD_RATE = 10_000
)(
    input  logic       clk,
    input  logic       reset,

    input  logic [7:0] tx_data,
    input  logic       tx_start,

    input  logic       rx,

    output logic       tx,
    output logic       tx_busy,

    output logic [7:0] rx_data,
    output logic       rx_valid
);

    UART_TX #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE)
    ) UART_TX_UNIT (
        .clk(clk),
        .reset(reset),
        .tx_data(tx_data),
        .tx_start(tx_start),
        .tx(tx),
        .tx_busy(tx_busy)
    );

    UART_RX #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE)
    ) UART_RX_UNIT (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .rx_data(rx_data),
        .rx_valid(rx_valid)
    );

endmodule
