class apb_tx extends uvm_sequence_item;
	// Properties
	rand bit trans_i;							// By tb to dut
	rand bit [ADDR_WIDTH-1:0] addr_i;			// By tb to dut
	rand bit [DATA_WIDTH-1:0] wdata_i;			// By tb to dut
	rand bit wr_rd_i;							// By tb to dut
		 bit [DATA_WIDTH-1:0] rdata_o;			// To tb
		 bit trans_err_o;						// To tb	

	// Factory registration
	`uvm_object_utils_begin(apb_tx)
		`uvm_field_int(trans_i,UVM_ALL_ON)
		`uvm_field_int(addr_i,UVM_ALL_ON)
		`uvm_field_int(wdata_i,UVM_ALL_ON)
		`uvm_field_int(wr_rd_i,UVM_ALL_ON)
		`uvm_field_int(rdata_o,UVM_ALL_ON)
		`uvm_field_int(trans_err_o,UVM_ALL_ON)
	`uvm_object_utils_end

	// Constructor
	`NEW_OBJECT
endclass
