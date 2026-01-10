module uart_baud #(
    parameter BAUD_RATE = 9600,
    parameter CLK_FREQ  = 50000000
)(
    input  wire clk,
    input  wire rst,
    output reg  tick
);

    localparam integer DIVIDER = CLK_FREQ / BAUD_RATE;

    integer count = 0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            tick  <= 0;
        end else begin
            if (count >= DIVIDER-1) begin
                count <= 0;
                tick  <= 1;
            end else begin
                count <= count + 1;
                tick  <= 0;
            end
        end
    end

endmodule
