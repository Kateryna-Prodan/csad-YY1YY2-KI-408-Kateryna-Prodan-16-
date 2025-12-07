`timescale 1ns/1ps

module uart_tb;

    parameter CLK_FREQ  = 50000000;
    parameter BAUD_RATE = 9600;

    reg clk = 0;
    reg rst = 1;
    reg tx_start = 0;
    reg [7:0] tx_data = 0;
    wire tx;
    wire tx_busy;

    wire [7:0] rx_data;
    wire rx_ready;

    // Clock generation
    always #10 clk = ~clk;  // 50 MHz

    // Baud generator
    wire tick;
    uart_baud #(.BAUD_RATE(BAUD_RATE), .CLK_FREQ(CLK_FREQ)) baud_inst (
        .clk(clk),
        .rst(rst),
        .tick(tick)
    );

    // Transmitter
    uart_tx #(.BAUD_RATE(BAUD_RATE), .CLK_FREQ(CLK_FREQ)) tx_inst (
        .clk(clk),
        .rst(rst),
        .tick(tick),
        .tx_data(tx_data),
        .tx_start(tx_start),
        .tx(tx),
        .tx_busy(tx_busy)
    );

    // Receiver
    uart_rx #(.BAUD_RATE(BAUD_RATE), .CLK_FREQ(CLK_FREQ)) rx_inst (
        .clk(clk),
        .rst(rst),
        .tick(tick),
        .rx(tx),
        .rx_data(rx_data),
        .rx_ready(rx_ready)
    );

    // Test sequence
    initial begin
        $display("UART Simulation Start");

        #100 rst = 0;

        #500;
        tx_data = 8'hA5;
        tx_start = 1;
        #20 tx_start = 0;

        wait(rx_ready);
        $display("Received byte = %h", rx_data);

        #2000;
        $stop;
    end

endmodule
