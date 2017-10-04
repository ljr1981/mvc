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

	mvc_basic_textable_tests
			-- `mvc_textable_tests'
		local
			l_button: EV_BUTTON
			l_check_menu_item: EV_CHECK_MENU_ITEM
			l_combo_box: EV_COMBO_BOX
			l_frame: EV_FRAME
			l_label: EV_LABEL
			l_list_item: EV_LIST_ITEM
			l_menu: EV_MENU
			l_menu_separator: EV_MENU_SEPARATOR
			l_radio_button: EV_RADIO_BUTTON
			l_radio_menu_item: EV_RADIO_MENU_ITEM
			l_rich_text: EV_RICH_TEXT
			l_text: EV_TEXT
			l_text_field: EV_TEXT_FIELD
			l_tool_bar_button: EV_TOOL_BAR_BUTTON
			l_tool_bar_radio_button: EV_TOOL_BAR_RADIO_BUTTON
			l_tree_item: EV_TREE_ITEM
				-- Notebook related
			l_notebook: EV_NOTEBOOK
			l_notebook_tab: EV_NOTEBOOK_TAB
			l_box: EV_VERTICAL_BOX
		do
				-- Notebook related
			create l_box
			create l_notebook
			l_notebook.extend (l_box)
			l_notebook_tab := l_notebook.item_tab (l_box)
			test_textable (l_notebook_tab)

				-- All others
			create l_button
			create l_check_menu_item
			create l_combo_box
			create l_frame
			create l_label
			create l_list_item
			create l_menu
			create l_menu_separator
			create l_radio_button
			create l_radio_menu_item
			create l_rich_text
			create l_text
			create l_text_field
			create l_tool_bar_button
			create l_tool_bar_radio_button
			create l_tree_item

			test_textable (l_button)
			test_textable (l_check_menu_item)
			test_textable (l_combo_box)
			test_textable (l_frame)
			test_textable (l_label)
			test_textable (l_list_item)
			test_textable (l_menu)
			test_textable (l_menu_separator)
			test_textable (l_radio_button)
			test_textable (l_radio_menu_item)
			test_textable (l_rich_text)
			test_textable (l_text)
			test_textable (l_text_field)
			test_textable (l_tool_bar_button)
			test_textable (l_tool_bar_radio_button)
			test_textable (l_tree_item)
		end

	mvc_string_date_tests
		local
			l_button: EV_BUTTON
			l_check_menu_item: EV_CHECK_MENU_ITEM
			l_combo_box: EV_COMBO_BOX
			l_frame: EV_FRAME
			l_label: EV_LABEL
			l_list_item: EV_LIST_ITEM
			l_menu: EV_MENU
			l_menu_separator: EV_MENU_SEPARATOR
			l_radio_button: EV_RADIO_BUTTON
			l_radio_menu_item: EV_RADIO_MENU_ITEM
			l_rich_text: EV_RICH_TEXT
			l_text: EV_TEXT
			l_text_field: EV_TEXT_FIELD
			l_tool_bar_button: EV_TOOL_BAR_BUTTON
			l_tool_bar_radio_button: EV_TOOL_BAR_RADIO_BUTTON
			l_tree_item: EV_TREE_ITEM
				-- Notebook related
			l_notebook: EV_NOTEBOOK
			l_notebook_tab: EV_NOTEBOOK_TAB
			l_box: EV_VERTICAL_BOX
		do
				-- Notebook related
			create l_box
			create l_notebook
			l_notebook.extend (l_box)
			l_notebook_tab := l_notebook.item_tab (l_box)
			test_date_textables (l_notebook_tab)

				-- All others
			create l_button
			create l_check_menu_item
			create l_combo_box
			create l_frame
			create l_label
			create l_list_item
			create l_menu
			create l_menu_separator
			create l_radio_button
			create l_radio_menu_item
			create l_rich_text
			create l_text
			create l_text_field
			create l_tool_bar_button
			create l_tool_bar_radio_button
			create l_tree_item

			test_date_textables (l_button)
			test_date_textables (l_check_menu_item)
			test_date_textables (l_combo_box)
			test_date_textables (l_frame)
			test_date_textables (l_label)
			test_date_textables (l_list_item)
			test_date_textables (l_menu)
			test_date_textables (l_menu_separator)
			test_date_textables (l_radio_button)
			test_date_textables (l_radio_menu_item)
			test_date_textables (l_rich_text)
			test_date_textables (l_text)
			test_date_textables (l_text_field)
			test_date_textables (l_tool_bar_button)
			test_date_textables (l_tool_bar_radio_button)
			test_date_textables (l_tree_item)
		end

	mvc_string_time_tests
		local
			l_button: EV_BUTTON
			l_check_menu_item: EV_CHECK_MENU_ITEM
			l_combo_box: EV_COMBO_BOX
			l_frame: EV_FRAME
			l_label: EV_LABEL
			l_list_item: EV_LIST_ITEM
			l_menu: EV_MENU
			l_menu_separator: EV_MENU_SEPARATOR
			l_radio_button: EV_RADIO_BUTTON
			l_radio_menu_item: EV_RADIO_MENU_ITEM
			l_rich_text: EV_RICH_TEXT
			l_text: EV_TEXT
			l_text_field: EV_TEXT_FIELD
			l_tool_bar_button: EV_TOOL_BAR_BUTTON
			l_tool_bar_radio_button: EV_TOOL_BAR_RADIO_BUTTON
			l_tree_item: EV_TREE_ITEM
				-- Notebook related
			l_notebook: EV_NOTEBOOK
			l_notebook_tab: EV_NOTEBOOK_TAB
			l_box: EV_VERTICAL_BOX
		do
				-- Notebook related
			create l_box
			create l_notebook
			l_notebook.extend (l_box)
			l_notebook_tab := l_notebook.item_tab (l_box)
			test_date_textables (l_notebook_tab)

				-- All others
			create l_button
			create l_check_menu_item
			create l_combo_box
			create l_frame
			create l_label
			create l_list_item
			create l_menu
			create l_menu_separator
			create l_radio_button
			create l_radio_menu_item
			create l_rich_text
			create l_text
			create l_text_field
			create l_tool_bar_button
			create l_tool_bar_radio_button
			create l_tree_item

			test_time_textables (l_button)
			test_time_textables (l_check_menu_item)
			test_time_textables (l_combo_box)
			test_time_textables (l_frame)
			test_time_textables (l_label)
			test_time_textables (l_list_item)
			test_time_textables (l_menu)
			test_time_textables (l_menu_separator)
			test_time_textables (l_radio_button)
			test_time_textables (l_radio_menu_item)
			test_time_textables (l_rich_text)
			test_time_textables (l_text)
			test_time_textables (l_text_field)
			test_time_textables (l_tool_bar_button)
			test_time_textables (l_tool_bar_radio_button)
			test_time_textables (l_tree_item)
		end

	mvc_string_date_time_tests
		local
			l_button: EV_BUTTON
			l_check_menu_item: EV_CHECK_MENU_ITEM
			l_combo_box: EV_COMBO_BOX
			l_frame: EV_FRAME
			l_label: EV_LABEL
			l_list_item: EV_LIST_ITEM
			l_menu: EV_MENU
			l_menu_separator: EV_MENU_SEPARATOR
			l_radio_button: EV_RADIO_BUTTON
			l_radio_menu_item: EV_RADIO_MENU_ITEM
			l_rich_text: EV_RICH_TEXT
			l_text: EV_TEXT
			l_text_field: EV_TEXT_FIELD
			l_tool_bar_button: EV_TOOL_BAR_BUTTON
			l_tool_bar_radio_button: EV_TOOL_BAR_RADIO_BUTTON
			l_tree_item: EV_TREE_ITEM
				-- Notebook related
			l_notebook: EV_NOTEBOOK
			l_notebook_tab: EV_NOTEBOOK_TAB
			l_box: EV_VERTICAL_BOX
		do
				-- Notebook related
			create l_box
			create l_notebook
			l_notebook.extend (l_box)
			l_notebook_tab := l_notebook.item_tab (l_box)
			test_date_textables (l_notebook_tab)

				-- All others
			create l_button
			create l_check_menu_item
			create l_combo_box
			create l_frame
			create l_label
			create l_list_item
			create l_menu
			create l_menu_separator
			create l_radio_button
			create l_radio_menu_item
			create l_rich_text
			create l_text
			create l_text_field
			create l_tool_bar_button
			create l_tool_bar_radio_button
			create l_tree_item

			test_date_time_textables (l_button)
			test_date_time_textables (l_check_menu_item)
			test_date_time_textables (l_combo_box)
			test_date_time_textables (l_frame)
			test_date_time_textables (l_label)
			test_date_time_textables (l_list_item)
			test_date_time_textables (l_menu)
			test_date_time_textables (l_menu_separator)
			test_date_time_textables (l_radio_button)
			test_date_time_textables (l_radio_menu_item)
			test_date_time_textables (l_rich_text)
			test_date_time_textables (l_text)
			test_date_time_textables (l_text_field)
			test_date_time_textables (l_tool_bar_button)
			test_date_time_textables (l_tool_bar_radio_button)
			test_date_time_textables (l_tree_item)
		end

	mvc_decimal_tests
		local
			l_button: EV_BUTTON
			l_check_menu_item: EV_CHECK_MENU_ITEM
			l_combo_box: EV_COMBO_BOX
			l_frame: EV_FRAME
			l_label: EV_LABEL
			l_list_item: EV_LIST_ITEM
			l_menu: EV_MENU
			l_menu_separator: EV_MENU_SEPARATOR
			l_radio_button: EV_RADIO_BUTTON
			l_radio_menu_item: EV_RADIO_MENU_ITEM
			l_rich_text: EV_RICH_TEXT
			l_text: EV_TEXT
			l_text_field: EV_TEXT_FIELD
			l_tool_bar_button: EV_TOOL_BAR_BUTTON
			l_tool_bar_radio_button: EV_TOOL_BAR_RADIO_BUTTON
			l_tree_item: EV_TREE_ITEM
				-- Notebook related
			l_notebook: EV_NOTEBOOK
			l_notebook_tab: EV_NOTEBOOK_TAB
			l_box: EV_VERTICAL_BOX
		do
				-- Notebook related
			create l_box
			create l_notebook
			l_notebook.extend (l_box)
			l_notebook_tab := l_notebook.item_tab (l_box)
			test_date_textables (l_notebook_tab)

				-- All others
			create l_button
			create l_check_menu_item
			create l_combo_box
			create l_frame
			create l_label
			create l_list_item
			create l_menu
			create l_menu_separator
			create l_radio_button
			create l_radio_menu_item
			create l_rich_text
			create l_text
			create l_text_field
			create l_tool_bar_button
			create l_tool_bar_radio_button
			create l_tree_item

			test_decimal_textables (l_button)
			test_decimal_textables (l_check_menu_item)
			test_decimal_textables (l_combo_box)
			test_decimal_textables (l_frame)
			test_decimal_textables (l_label)
			test_decimal_textables (l_list_item)
			test_decimal_textables (l_menu)
			test_decimal_textables (l_menu_separator)
			test_decimal_textables (l_radio_button)
			test_decimal_textables (l_radio_menu_item)
			test_decimal_textables (l_rich_text)
			test_decimal_textables (l_text)
			test_decimal_textables (l_text_field)
			test_decimal_textables (l_tool_bar_button)
			test_decimal_textables (l_tool_bar_radio_button)
			test_decimal_textables (l_tree_item)
		end

	mvc_integer_tests
		local
			l_button: EV_BUTTON
			l_check_menu_item: EV_CHECK_MENU_ITEM
			l_combo_box: EV_COMBO_BOX
			l_frame: EV_FRAME
			l_label: EV_LABEL
			l_list_item: EV_LIST_ITEM
			l_menu: EV_MENU
			l_menu_separator: EV_MENU_SEPARATOR
			l_radio_button: EV_RADIO_BUTTON
			l_radio_menu_item: EV_RADIO_MENU_ITEM
			l_rich_text: EV_RICH_TEXT
			l_text: EV_TEXT
			l_text_field: EV_TEXT_FIELD
			l_tool_bar_button: EV_TOOL_BAR_BUTTON
			l_tool_bar_radio_button: EV_TOOL_BAR_RADIO_BUTTON
			l_tree_item: EV_TREE_ITEM
				-- Notebook related
			l_notebook: EV_NOTEBOOK
			l_notebook_tab: EV_NOTEBOOK_TAB
			l_box: EV_VERTICAL_BOX
		do
				-- Notebook related
			create l_box
			create l_notebook
			l_notebook.extend (l_box)
			l_notebook_tab := l_notebook.item_tab (l_box)
			test_date_textables (l_notebook_tab)

				-- All others
			create l_button
			create l_check_menu_item
			create l_combo_box
			create l_frame
			create l_label
			create l_list_item
			create l_menu
			create l_menu_separator
			create l_radio_button
			create l_radio_menu_item
			create l_rich_text
			create l_text
			create l_text_field
			create l_tool_bar_button
			create l_tool_bar_radio_button
			create l_tree_item

			test_integer_textables (l_button)
			test_integer_textables (l_check_menu_item)
			test_integer_textables (l_combo_box)
			test_integer_textables (l_frame)
			test_integer_textables (l_label)
			test_integer_textables (l_list_item)
			test_integer_textables (l_menu)
			test_integer_textables (l_menu_separator)
			test_integer_textables (l_radio_button)
			test_integer_textables (l_radio_menu_item)
			test_integer_textables (l_rich_text)
			test_integer_textables (l_text)
			test_integer_textables (l_text_field)
			test_integer_textables (l_tool_bar_button)
			test_integer_textables (l_tool_bar_radio_button)
			test_integer_textables (l_tree_item)
		end

feature {NONE} -- Test Helpers

	test_integer_textables (a_widget: EV_TEXTABLE)
		local
			l_mvc_date: MVC_TEXTABLE_INTEGER
		do
				-- Workflow: Creation
			create l_mvc_date.make_with_widget (a_widget, agent a_widget.set_text, agent a_widget.text)
			l_mvc_date.set_model_getter_agent (agent mock_object_one.mock_integer)
			l_mvc_date.set_model_setter_agent (agent mock_object_one.set_mock_integer)
			mock_object_one.set_mock_integer (9876)

				-- Workflow: Model to View
			l_mvc_date.model_to_view

				-- Test: View has date
			assert_strings_equal ("view_has_integer", "9876", a_widget.text)

				-- Workflow: Change date
			a_widget.set_text ("6789")

				-- Workflow: View to Model
			l_mvc_date.view_to_model

				-- Test: Model has new date
			assert_strings_equal ("model_has_new_integer", "6789", mock_object_one.mock_integer.out)
		end

	test_decimal_textables (a_widget: EV_TEXTABLE)
		local
			l_mvc_date: MVC_TEXTABLE_DECIMAL
		do
				-- Workflow: Creation
			create l_mvc_date.make_with_widget (a_widget, agent a_widget.set_text, agent a_widget.text)
			l_mvc_date.set_model_getter_agent (agent mock_object_one.mock_decimal)
			l_mvc_date.set_model_setter_agent (agent mock_object_one.set_mock_decimal)
			mock_object_one.set_mock_decimal (create {DECIMAL}.make_from_string ("100.99"))

				-- Workflow: Model to View
			l_mvc_date.model_to_view

				-- Test: View has date
			assert_strings_equal ("view_has_decimal", "100.99", a_widget.text)

				-- Workflow: Change date
			a_widget.set_text ("99.001")

				-- Workflow: View to Model
			l_mvc_date.view_to_model

				-- Test: Model has new date
			assert_strings_equal ("model_has_new_decimal", "99.001", mock_object_one.mock_decimal.out)
		end

	test_date_time_textables (a_widget: EV_TEXTABLE)
		local
			l_mvc_date: MVC_TEXTABLE_DATE_TIME
		do
				-- Workflow: Creation
			create l_mvc_date.make_with_widget (a_widget, agent a_widget.set_text, agent a_widget.text)
			l_mvc_date.set_model_getter_agent (agent mock_object_one.mock_date_time)
			l_mvc_date.set_model_setter_agent (agent mock_object_one.set_mock_date_time)
			mock_object_one.set_mock_date_time (create {DATE_TIME}.make (2017, 1, 1, 12, 0, 0))

				-- Workflow: Model to View
			l_mvc_date.model_to_view

				-- Test: View has date
			assert_strings_equal ("view_has_date", "01/01/2017 12:00:00.000 PM", a_widget.text)

				-- Workflow: Change date
			a_widget.set_text ("12/31/2017 10:00:00.000 PM")

				-- Workflow: View to Model
			l_mvc_date.view_to_model

				-- Test: Model has new date
			assert_strings_equal ("model_has_new_date", "12/31/2017 10:00:00.000 PM", mock_object_one.mock_date_time.out)
		end

	test_time_textables (a_widget: EV_TEXTABLE)
		local
			l_mvc_date: MVC_TEXTABLE_TIME
		do
				-- Workflow: Creation
			create l_mvc_date.make_with_widget (a_widget, agent a_widget.set_text, agent a_widget.text)
			l_mvc_date.set_model_getter_agent (agent mock_object_one.mock_time)
			l_mvc_date.set_model_setter_agent (agent mock_object_one.set_mock_time)
			mock_object_one.set_mock_time (create {TIME}.make (12, 0, 0))

				-- Workflow: Model to View
			l_mvc_date.model_to_view

				-- Test: View has date
			assert_strings_equal ("view_has_date", "12:00:00.000 PM", a_widget.text)

				-- Workflow: Change date
			a_widget.set_text ("10:00:00.000 AM")

				-- Workflow: View to Model
			l_mvc_date.view_to_model

				-- Test: Model has new date
			assert_strings_equal ("model_has_new_date", "10:00:00.000 AM", mock_object_one.mock_time.out)
		end

	test_date_textables (a_widget: EV_TEXTABLE)
		local
			l_mvc_date: MVC_TEXTABLE_DATE
		do
				-- Workflow: Creation
			create l_mvc_date.make_with_widget (a_widget, agent a_widget.set_text, agent a_widget.text)
			l_mvc_date.set_model_getter_agent (agent mock_object_one.mock_date)
			l_mvc_date.set_model_setter_agent (agent mock_object_one.set_mock_date)
			mock_object_one.set_mock_date (create {DATE}.make (2017, 1, 1))

				-- Workflow: Model to View
			l_mvc_date.model_to_view

				-- Test: View has date
			assert_strings_equal ("view_has_date", "01/01/2017", a_widget.text)

				-- Workflow: Change date
			a_widget.set_text ("12/31/2017")

				-- Workflow: View to Model
			l_mvc_date.view_to_model

				-- Test: Model has new date
			assert_strings_equal ("model_has_new_date", "12/31/2017", mock_object_one.mock_date.out)
		end

	test_textable (a_widget: EV_TEXTABLE)
		local
			l_aware: MVC_TEXTABLE_STRING_32
		do
				-- Workflow: Creation & Setup
			create l_aware.make_with_widget (a_widget, agent a_widget.set_text, agent a_widget.text)
			l_aware.set_model_getter_agent (agent mock_object_one.mock_string_32)
			l_aware.set_model_setter_agent (agent mock_object_one.set_mock_string_32)
			mock_object_one.reset_mock_string_32

				-- Test: default state
			assert_32 ("a_widget_text_is_empty", a_widget.text.is_empty)
			assert_strings_not_equal ("view_not_equal_model", a_widget.text, mock_object_one.mock_string_32)
			assert_strings_equal ("mock_string_text", Mock_string_32_default, mock_object_one.mock_string_32)

				-- Workflow: Model to View
			l_aware.model_to_view

				-- Test: Label text
			assert_strings_equal ("view_same_as_model", a_widget.text, mock_object_one.mock_string_32)

				-- Workflow: New widget text
			a_widget.set_text (View_to_model_widget_text.twin)

				-- Test: New widget text set
			assert_strings_equal ("view_label_text", View_to_model_widget_text, a_widget.text)

				-- Workflow: View to Model
			l_aware.view_to_model

				-- Test: Model has string
			assert_strings_equal ("model_has_string", View_to_model_widget_text, mock_object_one.mock_string_32)
		end

feature {NONE} -- Mock Objects

	View_to_model_widget_text: STRING = "view_label_text"

	Mock_string_32_default: STRING_32
		once
			Result := {MOCK_OBJECT_ONE}.Mock_string_32_default.twin
		end

	mock_object_one: MOCK_OBJECT_ONE
		attribute
			create Result
		end

end
