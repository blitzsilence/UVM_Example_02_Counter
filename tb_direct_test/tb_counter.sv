module tb_counter();

	logic clk;
	logic rst_n;
	logic cnt_en;
	logic [7:0] cnt_out;

	counter	u_dut(
		.clk			(clk),
		.rst_n		(rst_n),
		.cnt_en		(cnt_en),
		.cnt_out	(cnt_out)
	);
	
	localparam logic [7:0] MAX_CNT = 8'd10;
	
	// CLOCK generation
	parameter simulation_cycle = 10;
	
	initial begin
		clk = 0;
		forever
			#(simulation_cycle) clk = ~clk;
	end
	

	// reference model
	logic [7:0] expected_cnt;

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			expected_cnt <= '0;
		end
		else if (cnt_en) begin
			if (expected_cnt == MAX_CNT)
				expected_cnt <= '0;
			else
				expected_cnt <= expected_cnt + 1'b1;
		end
	end

	// checker
	always @(posedge clk) begin
		#1step;
		
		if (cnt_out !== expected_cnt) begin
				$error("CHECK FAILED: expected=%0d actual=%0d", expected_cnt, cnt_out);
		end
		else begin
				$display("CHECK PASS");
		end
	end

	// stimulus
	initial begin
		// init
		rst_n  = 0;
		cnt_en = 0;

		// reset
		repeat (3) @(posedge clk);;
		rst_n = 1;

		// case1: normal count
		$display("\n========== CASE1 : NORMAL COUNT ==========");

		cnt_en = 1;
		repeat (15) @(posedge clk);

		// case2: disable counter
		$display("\n========== CASE2 : DISABLE COUNT ==========");

		cnt_en = 0;
		repeat (5) @(posedge clk);

		// case3: enable again
		$display("\n========== CASE3 : ENABLE AGAIN ==========");

		cnt_en = 1;
		repeat (8) @(posedge clk);

		// case4: reset during counting
		$display("\n========== CASE4 : RESET DURING COUNT ==========");

		@(posedge clk);
		rst_n = 0;
		repeat (2) @(posedge clk);
		rst_n = 1;
		repeat (5) @(posedge clk);

		// case5: rollover
		$display("\n========== CASE5 : ROLLOVER TEST ==========");

		cnt_en = 1;
		repeat (20) @(posedge clk);

		// case6: random enable toggle
		$display("\n========== CASE6 : RANDOM ENABLE ==========");

		repeat (30) begin
				@(posedge clk);
				cnt_en = $urandom_range(0,1);
		end

		// finish
		repeat (10) @(posedge clk);
		$display("\n========== TEST DONE ==========");
		$finish;

	end
  
	// DUMP FSDB
  initial begin
    $fsdbDumpfile("tb_counter.fsdb");
    $fsdbDumpvars(0, "tb_counter");
  end
	
endmodule

