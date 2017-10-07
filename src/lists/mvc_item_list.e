class
	MVC_ITEM_LIST

inherit
	MVC_CONTROLLER [EV_ITEM_LIST [EV_ITEM], CONTAINER [ANY], LINEAR [EV_ITEM]]

create
	make_with_widget,
	make_as_ev_list

feature {NONE} -- Initialization

	make_as_ev_list (a_widget: EV_ITEM_LIST [EV_ITEM]; a_model_getter_agent: like model_getter_agent; a_model_setter_agent: like model_setter_agent)
		do
			make_with_widget (a_widget, agent on_list_load, agent a_widget.linear_representation)
			set_model_setter_agent (a_model_setter_agent)
			set_model_getter_agent (a_model_getter_agent)
			set_model_to_view_data_converter_agent (agent on_convert_strings_to_list_items)
			set_view_to_model_data_converter_agent (agent on_convert_list_items_to_strings)
		end

feature -- Events

	on_list_load (a_items: LINEAR [EV_LIST_ITEM])
		do
			from
				a_items.start
			until
				a_items.off
			loop
				check has_widget: attached widget as al_widget then
					al_widget.extend (a_items.item_for_iteration)
				end
				a_items.forth
			end
		end

	on_convert_strings_to_list_items (a_strings: ARRAYED_LIST [STRING]): LINEAR [EV_LIST_ITEM]
		local
			l_result: ARRAYED_LIST [EV_LIST_ITEM]
		do
			create l_result.make (a_strings.count)
			across
				a_strings as ic
			loop
				l_result.force (create {EV_LIST_ITEM}.make_with_text (ic.item))
			end
			Result := l_result.linear_representation
		end

	on_convert_list_items_to_strings (a_items: LINEAR [EV_LIST_ITEM]): ARRAYED_LIST [STRING]
		do
			a_items.finish
			create Result.make (a_items.index)
			from
				a_items.start
			until
				a_items.off
			loop
				Result.force (a_items.item.text)
				a_items.forth
			end
		end

end
