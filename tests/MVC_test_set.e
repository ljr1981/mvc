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
			l_aware: MVC_AWARE [EV_WIDGET, ANY, ANY]
			l_container: MVC_CONTAINER [EV_CONTAINER, ANY, ANY]
			l_prim: MVC_PRIMITIVE [EV_PRIMITIVE, ANY, ANY]
		do
			do_nothing -- yet ...
		end

end
