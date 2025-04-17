class base_test extends uvm_test;
	// Factory registration
	`uvm_component_utils(base_test)

	// Constructor
	`NEW_COMPONENT

	// env instantiation
	apb_env env;

	// Properties
	int count, report_count;
	string testname;

	// build_phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env=apb_env::type_id::create("env",this);
		`uvm_info("BASE_TEST","Inside build_phase of base_test",UVM_HIGH)
	endfunction

	// end_of_elaboration_phase
	function void end_of_elaboration_phase(uvm_phase phase);
		`uvm_info("BASE_TEST","Inside end_of_elaboration_phase of base_test",UVM_HIGH)
		uvm_top.print_topology();
	endfunction

	// report_phase
	function void report_phase(uvm_phase phase);
		`uvm_info("BASE_TEST","Inside report_phase of base_test",UVM_HIGH)
		uvm_config_db#(int)::get(this,get_full_name(),"COUNT",report_count);
		if(apb_common::match_count!=report_count && apb_common::mismatch_count!=0)
			`uvm_info("TEST FAILED",$sformatf("Match_count=%0d | Mismatch_count=%0d",apb_common::match_count,apb_common::mismatch_count),UVM_NONE)
		else
			`uvm_info("TEST PASSED",$sformatf("Match_count=%0d | Mismatch_count=%0d",apb_common::match_count,apb_common::mismatch_count),UVM_NONE)
	endfunction
endclass

/*************************** Scenario-1 **************************/
class test_write_no_wait extends base_test;
	// Factory registration
	`uvm_component_utils(test_write_no_wait)

	// Constructor
	`NEW_COMPONENT

	// run_phase
	task run_phase(uvm_phase phase);
		write_no_wait wr_no_wait;
		wr_no_wait=new("wr_no_wait");
		// Set count to config_db
		uvm_config_db#(int)::set(this,"*","COUNT",1);
		phase.raise_objection(this);
		wr_no_wait.start(env.agent.sqr);
		phase.phase_done.set_drain_time(this,30);
		phase.drop_objection(this);
		`uvm_info("BASE_TEST","Inside run_phase of test_write_no_wait",UVM_HIGH)
	endtask
endclass

/*************************** Scenario-2 **************************/
class test_multi_rand_write_no_wait extends base_test;
	// Factory registration
	`uvm_component_utils(test_multi_rand_write_no_wait)

	// Constructor
	`NEW_COMPONENT

	// Properties
	string str_count;

	// run_phase
	task run_phase(uvm_phase phase);
		multi_rand_write_no_wait mr_write_no_wait;
		mr_write_no_wait=new("mr_write_no_wait");

		// Getting count value from commandline when expected testcase is triggered
		void'(uvm_cmdline_processor::get_inst().get_arg_value("+UVM_TESTNAME=", super.testname));
		if(super.testname=="test_multi_rand_write_no_wait")begin
			if(uvm_cmdline_processor::get_inst().get_arg_value("+count=", this.str_count))begin
				super.count=str_count.atoi();
				// Set count to config_db
				uvm_config_db#(int)::set(this,"*","COUNT",super.count);
				`uvm_info("BASE_TEST",$sformatf("Count=%0d", super.count),UVM_HIGH)
			end
			else
				`uvm_error("BASE_TEST","@@@@@ No count value is provided")
		end

		phase.raise_objection(this);
		mr_write_no_wait.start(env.agent.sqr);
		phase.phase_done.set_drain_time(this,30);
		phase.drop_objection(this);
		`uvm_info("BASE_TEST","Inside run_phase of test_multi_rand_write_no_wait",UVM_HIGH)
	endtask
endclass

/*************************** Scenario-3 **************************/
class test_cycle_write_no_wait extends base_test;
	// Factory registration
	`uvm_component_utils(test_cycle_write_no_wait)

	// Constructor
	`NEW_COMPONENT

	// run_phase
	task run_phase(uvm_phase phase);
		cycle_write_no_wait cy_write_no_wait;
		cy_write_no_wait=new("cy_write_no_wait");
		// Set count to config_db
		uvm_config_db#(int)::set(this,"*","COUNT",DEPTH);
		phase.raise_objection(this);
		cy_write_no_wait.start(env.agent.sqr);
		phase.phase_done.set_drain_time(this,30);
		phase.drop_objection(this);
		`uvm_info("BASE_TEST","Inside run_phase of test_cycle_write_no_wait",UVM_HIGH)
	endtask
endclass

/*************************** Scenario-4 **************************/
class test_cycle_write_read_no_wait extends base_test;
	// Factory registration
	`uvm_component_utils(test_cycle_write_read_no_wait)

	// Constructor
	`NEW_COMPONENT

	// run_phase
	task run_phase(uvm_phase phase);
		cycle_write_read_no_wait cy_write_read_no_wait;
		cy_write_read_no_wait=new("cy_write_read_no_wait");
		// Set count to config_db
		uvm_config_db#(int)::set(this,"*","COUNT",DEPTH);
		phase.raise_objection(this);
		cy_write_read_no_wait.start(env.agent.sqr);
		phase.phase_done.set_drain_time(this,30);
		phase.drop_objection(this);
		`uvm_info("BASE_TEST","Inside run_phase of test_cycle_write_read_no_wait",UVM_HIGH)
	endtask
endclass

/*************************** Scenario-5 **************************/
class test_rand_write_read_no_wait extends base_test;
	// Factory registration
	`uvm_component_utils(test_rand_write_read_no_wait)

	// Constructor
	`NEW_COMPONENT

	// Properties
	string str_count;

	// run_phase
	task run_phase(uvm_phase phase);
		rand_write_read_no_wait r_write_read_no_wait;
		r_write_read_no_wait=new("r_write_read_no_wait");

		// Getting count value from commandline when expected testcase is triggered
		void'(uvm_cmdline_processor::get_inst().get_arg_value("+UVM_TESTNAME=", super.testname));
		if(super.testname=="test_rand_write_read_no_wait")begin
			if(uvm_cmdline_processor::get_inst().get_arg_value("+count=", this.str_count))begin
				super.count=this.str_count.atoi();
				// Set count to config_db
				uvm_config_db#(int)::set(this,"*","COUNT",super.count);
				`uvm_info("BASE_TEST",$sformatf("Count=%0d", super.count),UVM_HIGH)
			end
			else
				`uvm_error("BASE_TEST","@@@@@ No count value is provided")
		end

		phase.raise_objection(this);
		r_write_read_no_wait.start(env.agent.sqr);
		phase.phase_done.set_drain_time(this,30);
		phase.drop_objection(this);
		`uvm_info("BASE_TEST","Inside run_phase of test_rand_write_read_no_wait",UVM_HIGH)
	endtask
endclass
