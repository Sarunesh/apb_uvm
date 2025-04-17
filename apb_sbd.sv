class apb_sbd extends uvm_scoreboard;
	// Factory registration
	`uvm_component_utils(apb_sbd)

	// Port declaration
	uvm_analysis_imp#(apb_tx, apb_sbd) a_imp;

	// Constructor
	`NEW_COMPONENT

	// Properties
	apb_tx tx;
	logic [DATA_WIDTH-1:0] mem [DEPTH-1:0];
	int sbd_start;

	// build_phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		a_imp=new("a_imp",this);
		`uvm_info("APB_SBD","Inside build_phase of apb_sbd",UVM_HIGH)
	endfunction

	// run_phase
	task run_phase(uvm_phase phase);
		`uvm_info("APB_SBD","Inside run_phase of apb_sbd",UVM_HIGH)
		forever begin
			wait(sbd_start==1);
			if(tx.trans_i)begin
				if(tx.wr_rd_i) mem[tx.addr_i] = tx.wdata_i;
				else begin
					if(tx.rdata_o == mem[tx.addr_i]) apb_common::match_count++;
					else apb_common::mismatch_count++;
				end
				`uvm_info("APB_SBD",tx.sprint(),UVM_MEDIUM)
				sbd_start=0;
			end
		end
	endtask

	// write function
	virtual function void write(apb_tx t);
		$cast(tx,t);
		sbd_start=1;
	endfunction
endclass
