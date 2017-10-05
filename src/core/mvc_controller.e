note
	description: "[
		Abstract notion of something that is MVC_AWARE.
		]"
	design: "[
		See end-of-class notes.
		]"

deferred class
	MVC_CONTROLLER [P -> EV_ANY, MD -> detachable ANY, VD -> ANY]
			-- P = Type of Primitive widget {EV_PRIMITIVE} or {EV_TEXTABLE}
			-- MD = Model-data type
			-- VD = View-data type (implies conversion from MD<-->VD)

inherit
	MVC_ANY

feature {NONE} -- Initialization

	make_with_widget (a_widget: P; a_widget_setter_agent: like view_setter_agent; a_widget_getter_agent: like view_getter_agent)
			-- `make_with_widget' `a_widget'.
		do
			widget := a_widget
			view_setter_agent := a_widget_setter_agent
			view_getter_agent := a_widget_getter_agent
		ensure
			set: widget ~ a_widget
		end

feature -- Future

	-- features for common reasonable_default
	-- features for common conversions (from model to view-reaady back to model)
	-- features for common validation (model data validation, not view data)

feature -- Access: Widget

	widget: detachable P
			-- The `widget' operating as the "View".

feature -- Ops

	model_to_view
			-- Move data from Model to View, by the process of:
			-- Model-get, validate, convert, mask, View-set/render.
		local
			l_data: MD
			l_converted_data,
			l_masked_data: VD
		do
				-- 1. GET
			attached_model_getter_agent.call (Void)
			l_data := attached_model_getter_agent.last_result

				-- 2. VALIDATION (optional and always True (valid) when no validator)
			if attached model_data_validator_agent as al_agent then
				al_agent.call ([l_data])
				is_valid := al_agent.last_result
			else
				is_valid := True
			end

				-- 3. CONVERSION (optional with possible pass-through)
			if
				attached model_to_view_data_converter_agent as al_converter_agent and then
					attached l_data as al_data
			then
				al_converter_agent.call ([al_data])
				check has_converted_data: attached al_converter_agent.last_result as al_converted_result then
					l_converted_data := al_converted_result
				end
			else
				check attached {VD} l_data as al_passthrough_converted_data then
					l_converted_data := al_passthrough_converted_data -- pass-through
				end
			end
			check has_converted_data: attached l_converted_data end

				-- 4. MASK (optional with possible pass-through)
			l_masked_data := l_converted_data -- pass-through
			if attached masking_agent as al_agent then
				al_agent.call ([l_converted_data])
				if attached al_agent.last_result as al_masked_result then
					l_masked_data := al_masked_result
				end
			end
			check has_masked_data: attached l_masked_data end

				-- 5. RENDER
			view_setter_agent.call (l_masked_data)
		end

	view_to_model
			-- Move View data to Model by the actions of:
			-- Unrender, unmask, pre-validate, convert, post-validate, model-set.
		local
			l_view_data: VD
			l_unmasked_data: VD
			l_converted_data: MD
		do
				--	1. UNRENDER (required): Fetch the data from the View, bringing it into
			view_getter_agent.call ([Void])
			check has_view_data: attached view_getter_agent.last_result as al_view_data then
				l_view_data := al_view_data
			end
				--	2. UNMASK (optionally): Remove masking transforms from View data, reconstituting
			if attached unmasking_agent as al_agent then
				al_agent.call ([l_view_data])
				check has_unmasked_result: attached al_agent.last_result as al_unmasked_result then
					l_unmasked_data := al_unmasked_result
				end
			else
				l_unmasked_data := l_view_data
			end
				--	3. PRE-VALIDATION (optionally): Determine if the raw View data is valid or invalid.
			if attached  view_data_validator_agent as al_validator_agent then
				al_validator_agent.call ([l_unmasked_data])
				check attached al_validator_agent.last_result as al_validator_result then
					is_valid := al_validator_result
				end
			else
				is_valid := True
			end
				--	4. CONVERT (optionally): Convert the unmasked raw View data back to a Model form.
			if attached view_to_model_data_converter_agent as al_converter_agent then
				al_converter_agent.call ([l_unmasked_data])
				check has_converted_data: attached al_converter_agent.last_result as al_converted_data then
					l_converted_data := al_converted_data
				end
			else
				check same: attached {MD} l_unmasked_data as al_converted_data then
					l_converted_data := al_converted_data
				end
			end
				--	5. POST-VALIDATION (optionally): Determine if the raw View data is valid or invalid.
			if attached  model_data_validator_agent as al_validator_agent then
				al_validator_agent.call ([l_converted_data])
				check attached al_validator_agent.last_result as al_validator_result then
					is_valid := al_validator_result
				end
			else
				is_valid := True
			end
				--	6. SET (required): Depending on rule `can_take_invalid_data' for the Model attribute,
			if is_valid then
				check has_setter: attached model_setter_agent as al_setter_agent then
					al_setter_agent.call ([l_converted_data])
				end
			end
		end

	is_valid: BOOLEAN

