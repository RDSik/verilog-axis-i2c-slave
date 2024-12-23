`timescale 1ns/1ps

`include "environment.sv"

module axis_i2c_top_tb ();

    localparam CLK_PER = 2;

    axis_if axis();
    axis_i2c_top_if dut_if();
    environment env;

    axis_i2c_top dut (
        .clk     (dut_if.clk    ),
        .arstn   (dut_if.arstn  ),
        .i2c_sda (dut_if.i2c_sda),
        .i2c_scl (dut_if.i2c_scl),
        .s_axis  (axis          )
    );

    axis_data_gen data_gen (
        .clk     (dut_if.clk  ),
        .arstn   (dut_if.arstn),
        .m_axis  (axis        )
    );

    always #(CLK_PER/2) dut_if.clk = ~dut_if.clk;

    initial begin
        fork
            env = new(dut_if);
            env.init();
        join
        $stop;
    end

    initial begin
        $dumpfile("axis_i2c_top_tb.vcd");
        $dumpvars(0, axis_i2c_top_tb);
        $monitor("time=%g, i2c_sda=%b, i2c_slc=%b, ", $time, dut_if.i2c_sda, dut_if.i2c_scl);
    end

endmodule
