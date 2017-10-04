class
	MVC_TEXTABLE_INTEGER

inherit
	MVC_TEXTABLE_ANY [INTEGER]
		redefine
			make_with_widget
		end

create
	make_with_widget

feature {NONE} -- Initialization

	make_with_widget (a_widget: EV_TEXTABLE; a_widget_setter_agent: like view_setter_agent; a_widget_getter_agent: like view_getter_agent)
			-- <Precursor>
		do
			Precursor (a_widget, a_widget_setter_agent, a_widget_getter_agent)
			view_data_validator_agent := agent on_view_data_validator_agent
			model_to_view_data_converter_agent := agent on_model_to_view_date_converter_agent
			view_to_model_data_converter_agent := agent on_view_to_model_date_converter_agent
		end

feature -- Converters

	on_model_to_view_date_converter_agent (a_model: INTEGER): STRING_32
			-- Convert from INTEGER to STRING_32
		do
			Result := a_model.out.to_string_32
		end

	on_view_to_model_date_converter_agent (a_text: STRING_32): INTEGER
			-- Convert from STRING_32 to INTEGER
		do
			if
				a_text.is_number_sequence or else
				a_text.is_integer or else
				a_text.is_natural
			then
				Result := a_text.to_integer
			end
		end

	on_view_data_validator_agent (a_text: detachable STRING_32): BOOLEAN
			-- Is the STRING_32 correctly formatted for creating a INTEGER?
		do
			Result := attached a_text as al_text and then
						(al_text.is_number_sequence or else
						al_text.is_integer or else
						al_text.is_natural)
		end

end
