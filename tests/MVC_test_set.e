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

	misc
		local
			l_string: MVC_TEXTABLE_STRING
			l_readable: MVC_TEXTABLE_READABLE_STRING_GENERAL
		do

		end

	mvc_list_tests
		note
			problems: "[
				The issue is: check attached {G_IMP} v.implementation as l_item then
				
				Where: {G_IMP} = EV_ANY_I and the actual incoming is EV_LIST_ITEM_IMP.
							The v.implementation is attached, so the problem must be
							conformance of EV_LIST_ITEM_IMP = G_IMP -> EV_ANY_I
							
				Bottom line: The failure is that only EV_COMBO_BOX and EV_LIST will
						take an {EV_CONTAINABLE} item of {EV_LIST_ITEM}. The remainder
						take their own types of containable items.
						
				Solution: Create an ancestor, which will allow descending variants for
						each of the {EV_CONTAINABLE} item types (e.g. EV_MENU_ITEM,
						EV_MULTI_COLUMN_LIST_ROW, *EV_TOOL_BAR_ITEM, and EV_TREE_ITEM)
						
						EV_ITEM
							EV_LIST_ITEM
							EV_MENU_ITEM							--> MVC_MENU_ITEM_LIST
								EV_CHECK_MENU_ITEM
								EV_MENU
								EV_MENU_SEPARATOR
								EV_RADIO_MENU_ITEM
							EV_MULTI_COLUMN_LIST_ROW				--> MVC_MULTI_COLUMN_LIST
							EV_TOOL_BAR_ITEM						--> MVC_TOOL_BAR
								EV_TOOL_BAR_BUTTON
									EV_TOOL_BAR_DROP_DOWN_BUTTON
									EV_TOOL_BAR_RADIO_BUTTON
									EV_TOOL_BAR_TOGGLE_BUTTON
								EV_TOOL_BAR_SEPARATOR
							EV_TREE_NODE							--> MVC_TREE_LIST
								EV_TREE_ITEM
				]"
		do
			test_list (create {EV_COMBO_BOX})
			test_list (create {EV_LIST})
--			test_list (create {EV_MENU}) 				-- test routine: exceptional (Check violation in EV_DYNAMIC_LIST_IMP.insert_i_th)
--			test_list (create {EV_MENU_BAR}) 			-- test routine: exceptional (Check violation in EV_DYNAMIC_LIST_IMP.insert_i_th)
--			test_list (create {EV_MULTI_COLUMN_LIST}) 	-- test routine: exceptional (Check violation in EV_DYNAMIC_LIST_IMP.insert_i_th)
--			test_list (create {EV_TOOL_BAR}) 			-- test routine: exceptional (Check violation in EV_DYNAMIC_LIST_IMP.insert_i_th)
--			test_list (create {EV_TREE})				-- test routine: exceptional (Check violation in EV_DYNAMIC_LIST_IMP.insert_i_th)
--			test_list (create {EV_CHECKABLE_TREE})		-- test routine: exceptional (Check violation in EV_DYNAMIC_LIST_IMP.insert_i_th)
--			test_list (create {EV_TREE_ITEM})			-- test routine: exceptional (Check violation in EV_DYNAMIC_LIST_IMP.insert_i_th)

		end

	test_list (a_list: EV_ITEM_LIST [EV_ITEM])
		local
			l_mvc_list: MVC_LIST_ITEM_LIST
		do
				-- WORKFLOW: Creation
			create items.make_from_array (<<"blah1", "blah2">>)
			create l_mvc_list.make_with_widget (a_list, agent a_list.extend, agent a_list.linear_representation)
			create l_mvc_list.make_as_ev_list (a_list, agent items, items)
				-- WORKFLOW: Model to View
			l_mvc_list.model_to_view
				-- WORKFLOW: change an item
			check has_widget: attached l_mvc_list.widget as al_widget then
				check has_item: attached {EV_LIST_ITEM} al_widget.at (1) as al_item then
					al_item.set_text ("something_new")
				end
			end
				-- WORKFLOW: View to Model
			l_mvc_list.view_to_model
				-- TEST: Model has View?
			assert_strings_equal ("something_new", "something_new", items [1])
		end

	items: ARRAYED_LIST [STRING] attribute create Result.make (2) end
			-- An array of `items' for use with `mvc_list_tests' (above).

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

	mvc_boolean_tests
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

			test_boolean_textables (l_button)
			test_boolean_textables (l_check_menu_item)
			test_boolean_textables (l_combo_box)
			test_boolean_textables (l_frame)
			test_boolean_textables (l_label)
			test_boolean_textables (l_list_item)
			test_boolean_textables (l_menu)
			test_boolean_textables (l_menu_separator)
			test_boolean_textables (l_radio_button)
			test_boolean_textables (l_radio_menu_item)
			test_boolean_textables (l_rich_text)
			test_boolean_textables (l_text)
			test_boolean_textables (l_text_field)
			test_boolean_textables (l_tool_bar_button)
			test_boolean_textables (l_tool_bar_radio_button)
			test_boolean_textables (l_tree_item)
		end

	mvc_real_tests
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

			test_real_textables (l_button)
			test_real_textables (l_check_menu_item)
			test_real_textables (l_combo_box)
			test_real_textables (l_frame)
			test_real_textables (l_label)
			test_real_textables (l_list_item)
			test_real_textables (l_menu)
			test_real_textables (l_menu_separator)
			test_real_textables (l_radio_button)
			test_real_textables (l_radio_menu_item)
			test_real_textables (l_rich_text)
			test_real_textables (l_text)
			test_real_textables (l_text_field)
			test_real_textables (l_tool_bar_button)
			test_real_textables (l_tool_bar_radio_button)
			test_real_textables (l_tree_item)
		end

feature {NONE} -- Test Helpers

	test_real_textables (a_widget: EV_TEXTABLE)
		local
			l_mvc: MVC_TEXTABLE_REAL
		do
				-- Workflow: Creation
			create l_mvc.make_with_widget (a_widget, agent a_widget.set_text, agent a_widget.text)
			l_mvc.set_model_getter_agent (agent mock_object_one.mock_real)
			l_mvc.set_model_setter_agent (agent mock_object_one.set_mock_real)
			mock_object_one.set_mock_real (0.01)

				-- Workflow: Model to View
			l_mvc.model_to_view

				-- Test: View has date
			assert_strings_equal ("view_has_real", "0.01", a_widget.text)

				-- Workflow: Change date
			a_widget.set_text ("0.02")

				-- Workflow: View to Model
			l_mvc.view_to_model

				-- Test: Model has new date
			assert_strings_equal ("model_has_new_real", "0.02", mock_object_one.mock_real.out)
		end

	test_boolean_textables (a_widget: EV_TEXTABLE)
		local
			l_mvc: MVC_TEXTABLE_BOOLEAN
		do
				-- Workflow: Creation
			create l_mvc.make_with_widget (a_widget, agent a_widget.set_text, agent a_widget.text)
			l_mvc.set_model_getter_agent (agent mock_object_one.mock_boolean)
			l_mvc.set_model_setter_agent (agent mock_object_one.set_mock_boolean)
			mock_object_one.set_mock_boolean (True)

				-- Workflow: Model to View
			l_mvc.model_to_view

				-- Test: View has date
			assert_strings_equal ("view_has_integer", "True", a_widget.text)

				-- Workflow: Change date
			a_widget.set_text ("False")

				-- Workflow: View to Model
			l_mvc.view_to_model

				-- Test: Model has new date
			assert_strings_equal ("model_has_new_integer", "False", mock_object_one.mock_boolean.out)
		end

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
