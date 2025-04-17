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
		forever begin
			seq_item_port.get_next_item(req);
			//$display("########### Before driving %0t", $time);
			drive(req);
			seq_item_port.item_done();
		end
	endtask

	// drive task
	task drive(apb_tx tx);
		`uvm_info("APB_DRV","Inside drive task of apb_drv",UVM_HIGH)
		@(vif.drv_cb);
		vif.drv_cb.trans_i	<= tx.trans_i;
		vif.drv_cb.wr_rd_i	<= tx.wr_rd_i;
		vif.drv_cb.addr_i	<= tx.addr_i;
		vif.drv_cb.wdata_i	<= tx.wdata_i;
		@(vif.drv_cb);
		wait(vif.drv_cb.pselx && vif.drv_cb.penable && vif.drv_cb.pready);	// Access Phase
		tx.trans_err_o	= vif.drv_cb.trans_err_o;
		tx.rdata_o		= vif.drv_cb.rdata_o;
		//tx.print();
		`uvm_info("APB_DRV",tx.sprint(),UVM_MEDIUM)
		@(vif.drv_cb);
		vif.drv_cb.trans_i	<= 0;
		vif.drv_cb.wr_rd_i	<= 0;
		vif.drv_cb.addr_i	<= 0;
		vif.drv_cb.wdata_i	<= 0;
	endtask
endclass
