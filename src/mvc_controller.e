note
	description: "[
		Abstract notion of something that is MVC_AWARE.
		]"
	design: "[
		See end-of-class notes.
		]"

class
	MVC_CONTROLLER [P -> EV_PRIMITIVE, MD -> ANY, VD -> ANY]
			-- P = Type of Primitive widget
			-- MD = Model-data type
			-- VD = View-data type (implies conversion from MD<-->VD)

inherit
	MVC_ANY

create
	default_create,
	make_with_widget

feature {NONE} -- Initialization

	make_with_widget (a_widget: P)
			-- `make_with_widget' `a_widget'.
		do
			widget := a_widget
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

feature -- Access: Getter-Setter

	model_getter_agent: detachable FUNCTION [MD]
			-- Gets MD model data from model for view.

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

	unmasking_agent: detachable PROCEDURE
			-- Unmasks data of `widget'.

	masking_agent: detachable PROCEDURE
			-- Masks data of `widget'.

feature -- Access: Validation

	model_data_validator_agent: detachable FUNCTION [TUPLE [MD], BOOLEAN]
			-- Responsible for ensuring data passed to or from
			-- model is valid before getting or setting.

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
			
		3. CONVERT (optionally): Convert the unmasked raw View data back to a Model form.
		
		4. VALIDATION (optionally): Determine if the raw Model data is valid or invalid.
			Note that for GUI-level validation, one might stop here (e.g. not complete
			the final step of sending the data back to the Model).
			
		5. SET (required): Depending on rule `can_take_invalid_data' for the Model attribute,
			execute the Model_setter_agent as a Procedure routine taking one argument (i.e.
			the raw Model data value).
			
		NOTE: The successive agents operate as a "chain", passing the data down each agent
				as one would move a product along an assembly line.
				
		]"

end

