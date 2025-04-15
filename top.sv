module top;
	logic pclk;
	logic preset_n;

	// Interface instantiation
	apb_intf pif(.pclk(pclk), .preset_n(preset_n));

	// DUT instantiation

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
