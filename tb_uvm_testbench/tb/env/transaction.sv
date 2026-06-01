`ifndef COUNTER_ITEM__SV
`define COUNTER_ITEM__SV

class my_transaction extends uvm_sequence_item;
    `uvm_object_utils(my_transaction)

    rand bit    rst_n;
    rand bit    cnt_en;    
    logic [7:0] cnt_out;
		
    function new(string name="my_transaction");
        super.new(name);
    endfunction
		
    virtual function string convert2str();
        return $sformatf("count_en %d,rst_n %d, counter_out %d", cnt_en, rst_n, cnt_out);
    endfunction

    // constraint cstr { count_en dist {0:/10, 1:/90};}
    constraint cstr_c1 {cnt_en == 1;}
    constraint cstr_c2 {rst_n == 1;}
endclass

`endif