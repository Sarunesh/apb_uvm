module top;
	logic pclk;
	logic preset_n;

	// Interface instantiation
	apb_intf pif(.pclk(pclk), .preset_n(preset_n));

	// DUT instantiation
	apb #(.ADDR_WIDTH(ADDR_WIDTH),
		.DATA_WIDTH(DATA_WIDTH))dut(.pclk		(pif.pclk),
									.preset_n	(pif.preset_n),
									.pready		(pif.pready),
									.pslverr	(pif.pslverr),
									.prdata		(pif.prdata),
									.trans_i	(pif.trans_i),
									.addr_i		(pif.addr_i),
									.wdata_i	(pif.wdata_i),
									.wr_rd_i	(pif.wr_rd_i),
									.penable	(pif.penable),
									.pselx		(pif.pselx),
									.pwrite		(pif.pwrite),
									.pwdata		(pif.pwdata),
									.paddr		(pif.paddr),
									.rdata_o	(pif.rdata_o),
									.trans_err_o(pif.trans_err_o));

	slave_memory #(.DATA_WIDTH(DATA_WIDTH),
				.ADDR_WIDTH(ADDR_WIDTH))memory(.mem_rdata	(pif.prdata),
												.mem_ready	(pif.pready),
												.mem_slverr	(pif.pslverr),
												.mem_clk	(pif.pclk),
												.mem_rst_n	(pif.preset_n),
												.mem_wr_rd	(pif.pwrite),
												.mem_valid	(pif.penable),
												.mem_selx	(pif.pselx),
												.mem_addr	(pif.paddr),
												.mem_wdata	(pif.pwdata));

	// Set interface
	initial uvm_config_db#(virtual apb_intf)::set(null,"*","VIF",pif);

	// Clock generation
	always #5 pclk=~pclk;

	initial begin
		pclk=0; preset_n=0;
		repeat(2)@(posedge pclk);
		preset_n=1;
	end

	initial run_test("base_test");
endmodule
