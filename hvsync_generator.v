module hvsync_generator(
    input clk,        // 25MHz clock for 640x480 VGA
    output hsync, vsync,
    output reg [9:0] hpos, vpos
);

    // Horizontal timings
    parameter H_RES = 640;  // Active pixels
    parameter H_FP = 16;    // Front porch
    parameter H_SYNC = 96;  // Sync pulse
    parameter H_BP = 48;    // Back porch
    parameter H_MAX = H_RES + H_FP + H_SYNC + H_BP;

    // Vertical timings
    parameter V_RES = 480;
    parameter V_FP = 10;
    parameter V_SYNC = 2;
    parameter V_BP = 33;
    parameter V_MAX = V_RES + V_FP + V_SYNC + V_BP;

    always @(posedge clk) begin
        if (hpos == H_MAX - 1) begin
            hpos <= 0;
            if (vpos == V_MAX - 1) vpos <= 0;
            else vpos <= vpos + 1;
        end else begin
            hpos <= hpos + 1;
        end
    end

    assign hsync = (hpos >= (H_RES + H_FP) && hpos < (H_RES + H_FP + H_SYNC)) ? 0 : 1;
    assign vsync = (vpos >= (V_RES + V_FP) && vpos < (V_RES + V_FP + V_SYNC)) ? 0 : 1;

endmodule
