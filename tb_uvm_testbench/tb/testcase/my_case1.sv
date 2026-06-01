`ifndef MY_CASE1__SV
`define MY_CASE1__SV

class random_ctrl_sequence extends my_sequence;
	`uvm_object_utils(random_ctrl_sequence)

	function new (string name = "random_ctrl_sequence");
		super.new(name);
	endfunction

	virtual task body();
		my_transaction req;

		repeat(num) begin
			req = my_transaction::type_id::create("req");
			start_item(req);

			if (!req.randomize() with {
				rst_n dist {
					0 := 10,
					1 := 90
				};

				cnt_en dist {
					0 := 30,
					1 := 70
				};
			})
				`uvm_fatal("SEQ", "Randomize Failed")
			finish_item(req);
		end
	endtask
endclass

class my_case1 extends base_test;
	`uvm_component_utils(my_case1)
	
	function new (string name = "my_case1", uvm_component parent = null);
		super.new(name, parent);
	endfunction
	
	extern virtual task run_phase (uvm_phase phase);
endclass

task my_case1::run_phase (uvm_phase phase);
	random_ctrl_sequence seq;
	
	phase.raise_objection(this);
	seq = random_ctrl_sequence::type_id::create("seq");
	
  if (!seq.randomize())
			`uvm_fatal(get_type_name(), "sequence randomize failed")				

	seq.start(env.agt.sqr);
	phase.drop_objection(this);
endtask

`endif