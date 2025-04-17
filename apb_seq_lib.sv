class apb_seq_lib extends uvm_sequence#(apb_tx);
	// Factory registration
	`uvm_object_utils(apb_seq_lib)

	// Constructor
	`NEW_OBJECT

	// Method
	extern task write_gen(input int addr=-1);

	// Properties
	int count;
	int i;
endclass

/*************************** Scenario-1 **************************/
class write_no_wait extends apb_seq_lib;
	// Factory registration
	`uvm_object_utils(write_no_wait)

	// Constructor
	`NEW_OBJECT

	// run_phase
	task body();
		//$display("########## Before write_gen %0t", $time);
		write_gen(-1);
		`uvm_info("APB_SEQ_LIB","Inside body task of write_no_wait",UVM_HIGH)
	endtask
endclass

/*************************** Scenario-2 **************************/
class multi_rand_write_no_wait extends apb_seq_lib;
	// Factory registration
	`uvm_object_utils(multi_rand_write_no_wait)

	// Constructor
	`NEW_OBJECT

	// run_phase
	task body();
		`uvm_info("APB_SEQ_LIB","Inside body task of multi_rand_write_no_wait",UVM_HIGH)

		// Reading count from config_db
		if(!uvm_config_db#(int)::get(null,get_full_name(),"COUNT",super.count))
			`uvm_error("APB_SEQ_LIB","Failed to get count from config_db")

		repeat(super.count)begin
			write_gen(-1);
		end
	endtask
endclass

/*************************** Scenario-3 **************************/
class cycle_write_no_wait extends apb_seq_lib;
	// Factory registration
	`uvm_object_utils(cycle_write_no_wait)

	// Constructor
	`NEW_OBJECT

	// run_phase
	task body();
		`uvm_info("APB_SEQ_LIB","Inside body task of cycle_write_no_wait",UVM_HIGH)
		for(i=0;i<DEPTH;i++)
			write_gen(i);
	endtask
endclass

/*************************** Scenario-4 **************************/
class cycle_write_read_no_wait extends apb_seq_lib;
	// Factory registration
	`uvm_object_utils(cycle_write_read_no_wait)

	// Constructor
	`NEW_OBJECT

	// run_phase
	task body();
		`uvm_info("APB_SEQ_LIB","Inside body task of cycle_write_read_no_wait",UVM_HIGH)
		// Write
		for(i=0;i<DEPTH;i++)begin
			write_gen(i);
		end
		// Read
		for(i=0;i<DEPTH;i++)begin
			`uvm_do_with(req,{req.trans_i==1;req.wr_rd_i==0;req.addr_i==i;req.wdata_i==0;})
		end
	endtask
endclass

/*************************** Scenario-5 **************************/
class rand_write_read_no_wait extends apb_seq_lib;
	// Factory registration
	`uvm_object_utils(rand_write_read_no_wait)

	// Constructor
	`NEW_OBJECT

	// Properties
	apb_tx tx;
	bit [ADDR_WIDTH-1:0] addrq[$];

	// run_phase
	task body();
		`uvm_info("APB_SEQ_LIB","Inside body task of rand_write_read_no_wait",UVM_HIGH)

		// Reading count from config_db
		if(!uvm_config_db#(int)::get(null,get_full_name(),"COUNT",count))
			`uvm_error("APB_SEQ_LIB","Failed to get count from config_db")

		// Write
		repeat(count)begin
			`uvm_do_with(req,{req.trans_i==1;req.wr_rd_i==1;})
			//tx=new req;
			addrq.push_back(req.addr_i);
			//$display("######################### WRITE req.addr_i=%0h", req.addr_i);
			//addrq.push_back(tx.addr_i);
			`uvm_info("APB_SEQ_LIB",req.sprint(),UVM_HIGH)
		end
		// Read
		repeat(count)begin
			`uvm_do_with(req,{req.trans_i==1;req.wr_rd_i==0;req.addr_i==addrq.pop_front();req.wdata_i==0;})
			//$display("######################### READ req.addr_i=%0h", req.addr_i);
			void'(addrq.pop_front());
			`uvm_info("APB_SEQ_LIB",req.sprint(),UVM_HIGH)
		end
	endtask
endclass

/*************************** Extern task **************************/
task apb_seq_lib::write_gen(input int addr=-1);
	$display("########## Inside write_gen of seq %0t", $time);
	if(addr==-1)begin
		// Randomized address
		`uvm_do_with(req,{req.trans_i==1;req.wr_rd_i==1;})
	end
	else begin
		// Cycle address
		`uvm_do_with(req,{req.trans_i==1;req.wr_rd_i==1;req.addr_i==addr;})
	end
	//req.print();
	//$display("########## Before printing in seq %0t", $time);
	`uvm_info("APB_SEQ_LIB",req.sprint(),UVM_HIGH)
endtask
