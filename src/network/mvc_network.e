class
	MVC_NETWORK

inherit
	MVC_ANY

feature -- Access

	model_to_view_actions: ACTION_SEQUENCE
			-- M2V Controllers in this network.
			-- Example: model_to_view_actions.extend (agent l_mvc.model_to_view)
		attribute
			create Result
		end

	view_to_model_actions: ACTION_SEQUENCE
			-- V2M Controllers in this network.
			-- Example: view_to_model_actions.extend (agent l_mvc.view_to_model)
		attribute
			create Result
		end

	successors: ARRAYED_LIST [MVC_NETWORK]
			-- Successor networks.
		attribute
			create Result.make (5)
		end

feature -- Setters

	add_mvcs_from_array (a_mvcs: ARRAY [MVC_CONTROLLER [EV_ANY, detachable ANY, ANY]])
			-- Add `a_mvcs' items with `add_mvc' to `model_to_view_actions' and
			-- `view_to_model_actions'
		do
			across
				a_mvcs as ic
			loop
				add_mvc (ic.item)
			end
		end

	add_mvc (a_mvc: MVC_CONTROLLER [EV_ANY, detachable ANY, ANY])
			-- Add `a_mvc' controller to actions.
		do
			model_to_view_actions.extend (agent a_mvc.model_to_view)
			view_to_model_actions.extend (agent a_mvc.view_to_model)
		end

	add_successors (a_networks: ARRAY [MVC_NETWORK])
			-- Add all `a_networks' items using `add_successor' for each.
		do
			across
				a_networks as ic
			loop
				add_successor (ic.item)
			end
		end

	add_successor (a_network: MVC_NETWORK)
			-- Add `a_network' successor to `successors'.
		do
			successors.force (a_network)
		end

feature -- Ops: Triggers

	model_to_view
			-- Call model-to-view on `model_to_view_actions' and `successors'.
		do
			model_to_view_actions.call ([Void])
			across
				successors as ic
			loop
				ic.item.model_to_view
			end
		end

	view_to_model
			-- Call view-to-model on `view_to_model_actions' and `successors'.
		do
			view_to_model_actions.call ([Void])
			across
				successors as ic
			loop
				ic.item.view_to_model
			end
		end

end
