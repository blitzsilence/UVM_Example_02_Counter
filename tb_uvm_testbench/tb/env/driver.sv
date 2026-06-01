`ifndef COUNTER_DRIVER__SV
`define COUNTER_DRIVER__SV

class my_driver extends uvm_driver #(my_transaction);
    `uvm_component_utils(my_driver)

    virtual my_interface vif;
		
    function new(string name="my_driver", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db #(virtual my_interface)::get(this, "", "vif", vif))
            `uvm_fatal("DRV", "could not get vif")
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);

        forever begin
            my_transaction item;
            `uvm_info("DRV", $sformatf("wait for item from sequencer"), UVM_HIGH)
            seq_item_port.get_next_item(item);
            drive_item(item);
            seq_item_port.item_done();
        end
    endtask

    virtual task drive_item(my_transaction item);
        @(vif.clk);
        vif.cnt_en <= item.cnt_en;
        vif.rst_n <= item.rst_n;
    endtask
endclass

`endif