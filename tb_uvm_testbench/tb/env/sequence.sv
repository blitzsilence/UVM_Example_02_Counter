`ifndef COUNTER_SEQUENCE__SV
`define COUNTER_SEQUENCE__SV

class my_sequence extends uvm_sequence;
    `uvm_object_utils(my_sequence)

    rand int num;

    constraint cstr_c1 {
        soft num inside {[5:20]};
    }
		
    function new(string name = "my_sequence");
        super.new(name);
    endfunction

    virtual task body();
        my_transaction req;

        repeat(num) begin
            req = my_transaction::type_id::create("req");

            
						if (!req.randomize())
							`uvm_fatal("SEQ", "Randomize Failed")	
start_item(req);			
            `uvm_info("SEQ", $sformatf("generate new item %s", req.convert2str()), UVM_HIGH);
            finish_item(req);
        end
        
    endtask


endclass

`endif
