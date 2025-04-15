class base_test extends uvm_test;
	// Factory registration
	`uvm_component_utils(base_test)

	// Constructor
	`NEW_COMPONENT

	// env instantiation
	apb_env env;

	// build_phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env=apb_env::type_id::create("env",this);
		`uvm_info("BASE_TEST","Inside build_phase of base_test",UVM_HIGH)
	endfunction

	// end_of_elaboration_phase
	function void end_of_elaboration_phase(uvm_phase phase);
		`uvm_info("BASE_TEST","Inside end_of_elaboration_phase of base_test",UVM_HIGH)
		uvm_top.print_topology();
	endfunction

	// report_phase
	function void report_phase(uvm_phase phase);
		`uvm_info("BASE_TEST","Inside report_phase of base_test",UVM_HIGH)
	endfunction
endclass
