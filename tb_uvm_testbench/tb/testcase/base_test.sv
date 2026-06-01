`ifndef BASE_TEST__SV
`define BASE_TEST__SV

class base_test extends uvm_test;
    `uvm_component_utils(base_test)

    my_env      env;

    virtual my_interface vif;   
		
    function new(string name = "base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
 
    extern virtual function void build_phase (uvm_phase phase);
    extern virtual function void end_of_elaboration_phase( uvm_phase phase);
		extern virtual task main_phase (uvm_phase phase);
endclass

function void base_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = my_env::type_id::create("env", this);

    if (!uvm_config_db #(virtual my_interface)::get(this, "", "vif", vif)) begin
        `uvm_fatal("BASETEST", "Not get vif")
    end

    uvm_config_db #(virtual my_interface)::set(this, "env.agt.*", "vif", vif);
endfunction

function void base_test::end_of_elaboration_phase (uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
endfunction

task base_test::main_phase(uvm_phase phase);
endtask

`endif
