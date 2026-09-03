`timescale 1ns/1ps

module UART_TB;

    localparam integer CLK_FREQ  = 1_000_000;
    localparam integer BAUD_RATE = 10_000;

    localparam integer CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;


    logic clk;
    logic reset;

    logic [7:0] tx_data;
    logic       tx_start;

    logic       rx;

    logic       tx;
    logic       tx_busy;

    logic [7:0] rx_data;
    logic       rx_valid;


    UART_TOP #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE)
    ) DUT (
        .clk(clk),
        .reset(reset),

        .tx_data(tx_data),
        .tx_start(tx_start),

        .rx(rx),

        .tx(tx),
        .tx_busy(tx_busy),

        .rx_data(rx_data),
        .rx_valid(rx_valid)
    );

    initial begin
        clk = 1'b0;

        forever #5 clk = ~clk;
    end

    assign rx = tx;


    initial begin

        reset    = 1'b1;
        tx_data  = 8'h00;
        tx_start = 1'b0;


        #100;

        reset = 1'b0;


        #100;


        tx_data  = 8'h41;
        tx_start = 1'b1;

        #10;

        tx_start = 1'b0;

        wait (rx_valid == 1'b1);


        #10;


        $display("------------------------------------------");
        $display("UART LOOPBACK TEST");
        $display("------------------------------------------");
        $display("Transmitted Data = %h", tx_data);
        $display("Received Data    = %h", rx_data);
        $display("RX Valid         = %b", rx_valid);
        $display("------------------------------------------");


        if (rx_data == 8'h41) begin
            $display("TEST PASSED");
        end
        else begin
            $display("TEST FAILED");
        end


        #100;

        $finish;

    end

endmodule
