class apb_sub extends uvm_subscriber#(apb_tx);
	// Factory registration
	`uvm_component_utils(apb_sub)

	// Covergroups
	// Constructor
	function new(string name="", uvm_component parent=null);
		super.new(name, parent);
	endfunction

	// Properties
	apb_tx tx;

	// write function
	virtual function void write(apb_tx t);
		$cast(tx,t);
	endfunction
endclass
