class
	MVC_TEXTABLE_DATE

inherit
	MVC_TEXTABLE [DATE]
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
			model_to_view_data_converter_agent := agent on_model_to_view_date_converter_agent
		end

feature -- Converters

	on_model_to_view_date_converter_agent (a_model: DATE): STRING_32
		do
			Result := {STRING_32} ""
		end

end
