# UVM_Example_Counter

## Intro

UVM testbench environment practice for a simple counter DUT


## Verification Environment
```
    Project_root
    │
    ├── README.md
    │
    ├── doc
    │   └── xxxx
    │
    ├── rtl
    │   └── dut.sv
    │
    ├── tb_direct_test
    │   ├── Makefile
    │   └── tb_counter.sv
    │ 
    └── tb_uvm_testbench
        ├── sim
        │   └── Makefile
        │ 
        └── tb
            ├── env
            │   ├── agent.sv
            │   ├── driver.sv        
            │   ├── env.sv
            │   ├── monitor.sv
            │   ├── scoreboard.sv
            │   ├── sequence.sv
            │   └── transaction.sv
            │ 
            ├── interface
            │   └── interface.sv
            │ 
            ├── testcase
            │   ├── base_test.sv
            │   ├── my_case0.sv
            │   └── my_case1.sv
            │        
            └── top
                ├── rtl.f
                ├── tb.f
                └── tb_top.sv
```

## Makefile excution note
make comp 

make sim TESTNAME=basetest

make sim TESTNAME=my_case0

make sim TESTNAME=my_case1


## UVM testbench topology
```
------------------------------------------------------------------
Name                       Type                        Size  Value
--------------------------------------------------------------
uvm_test_top               base_test               -     @460 
  env                      my_env                  -     @468 
    agt                    my_agent                -     @483 
      drv                  my_driver               -     @626 
        rsp_port           uvm_analysis_port       -     @643 
        seq_item_port      uvm_seq_item_pull_port  -     @634 
      mon                  my_monitor              -     @652 
        mon_analysis_port  uvm_analysis_port       -     @662 
      sqr                  uvm_sequencer           -     @503 
        rsp_export         uvm_analysis_export     -     @511 
        seq_item_export    uvm_seq_item_pull_imp   -     @617 
        arbitration_queue  array                   0     -    
        lock_queue         array                   0     -    
        num_last_reqs      integral                32    'd1  
        num_last_rsps      integral                32    'd1  
    scb                    my_scoreboard           -     @491 
      imp                  uvm_analysis_imp        -     @671 
--------------------------------------------------------------
```


