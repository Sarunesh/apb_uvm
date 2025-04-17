`define NEW_COMPONENT \
	function new(string name="",uvm_component parent=null); \
		super.new(name,parent); \
	endfunction

`define NEW_OBJECT \
	function new(string name=""); \
		super.new(name); \
	endfunction

parameter ADDR_WIDTH = 4;
parameter DATA_WIDTH = 4;
parameter DEPTH = 1<<ADDR_WIDTH;
parameter DATA_VALUES = DEPTH-1;

class apb_common;
	static int match_count, mismatch_count;
endclass
