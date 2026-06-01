`ifndef MY_AGENT__SV
`define MY_AGENT__SV

class my_agent extends uvm_agent;
    `uvm_component_utils(my_agent)

    function new(string name="my_agent", uvm_component parent);
        super.new(name, parent);
    endfunction

    uvm_sequencer #(my_transaction) sqr;
    my_driver    drv;
    my_monitor   mon;

    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
endclass

function void my_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);

    sqr = uvm_sequencer #(my_transaction)::type_id::create("sqr", this);
    drv = my_driver::type_id::create("drv", this);
    mon = my_monitor::type_id::create("mon", this);

endfunction

function void my_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    drv.seq_item_port.connect(sqr.seq_item_export);

endfunction

`endif