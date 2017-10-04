class
	MVC_TEXTABLE_STRING_32

inherit
	MVC_TEXTABLE_ANY [STRING_32]

create
	make_with_widget,
	make_masked_as_integer,
	make_masked_as_upper_alpha,
	make_masked_as_upper_mixed,
	make_masked_as_us_phone,
	make_masked_as_us_social_security,
	make_masked_as_credit_card

feature {NONE} -- Initialization

	make_masked_as_integer (a_widget: EV_TEXTABLE; a_widget_setter_agent: like view_setter_agent; a_widget_getter_agent: like view_getter_agent)
		do
			make_with_masked_widget (a_widget, a_widget_setter_agent, a_widget_getter_agent, create {STRING_VALUE_INPUT_MASK}.make_repeating ("9"))
		end

	make_masked_as_upper_alpha (a_widget: EV_TEXTABLE; a_widget_setter_agent: like view_setter_agent; a_widget_getter_agent: like view_getter_agent)
		do
			make_with_masked_widget (a_widget, a_widget_setter_agent, a_widget_getter_agent, create {STRING_VALUE_INPUT_MASK}.make_repeating ("!A"))
		end

	make_masked_as_upper_mixed (a_widget: EV_TEXTABLE; a_widget_setter_agent: like view_setter_agent; a_widget_getter_agent: like view_getter_agent)
		do
			make_with_masked_widget (a_widget, a_widget_setter_agent, a_widget_getter_agent, create {STRING_VALUE_INPUT_MASK}.make_repeating ("!K"))
		end

	make_masked_as_us_phone (a_widget: EV_TEXTABLE; a_widget_setter_agent: like view_setter_agent; a_widget_getter_agent: like view_getter_agent)
		do
			make_with_masked_widget (a_widget, a_widget_setter_agent, a_widget_getter_agent, create {STRING_VALUE_INPUT_MASK}.make (US_phone_mask))
		end

	make_masked_as_us_social_security (a_widget: EV_TEXTABLE; a_widget_setter_agent: like view_setter_agent; a_widget_getter_agent: like view_getter_agent)
		do
			make_with_masked_widget (a_widget, a_widget_setter_agent, a_widget_getter_agent, create {STRING_VALUE_INPUT_MASK}.make (US_social_security_mask))
		end

	make_masked_as_credit_card (a_widget: EV_TEXTABLE; a_widget_setter_agent: like view_setter_agent; a_widget_getter_agent: like view_getter_agent)
		do
			make_with_masked_widget (a_widget, a_widget_setter_agent, a_widget_getter_agent, create {STRING_VALUE_INPUT_MASK}.make (Credit_card_mask))
		end

end
