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
    ├── sim
    │   ├── Makefile
    │   └── runlist
    │ 
    └── tb
        ├── env
        │   ├── agent.sv
        │   ├── env.sv
        │   ├── monitor.sv
        │   ├── ref_model.sv
        │   ├── scoreboard.sv
        │   ├── sequencer.sv
        │   ├── sequencer.sv
        │   └── transaction.sv
        │ 
        ├── interface
        │   └── interface.sv
        │
        ├── package
        │   └── env_pkg.sv
        │ 
        ├── testcase
        │   ├── base_test.sv
        │   ├── my_case1.sv
        │   └── my_case1.sv
        │        
        └── top
            ├── tb_top.sv
            ├── rtl.f
            └── tb.f
```

## Makefile excution note
make comp 

make all TESTNAME=basetest

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


