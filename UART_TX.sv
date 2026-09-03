`timescale 1ns/1ps

module UART_TX #(
    parameter integer CLK_FREQ  = 1_000_000,
    parameter integer BAUD_RATE = 10_000
)(
    input  logic       clk,
    input  logic       reset,

    input  logic [7:0] tx_data,
    input  logic       tx_start,

    output logic       tx,
    output logic       tx_busy
);

    localparam integer CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;

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
            tx        <= 1'b1;
            tx_busy   <= 1'b0;
            data_reg  <= 8'b0;
            bit_index <= 4'b0;
            clk_count <= 0;
            state     <= IDLE;
        end

        else begin

            case (state)

                IDLE: begin
                    tx      <= 1'b1;
                    tx_busy <= 1'b0;

                    if (tx_start) begin
                        data_reg  <= tx_data;
                        bit_index <= 4'd0;
                        clk_count <= 0;
                        tx_busy   <= 1'b1;
                        state     <= START_BIT;
                    end
                end

                START_BIT: begin
                    tx <= 1'b0;

                    if (clk_count == CLKS_PER_BIT - 1) begin
                        clk_count <= 0;
                        state     <= DATA_BITS;
                    end
                    else begin
                        clk_count <= clk_count + 1;
                    end
                end

                DATA_BITS: begin
                    tx <= data_reg[bit_index];

                    if (clk_count == CLKS_PER_BIT - 1) begin
                        clk_count <= 0;

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
                    tx <= 1'b1;

                    if (clk_count == CLKS_PER_BIT - 1) begin
                        clk_count <= 0;
                        tx_busy   <= 1'b0;
                        state     <= IDLE;
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
