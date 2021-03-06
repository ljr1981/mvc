note
	coverage: "[
		The following classes are potentially covered by this class.
		The caveat to actual coverage is dependent on the 2nd Generic
		below (e.g. ARRAYED_LIST [STRING])--that is--each of the descending
		classes must be storing lists of {STRING} items, which is what
		the getter and setter agents are dependent on.
	
*EV_ITEM_LIST [G -> EV_ITEM]
	*EV_LIST_ITEM_LIST
		{EV_COMBO_BOX}
		{EV_LIST}
	*EV_MENU_ITEM_LIST				-- FAIL from here down
		{EV_MENU}
		{EV_MENU_BAR}
	{EV_MULTI_COLUMN_LIST}
	{EV_TOOL_BAR}
	*EV_TREE_NODE_LIST
		{EV_TREE}
			{EV_CHECKABLE_TREE}
		*EV_TREE_NODE
			{EV_TREE_ITEM}
		]"

deferred class
	MVC_ITEM_LIST [G_LST, G_ARR, G_LIN]

inherit
	MVC_CONTROLLER [G_LST, G_ARR, G_LIN]

--create
--	make_with_widget,
--	make_as_ev_list

feature {NONE} -- Initialization

	make_as_ev_list (a_widget: G_LST; a_model_getter_agent: like model_getter_agent; a_list_model: G_ARR)
		deferred
		end

feature -- Events

	on_list_load (a_items: G_LIN)
		deferred
		end

	on_items_setting (a_items: G_ARR; a_list: G_ARR)
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
		deferred
		end

	on_convert_strings_to_list_items (a_strings: G_ARR): G_LIN
		deferred
		end

	on_convert_list_items_to_strings (a_items: G_LIN): G_ARR
		deferred
		end

end
