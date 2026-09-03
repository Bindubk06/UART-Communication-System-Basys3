`timescale 1ns/1ps

module UART_RX #(
    parameter integer CLK_FREQ  = 1_000_000,
    parameter integer BAUD_RATE = 10_000
)(
    input  logic       clk,
    input  logic       reset,

    input  logic       rx,

    output logic [7:0] rx_data,
    output logic       rx_valid
);

    localparam integer CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;
    localparam integer HALF_BIT     = CLKS_PER_BIT / 2;

    logic [7:0] data_reg;
    logic [3:0] bit_index;
    integer clk_count;

    typedef enum logic [1:0] {
        IDLE,
        START_BIT,
        DATA_BITS,
        STOP_BIT
    } state_t;

    state_t state;

    always_ff @(posedge clk) begin

        if (reset) begin
            rx_data  <= 8'b0;
            rx_valid <= 1'b0;
            data_reg <= 8'b0;
            bit_index <= 4'b0;
            clk_count <= 0;
            state <= IDLE;
        end

        else begin

            rx_valid <= 1'b0;

            case (state)

                IDLE: begin
                    clk_count <= 0;

                    if (rx == 1'b0) begin
                        state <= START_BIT;
                    end
                end

                START_BIT: begin

                    if (clk_count == HALF_BIT - 1) begin
                        clk_count <= 0;

                        if (rx == 1'b0) begin
                            bit_index <= 4'd0;
                            state <= DATA_BITS;
                        end
                        else begin
                            state <= IDLE;
                        end
                    end

                    else begin
                        clk_count <= clk_count + 1;
                    end
                end

                DATA_BITS: begin

                    if (clk_count == CLKS_PER_BIT - 1) begin
                        clk_count <= 0;

                        data_reg[bit_index] <= rx;

                        if (bit_index == 4'd7) begin
                            state <= STOP_BIT;
                        end
                        else begin
                            bit_index <= bit_index + 1;
                        end
                    end

                    else begin
                        clk_count <= clk_count + 1;
                    end
                end

                STOP_BIT: begin

                    if (clk_count == CLKS_PER_BIT - 1) begin
                        clk_count <= 0;

                        if (rx == 1'b1) begin
                            rx_data  <= data_reg;
                            rx_valid <= 1'b1;
                        end

                        state <= IDLE;
                    end

                    else begin
                        clk_count <= clk_count + 1;
                    end
                end

                default: begin
                    state <= IDLE;
                end

            endcase
        end
    end

endmodule
