class apb_agent extends uvm_agent;
	// Factory registration
	`uvm_component_utils(apb_agent)

	// Constructor
	`NEW_COMPONENT

	// Properties
	apb_sqr sqr;
	apb_drv drv;
	apb_mon mon;
	apb_sub sub;

	// build_phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		sqr=apb_sqr::type_id::create("sqr",this);
		drv=apb_drv::type_id::create("drv",this);
		mon=apb_mon::type_id::create("mon",this);
		sub=apb_sub::type_id::create("sub",this);
		`uvm_info("APB_AGENT","Inside build_phase of apb_agent",UVM_HIGH)
	endfunction

	// connect_phase
	function void connect_phase(uvm_phase phase);
		// Connect sqr to drv
		drv.seq_item_port.connect(sqr.seq_item_export);
		// Connect mon to sub
		mon.a_port.connect(sub.analysis_export);
		`uvm_info("APB_AGENT","Inside connect_phase of apb_agent",UVM_HIGH)
	endfunction
endclass
