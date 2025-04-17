class apb_mon extends uvm_monitor;
	// Factory registration
	`uvm_component_utils(apb_mon)

	// Port declaration
	uvm_analysis_port#(apb_tx) a_port;

	// Constructor
	`NEW_COMPONENT

	// Virtual interface
	virtual apb_intf vif;

	// Properties
	apb_tx tx;
	bit sampled;

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
		forever begin
			@(vif.mon_cb);
			if(vif.mon_cb.trans_i && vif.mon_cb.pselx && vif.mon_cb.penable && vif.mon_cb.pready && !sampled)begin
				sample_sig();
				//a_port.write(tx);
				sampled=1'b1;
			end
			else if(!vif.mon_cb.trans_i || !vif.mon_cb.penable || !vif.mon_cb.pready || sampled)
				sampled=1'b0;
		end
	endtask

	task sample_sig();
		tx=new();
		tx.trans_i	= vif.mon_cb.trans_i;
		tx.addr_i	= vif.mon_cb.addr_i;
		tx.wr_rd_i	= vif.mon_cb.wr_rd_i;
		if(vif.mon_cb.wr_rd_i) tx.wdata_i = vif.mon_cb.wdata_i;
		else tx.rdata_o	= vif.mon_cb.rdata_o;
		tx.trans_err_o	= vif.mon_cb.trans_err_o;
		a_port.write(tx);
		//tx.print();
		`uvm_info("APB_MON",tx.sprint(),UVM_MEDIUM)
	endtask
endclass
