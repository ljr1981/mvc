class
	MVC_TEXTABLE_DECIMAL

inherit
	MVC_TEXTABLE [DECIMAL]
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

	on_model_to_view_date_converter_agent (a_model: DECIMAL): STRING_32
			-- Convert from DATE to STRING
		do
			Result := a_model.out.to_string_32
		end

	on_view_to_model_date_converter_agent (a_text: STRING_32): DECIMAL
			-- Convert from STRING to DATE
		do
			create Result.make_zero
			if
				a_text.is_number_sequence or else
				a_text.is_real or else
				a_text.is_integer or else
				a_text.is_natural
			then
				create Result.make_from_string (a_text.out)
			end
		end

	on_view_data_validator_agent (a_text: detachable STRING_32): BOOLEAN
			-- Is the STRING correctly formatted for creating a DATE?
		do
			Result := attached a_text as al_text and then
						(al_text.is_number_sequence or else
						al_text.is_real or else
						al_text.is_integer or else
						al_text.is_natural)
		end

end
