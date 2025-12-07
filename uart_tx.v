module uart_tx #(
    parameter BAUD_RATE = 9600,
    parameter CLK_FREQ  = 50000000
)(
    input  wire clk,
    input  wire rst,
    input  wire tick,
    input  wire [7:0] tx_data,
    input  wire tx_start,
    output reg  tx,
    output reg  tx_busy
);

    reg [3:0] bit_index = 0;
    reg [9:0] frame = 10'b1111111111;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx <= 1;
            tx_busy <= 0;
            bit_index <= 0;
            frame <= 10'b1111111111;
        end
        else begin
            if (tx_start && !tx_busy) begin
                frame <= {1'b1, tx_data, 1'b0};
                bit_index <= 0;
                tx_busy <= 1;
            end

            if (tick && tx_busy) begin
                tx <= frame[bit_index];
                bit_index <= bit_index + 1;

                if (bit_index == 9) begin
                    tx_busy <= 0;
                end
            end
        end
    end

endmodule
