class apb_sbd extends uvm_scoreboard;
	// Factory registration
	`uvm_component_utils(apb_sbd)

	// Port declaration
	uvm_analysis_imp#(apb_tx, apb_sbd) a_imp;

	// Constructor
	`NEW_COMPONENT

	// Properties
	apb_tx tx;

	// build_phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		a_imp=new("a_imp",this);
		`uvm_info("APB_SBD","Inside build_phase of apb_sbd",UVM_HIGH)
	endfunction

	// run_phase
	task run_phase(uvm_phase phase);
		`uvm_info("APB_SBD","Inside run_phase of apb_sbd",UVM_HIGH)
	endtask

	// write function
	virtual function void write(apb_tx t);
		$cast(tx,t);
	endfunction
endclass