feature -- Access: Getter-Setter

	model_getter_agent: detachable FUNCTION [MD]
			-- Gets MD model data from model for view.

	attached_model_getter_agent: attached like model_getter_agent
			-- Attached version of `model_getter_agent'.
		do
			check has_agent: attached model_getter_agent as al_agent then
				Result := al_agent
			end
		end

	model_setter_agent: detachable PROCEDURE [MD]
			-- Sets MD model data from view to the model.

	model_to_reasonable_default_agent: detachable PROCEDURE
			-- A call to a model PROCEDURE that resets
			--	the model attribute to a reasonable default.

feature -- Access: Converters

	view_to_model_data_converter_agent: detachable FUNCTION [TUPLE [VD], MD]
			-- Converts VD view data to MD model-ready data
			--  This is a specialized converter.
			-- 	There are common converters based on MD:VD type pairs

	model_to_view_data_converter_agent: detachable FUNCTION [TUPLE [MD], VD]
			-- Converts MD model data to VD view-ready data
			--  This is a specialized converter.
			-- 	There are common converters based on MD:VD type pairs

feature -- Access: Masking

	unmasking_agent: detachable FUNCTION [TUPLE [VD], VD]
			-- Unmasks data of `widget'.

	masking_agent: detachable FUNCTION [TUPLE [VD], VD]
			-- Masks data of `widget'.

feature -- Access: Validation

	model_data_validator_agent: detachable PREDICATE [detachable MD]
			-- Responsible for ensuring data passed to or from
			-- model is valid before getting or setting.

	view_data_validator_agent: detachable PREDICATE [detachable VD]
			-- Responsible for ensuring converted view data is
			-- valid.

feature -- Access: View-setter

	view_setter_agent: PROCEDURE
			-- Sets data on to the View-object (widget).

	view_getter_agent: FUNCTION [VD]
			-- Gets data from the View-object (widget).

feature -- Settings

	set_widget (a_widget: like widget)
			-- Sets `widget' with `a_widget'.
		do
			widget := a_widget
		ensure
			widget_set: widget = a_widget
		end

	set_model_setter_agent (a_model_setter_agent: like model_setter_agent)
			-- Sets `model_setter_agent' with `a_model_setter_agent'.
		do
			model_setter_agent := a_model_setter_agent
		ensure
			model_setter_agent_set: model_setter_agent = a_model_setter_agent
		end

	set_model_to_reasonable_default_agent (a_model_to_reasonable_default_agent: like model_to_reasonable_default_agent)
			-- Sets `model_to_reasonable_default_agent' with `a_model_to_reasonable_default_agent'.
		do
			model_to_reasonable_default_agent := a_model_to_reasonable_default_agent
		ensure
			model_to_reasonable_default_agent_set: model_to_reasonable_default_agent = a_model_to_reasonable_default_agent
		end

	set_model_getter_agent (a_model_getter_agent: like model_getter_agent)
			-- Sets `model_getter_agent' with `a_model_getter_agent'.
		do
			model_getter_agent := a_model_getter_agent
		ensure
			model_getter_agent_set: model_getter_agent = a_model_getter_agent
		end

	set_model_to_view_data_converter_agent (a_model_to_view_data_converter_agent: like model_to_view_data_converter_agent)
			-- Sets `model_to_view_data_converter_agent' with `a_model_to_view_data_converter_agent'.
		do
			model_to_view_data_converter_agent := a_model_to_view_data_converter_agent
		ensure
			model_to_view_data_converter_agent_set: model_to_view_data_converter_agent = a_model_to_view_data_converter_agent
		end

	set_view_to_model_data_converter_agent (a_view_to_model_data_converter_agent: like view_to_model_data_converter_agent)
			-- Sets `view_to_model_data_converter_agent' with `a_view_to_model_data_converter_agent'.
		do
			view_to_model_data_converter_agent := a_view_to_model_data_converter_agent
		ensure
			view_to_model_data_converter_agent_set: view_to_model_data_converter_agent = a_view_to_model_data_converter_agent
		end

	set_unmasking_agent (a_unmasking_agent: like unmasking_agent)
			-- Sets `unmasking_agent' with `a_unmasking_agent'.
		do
			unmasking_agent := a_unmasking_agent
		ensure
			unmasking_agent_set: unmasking_agent = a_unmasking_agent
		end

	set_masking_agent (a_masking_agent: like masking_agent)
			-- Sets `masking_agent' with `a_masking_agent'.
		do
			masking_agent := a_masking_agent
		ensure
			masking_agent_set: masking_agent = a_masking_agent
		end

	set_model_data_validator_agent (a_model_data_validator_agent: like model_data_validator_agent)
			-- Sets `model_data_validator_agent' with `a_model_data_validator_agent'.
		do
			model_data_validator_agent := a_model_data_validator_agent
		ensure
			model_data_validator_agent_set: model_data_validator_agent = a_model_data_validator_agent
		end
