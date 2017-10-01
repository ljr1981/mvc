note
	description: "Tests of {MVC}."
	testing: "type/manual"

class
	MVC_TEST_SET

inherit
	EQA_TEST_SET
		rename
			assert as assert_old
		end

	EQA_COMMONLY_USED_ASSERTIONS
		undefine
			default_create
		end

	TEST_SET_BRIDGE
		undefine
			default_create
		end

feature -- Test routines

	MVC_tests
			-- `MVC_tests'
		local
			l_aware: MVC_CONTROLLER [EV_PRIMITIVE, ANY, ANY]
		do
			create l_aware.default_create
			create l_aware.make_with_widget (create {EV_LABEL}.make_with_text ("blah"))
		end

end
