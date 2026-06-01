`include "uvm_macros.svh"
import uvm_pkg::*;

`include "transaction.sv"
`include "sequence.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "env.sv"

`include "interface.sv"
`include "base_test.sv"
`include "my_case0.sv"
`include "my_case1.sv"

module tb_top;

	logic clk;
	parameter simulation_cycle = 100;	

	my_interface intf(clk);

	counter cnt(
			.clk        (clk), 
			.rst_n      (intf.rst_n),
			.cnt_en     (intf.cnt_en),
			.cnt_out    (intf.cnt_out)
	);
	
	// CLOCK generation
	initial begin
			clk = 0;
			forever
					#(simulation_cycle) clk = ~clk;
	end

	// Configuration
	initial begin
		// Format for time display
		$timeformat(-9, 2, "ns", 10);
		
		// Interface configuration from tb_top (HW) to verification env (SW)
		uvm_config_db #(virtual my_interface)::set(null, "", "vif", intf);
		run_test();
	end
	
	// Dump fsdb
	`ifdef FSDB
		initial begin
			$display("DUMP FSDB START!");
			$fsdbDumpfile("tb_top.fsdb");
			$fsdbDumpvars(0, "tb_top");
		end
	`endif

endmodule

