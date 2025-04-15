class apb_drv extends uvm_driver#(apb_tx);
	// Factory registration
	`uvm_component_utils(apb_drv)

	// Constructor
	`NEW_COMPONENT

	// Virtual interface
	virtual apb_intf vif;

	// build_phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual apb_intf)::get(this,get_full_name(),"VIF",vif))
			`uvm_error("APB_DRV","@@@@ Failed to get the interface @@@")
		`uvm_info("APB_DRV","Inside build_phase of apb_drv",UVM_HIGH)
	endfunction

	// run_phase
	task run_phase(uvm_phase phase);
		`uvm_info("APB_DRV","Inside run_phase of apb_drv",UVM_HIGH)
	endtask

	// drive task
	task drive(apb_tx tx);
		`uvm_info("APB_DRV","Inside drive task of apb_drv",UVM_HIGH)
	endtask
endclass
