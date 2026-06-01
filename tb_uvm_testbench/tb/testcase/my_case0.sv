`ifndef MY_CASE0__SV
`define MY_CASE0__SV

class my_case0 extends base_test;
    `uvm_component_utils(my_case0)
		
		function new(string name = "my_case0", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    extern virtual task main_phase (uvm_phase phase);
endclass

task my_case0::main_phase(uvm_phase phase);
  my_sequence seq;
		
	super.main_phase(phase);
		
	phase.raise_objection(this);
  seq = my_sequence::type_id::create("seq");
  
	if (!seq.randomize())
		`uvm_fatal(get_type_name(), "sequence randomize failed")	

	seq.start(env.agt.sqr);
	#1000;
	phase.drop_objection(this);		
endtask

`endif 
