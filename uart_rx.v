module uart_rx #(
    parameter BAUD_RATE = 9600,
    parameter CLK_FREQ  = 50000000
)(
    input  wire clk,
    input  wire rst,
    input  wire tick,
    input  wire rx,
    output reg [7:0] rx_data,
    output reg rx_ready
);

    reg [3:0] bit_index = 0;
    reg [9:0] shift_reg = 0;
    reg busy = 0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rx_ready  <= 0;
            rx_data   <= 0;
            busy      <= 0;
            bit_index <= 0;
        end

        else begin
            rx_ready <= 0;

            if (!rx && !busy) begin
                busy <= 1;
                bit_index <= 0;
            end

            if (tick && busy) begin
                shift_reg[bit_index] <= rx;
                bit_index <= bit_index + 1;

                if (bit_index == 9) begin
                    busy <= 0;
                    rx_data <= shift_reg[8:1];
                    rx_ready <= 1;
                end
            end
        end
    end

endmodule
