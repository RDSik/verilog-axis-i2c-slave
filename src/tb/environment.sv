`ifndef ENV_SV
`define ENV_SV

class environment;

    localparam CLK_PER = 2;

    local virtual axis_i2c_top_if dut_if;

    function new(virtual axis_i2c_top_if dut_if);
        this.dut_if = dut_if;
    endfunction

    task init();
        begin
            reset();
        end
    endtask

    task reset();
        begin
            dut_if.arst = 1;
            $display("Reset at %g ns.", $time);
            #CLK_PER;
            dut_if.arst = 0;
        end
    endtask

    

endclass

`endif