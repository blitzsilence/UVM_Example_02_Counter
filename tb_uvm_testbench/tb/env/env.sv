`ifndef COUNTER_ENV__SV
`define COUNTER_ENV__SV

class my_env extends uvm_env;
    `uvm_component_utils(my_env)
    
    my_agent        agt;
    my_scoreboard   scb;		
		
    function new(string name = "my_env", uvm_component parent);
        super.new(name, parent);
    endfunction

		extern virtual function void build_phase (uvm_phase phase);
    extern virtual function void connect_phase (uvm_phase phase);
endclass

function void my_env::build_phase (uvm_phase phase);
		super.build_phase(phase);
		
		agt = my_agent::type_id::create("agt", this);
		scb = my_scoreboard::type_id::create("scb", this);
endfunction

function void my_env::connect_phase (uvm_phase phase);
    super.connect_phase(phase);

    agt.mon.ap.connect(scb.imp);
endfunction


`endif