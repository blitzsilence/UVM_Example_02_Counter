`ifndef MY_INTERFACE__SV
`define MY_INTERFACE__SV

interface my_interface(input clk);
    logic       rst_n;
    logic       cnt_en;
    logic [7:0] cnt_out;
endinterface

`endif