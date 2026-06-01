`ifndef COUNTER_MONITOR__SV
`define COUNTER_MONITOR__SV

class my_monitor extends uvm_monitor;
    `uvm_component_utils(my_monitor)

    uvm_analysis_port #(my_transaction) ap;
    virtual my_interface vif;
		
    function new(string name="my_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        if(!uvm_config_db#(virtual my_interface)::get(this, "", "vif", vif))
            `uvm_fatal("MON", "Could not get vif")

        ap = new("mon_analysis_port", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);

        forever begin
            @(posedge vif.clk);
            if(vif.cnt_en)begin
                my_transaction item;
								item = my_transaction::type_id::create("item");
                item.cnt_en = vif.cnt_en;
                item.cnt_out = vif.cnt_out;

                ap.write(item);
            end
        end
    endtask
    
endclass

`endif