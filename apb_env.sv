class apb_env extends uvm_env;
	// Factory registration
	`uvm_component_utils(apb_env)

	// Constructor
	`NEW_COMPONENT

	// Properties
	apb_agent agent;
	apb_sbd sbd;

	// build_phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agent=apb_agent::type_id::create("agent",this);
		sbd=apb_sbd::type_id::create("sbd",this);
		`uvm_info("APB_ENV","Inside build_phase of apb_env",UVM_HIGH)
	endfunction

	// connect_phase
	function void connect_phase(uvm_phase phase);
		// connect monitor to sbd
		agent.mon.a_port.connect(sbd.a_imp);
		`uvm_info("APB_ENV","Inside connect_phase of apb_env",UVM_HIGH)
	endfunction
endclass