note
	design: "[
		This class represents a Controller for a single Model (object) + View (object).
		
		The goal of this class is to facilitate the movement of data back and
		forth between the Model and the View.
		
		Assume:
		-------
		1. We can have a Controller without a defined Model or View.
			The Controller is not useful until the Model and View are
			defined (e.g. we have a GUI View control and Model agents).
		2. A View consists of a single EV_PRIMITIVE GUI element.
		3. A Model consists of the Controller agents.
		
		BNF:
		----
		Controller ::=
			[View_object]
			[Model_agents]
			[Validator_agents]
			[Converter_agents]
			[Masking_agents]
			
		Model_agents ::=
			Model_getter_agent
			Model_setter_agent
			Model_reasonable_default_agent
			
		Validator_agents ::=
			Model_data_validator_agent
			View_data_validator_agent
			
		Converter_agents ::=
			Model_to_view_converter_agent
			View_to_model_converter_agent
			
		Masking_agents ::=
			Masking_agent
			Unmasking_agent
			
		Workflow:
		=========
		This class is designed for one or more workflows (use cases).
		
		Workflow: Model-to-View:
		------------------------
		Move data from the Model to the View when triggered to do so.
		
		1. GET (required): Execute the Model_getter_agent as a Query routine, whose Result
			is the attribute object reference (e.g. could be a base type
			like STRING, BOOLEAN, REAL, DECIMAL, and so on).
		
		2. VALIDATION (optionally): Determine if the Model data result is valid or invalid. Set a
			`is_valid' flag accordingly. The purpose of this flag is to
			instruct the surrounding system that the data is valid or invalid
			so it can make a proper presentation to the user somewhere in
			the GUI.
			
		3. CONVERSION (optionally): Convert the Model data result to a View-usable form.
		
		4. MASK (optionally): Appy any data masking to the Model data result.
		
		5. RENDER (required): Render the masked Model data result in the View.
		
		Workflow: View-to-Model:
		------------------------
		Move data from the View to the Model when triggered to do so.
		
		1. UNRENDER (required): Fetch the data from the View, bringing it into
			the Controller for processing.
		
		2. UNMASK (optionally): Remove masking transforms from View data, reconstituting
			an unmasked version of the data.
			
		3. PRE-VALIDATION (optionally): Determine if raw unmasked View data is valid for conversion.
			
		4. CONVERT (optionally): Convert the unmasked raw View data back to a Model form.
		
		5. POST-VALIDATION (optionally): Determine if converted data is valid for Model.
			
		6. SET (required): Depending on rule `can_take_invalid_data' for the Model attribute,
			execute the Model_setter_agent as a Procedure routine taking one argument (i.e.
			the raw Model data value).
			
		NOTE: The successive agents operate as a "chain", passing the data down each agent
				as one would move a product along an assembly line.

		]"

end

