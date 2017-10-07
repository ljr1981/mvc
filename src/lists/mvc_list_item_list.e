class
	MVC_LIST_ITEM_LIST

inherit
	MVC_CONTROLLER [EV_ITEM_LIST [EV_ITEM], ARRAYED_LIST [STRING], LINEAR [EV_ITEM]]

create
	make_with_widget,
	make_as_ev_list

feature {NONE} -- Initialization

	make_as_ev_list (a_widget: EV_ITEM_LIST [EV_ITEM]; a_model_getter_agent: like model_getter_agent; a_list_model: ARRAYED_LIST [STRING])
		do
			make_with_widget (a_widget, agent on_list_load, agent a_widget.linear_representation)
			set_model_getter_agent (a_model_getter_agent)
			set_model_setter_agent (agent on_items_setting (a_list_model, ?))
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

	on_items_setting (a_items: ARRAYED_LIST [STRING]; a_list: ARRAYED_LIST [STRING])
			-- Settings `a_list' of items back into `a_items', post wipe_out.
		note
			warning: "[
				This 'setter feature' will wipe out the target `a_items' list.
				Any references to the {STRING} objects in the `a_items' list
				will be lost as a result.
				]"
			design: "[
				Adding a non-destructive flag was considered for this feature.
				The idea was to make the call to "wipe_out" conditioned on the
				setting of the flag (True=do-not-call/False=call-wipe-out).
				In the end, there was no way to logically guarantee that the
				list objects could be saved because there is no way to know
				if the incoming View-list is an item-to-item perfect match
				for the target Model-list--that is--on the Model-to-View cycle,
				the Model-list is the basis of the View-list. However, the
				GUI list control can modify the View-list in several key ways:
				
				1) The View-list can be rearranged.
				2) Items from the View-list can be deleted.
				3) Items from the View-list can be added to.
				4) Any combination of the above.
				
				Because cases 1, 2, and 3 are true, there is no way this class
				can know if the incoming View-list items faithfully represent
				their one-to-one target Model-list items. This is immediately
				true if one or more of the View-list items have been deleted,
				rearranged, added, or all three. Even simple View-list item
				modification might change the semantic meaning of the list
				item within the context of the larger system.
				
				This means that YOU (as programmer/system architect) have the
				last say in if the incoming View-list is semantically the same
				as the target Model-list. Moreover, YOU must understand that
				these conditions demand that the target Model-list be destroyed
				first by a call to wipe_out, and then the View-list items added.
				]"
		do
			a_items.wipe_out
			a_items.fill (a_list)
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
