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

	mvc_label_textable_tests
			-- `mvc_label_string_32_model_to_view_tests'
		local
			l_label: EV_LABEL
			l_text_field: EV_TEXT_FIELD
			l_list_item: EV_LIST_ITEM
			l_check_menu_item: EV_CHECK_MENU_ITEM
			l_menu: EV_MENU
			l_menu_separator: EV_MENU_SEPARATOR
			l_radio_menu_item: EV_RADIO_MENU_ITEM
			-- l_notebook_tab: EV_NOTEBOOK_TAB
			l_button: EV_BUTTON
			l_radio_button: EV_RADIO_BUTTON
			l_frame: EV_FRAME
			l_combo_box: EV_COMBO_BOX
		do
			create l_combo_box
			test_textable (l_combo_box)
			create l_frame
			test_textable (l_frame)
			create l_radio_button
			test_textable (l_radio_button)
			create l_button
			test_textable (l_button)
			create l_radio_menu_item
			test_textable (l_radio_menu_item)
			create l_menu_separator
			test_textable (l_menu_separator)
			create l_menu
			test_textable (l_menu)
			create l_label
			test_textable (l_label)
			create l_text_field
			test_textable (l_text_field)
			create l_list_item
			test_textable (l_list_item)
			create l_check_menu_item
			test_textable (l_check_menu_item)
		end

feature {NONE} -- Test Helpers

	test_textable (a_widget: EV_TEXTABLE)
		local
			l_aware: MVC_TEXTABLE
		do
				-- Workflow: Creation
			create l_aware.make_with_widget (a_widget, agent a_widget.set_text, agent a_widget.text)
			l_aware.set_model_getter_agent (agent mock_object_one.mock_string_32)
			l_aware.set_model_setter_agent (agent mock_object_one.set_mock_string_32)

				-- Test: default state
			assert_32 ("empty_label_text", a_widget.text.is_empty)
			assert_32 ("not_equal", not a_widget.text.same_string (mock_object_one.mock_string_32))

				-- Workflow: Model to View
			l_aware.model_to_view

				-- Test: Label text
			assert_strings_equal ("has_default_text", a_widget.text, mock_object_one.mock_string_32)

				-- Workflow: Creation
			a_widget.set_text ("view_label_text")
			l_aware.set_model_setter_agent (agent mock_object_one.set_mock_string_32 (?))

				-- Test: label text to move to model
			assert_strings_equal ("view_label_text", "view_label_text", a_widget.text)

				-- Workflow: View to Model
			l_aware.view_to_model

				-- Test: Model has string
			assert_strings_equal ("model_has_string", "view_label_text", mock_object_one.mock_string_32)
		end

feature {NONE} -- Mock Objects

	mock_object_one: MOCK_OBJECT_ONE
		attribute
			create Result
		end

end
