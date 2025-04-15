class apb_mon extends uvm_monitor;
	// Factory registration
	`uvm_component_utils(apb_mon)

	// Port declaration
	uvm_analysis_port#(apb_tx) a_port;

	// Constructor
	`NEW_COMPONENT

	// Virtual interface
	virtual apb_intf vif;

	// build_phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		a_port=new("a_port",this);
		if(!uvm_config_db#(virtual apb_intf)::get(this,get_full_name(),"VIF",vif))
			`uvm_error("APB_MON","@@@@ Failed to get the interface @@@")
		`uvm_info("APB_MON","Inside build_phase of apb_mon",UVM_HIGH)
	endfunction

	// run_phase
	task run_phase(uvm_phase phase);
		`uvm_info("APB_MON","Inside run_phase of apb_mon",UVM_HIGH)
	endtask
endclass
