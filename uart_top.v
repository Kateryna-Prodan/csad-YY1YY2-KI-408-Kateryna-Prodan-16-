module uart_top (
    input  wire clk,        // 50 MHz
    input  wire rst,        // reset
    input  wire start_tx,   // запуск передачі
    input  wire [7:0] data_in,
    input  wire rx,         // UART RX
    output wire tx,         // UART TX
    output wire [7:0] data_out,
    output wire rx_ready
);

    // -----------------------------------------------------
    // Tick (baud rate generator)
    // -----------------------------------------------------
    wire tick;

    uart_baud #(
        .BAUD_RATE(9600),
        .CLK_FREQ (50000000)
    ) BAUD_GEN (
        .clk (clk),
        .rst (rst),
        .tick(tick)
    );

    // -----------------------------------------------------
    // UART TX
    // -----------------------------------------------------
    wire tx_busy;

    uart_tx #(
        .BAUD_RATE(9600),
        .CLK_FREQ (50000000)
    ) TX_INST (
        .clk      (clk),
        .rst      (rst),
        .tick     (tick),
        .tx_data  (data_in),
        .tx_start (start_tx),
        .tx       (tx),
        .tx_busy  (tx_busy)
    );

    // -----------------------------------------------------
    // UART RX
    // -----------------------------------------------------

    uart_rx #(
        .BAUD_RATE(9600),
        .CLK_FREQ (50000000)
    ) RX_INST (
        .clk     (clk),
        .rst     (rst),
        .tick    (tick),
        .rx      (rx),
        .rx_data (data_out),
        .rx_ready(rx_ready)
    );

endmodule
