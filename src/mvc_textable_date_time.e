class
	MVC_TEXTABLE_DATE_TIME

inherit
	MVC_TEXTABLE_ANY [DATE_TIME]
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

	on_model_to_view_date_converter_agent (a_model: DATE_TIME): STRING_32
			-- Convert from DATE_TIME to STRING_32
		do
			Result := a_model.out.to_string_32
		end

	on_view_to_model_date_converter_agent (a_date_text: STRING_32): DATE_TIME
			-- Convert from STRING_32 to DATE_TIME
		do
			create Result.make_now
			if Result.date_time_valid (a_date_text, {DATE_TIME_TOOLS}.default_format_string) then
				create Result.make_from_string_default (a_date_text.out)
			end
		end

	on_view_data_validator_agent (a_text: detachable STRING_32): BOOLEAN
			-- Is the STRING_32 correctly formatted for creating a DATE_TIME?
		do
			if attached a_text as al_text then
				Result := (create {DATE_TIME}.make_now).date_time_valid (al_text, {DATE_TIME_TOOLS}.default_format_string)
			else
				Result := True
			end
		end



end
