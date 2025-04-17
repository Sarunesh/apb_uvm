class apb_sub extends uvm_subscriber#(apb_tx);
	// Factory registration
	`uvm_component_utils(apb_sub)

	// Covergroups
	covergroup apb_br_cg;
		type_option.comment = "Between APB & Bridge";
		TRANS_CP:coverpoint tx.trans_i{
			bins TRANS_HIGH={1'b1};
			bins TRANS_LOW={1'b0};
		}
		WR_RD_CP:coverpoint tx.wr_rd_i{
			bins WR_RD_HIGH={1'b1};
			bins WR_RD_LOW={1'b0};
		}
		ADDR_CP:coverpoint tx.addr_i{
			option.auto_bin_max=ADDR_WIDTH;
		}
		WDATA_CP:coverpoint tx.wdata_i{
			//option.auto_bin_max=DATA_WIDTH;
			bins WDATA_LEGAL={[0:DATA_VALUES]};
			illegal_bins WDATA_ILLEGAL=default;
		}
		RDATA_CP:coverpoint tx.rdata_o{
			//option.auto_bin_max=DATA_WIDTH;
			bins RDATA_LEGAL={[0:DATA_VALUES]};
			illegal_bins RDATA_ILLEGAL=default;
		}
		TRANS_ERR_CP:coverpoint tx.trans_err_o{
			bins TRANS_ERR_HIGH={1'b1};
			bins TRANS_ERR_LOW={1'b0};
		}
		WR_RD_X_WDATA:cross WR_RD_CP, WDATA_CP;
		WR_RD_X_RDATA:cross WR_RD_CP, RDATA_CP;
		ADDR_X_WDATA:cross ADDR_CP, WDATA_CP;
		ADDR_X_RDATA:cross ADDR_CP, RDATA_CP;
	endgroup

	// Constructor
	function new(string name="", uvm_component parent=null);
		super.new(name, parent);
		apb_br_cg=new();
	endfunction

	// Properties
	apb_tx tx;

	// write function
	virtual function void write(apb_tx t);
		$cast(tx,t);
		apb_br_cg.sample();
	endfunction
endclass
