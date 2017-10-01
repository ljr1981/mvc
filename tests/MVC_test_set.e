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

	mvc_label_string_32_tests
			-- `mvc_label_string_32_tests'
		local
			l_aware: MVC_CONTROLLER [EV_LABEL, STRING_32, STRING_32]
			l_label: EV_LABEL
		do
				-- Workflow: Creation
			create l_label
			create l_aware.make_with_widget (l_label, agent l_label.set_text, agent l_label.text)
			l_aware.set_model_getter_agent (agent mock_object_one.mock_string_32)
			l_aware.set_model_setter_agent (agent mock_object_one.set_mock_string_32)

				-- Test: default state
			assert_32 ("empty_label_text", l_label.text.is_empty)
			assert_32 ("not_equal", not l_label.text.same_string (mock_object_one.mock_string_32))

				-- Workflow: Model to View
			l_aware.model_to_view

				-- Test: Label text
			assert_strings_equal ("has_default_text", l_label.text, mock_object_one.mock_string_32)
		end

feature {NONE} -- Mock Objects

	mock_object_one: MOCK_OBJECT_ONE
		attribute
			create Result
		end

end
