`ifndef COUNTER_SCOREBOARD__SV
`define COUNTER_SCOREBOARD__SV

class my_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(my_scoreboard)

    bit[7:0] exp_cout = 8'b0;

    uvm_analysis_imp #(my_transaction, my_scoreboard) imp;

    function new(string name="my_scoreboard", uvm_component parent);
        super.new(name, parent);
    endfunction
		
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        imp = new("imp", this);
    endfunction

    virtual function write(my_transaction item);
        
        if(item.cnt_out != exp_cout)begin
            `uvm_error("SCB", $sformatf("ERROR! cnt_out: %0d, exp_out: %0d", item.cnt_out, exp_cout))
        end
        else begin
            `uvm_info("SCB", $sformatf("PASS! cnt_out: %0d, exp_out: %0d", item.cnt_out, exp_cout), UVM_LOW)
        end

        if(item.cnt_en == 0) begin
            exp_cout = 8'b0;
        end
        else begin
            if(exp_cout != 10) begin
                exp_cout ++;
            end
            else begin
                exp_cout = 0;
            end
        end
    endfunction
endclass

`endif
