deferred class
	MVC_TEXTABLE_ANY [MD -> ANY]

inherit
	MVC_CONTROLLER [EV_TEXTABLE, MD, STRING_32]

feature {NONE} -- Initialization Support

	US_phone_mask: STRING = "(999) 999-9999"

	US_social_security_mask: STRING = "999-99-9999"

	Credit_card_mask: STRING = "9999-9999-9999-9999"

	make_with_masked_widget (a_widget: EV_TEXTABLE; a_widget_setter_agent: like view_setter_agent; a_widget_getter_agent: like view_getter_agent; a_mask: TEXT_INPUT_MASK [ANY, detachable DATA_COLUMN_METADATA [ANY]])
		require
			maskable: attached {EV_TEXT_COMPONENT} a_widget
		do
			check maskable: attached {EV_TEXT_COMPONENT} a_widget as al_text_component then
				a_mask.initialize_masking_widget_events (al_text_component)
				set_masking_agent (agent on_mask (al_text_component, a_mask, ?))
				set_unmasking_agent (agent on_unmask (al_text_component, a_mask, ?))
			end
			make_with_widget (a_widget, a_widget_setter_agent, a_widget_getter_agent)
		end

feature {NONE} -- Masking Agent Events

	on_mask (a_widget: EV_TEXT_COMPONENT; a_mask: INPUT_MASK [ANY, detachable DATA_COLUMN_METADATA [ANY]]; a_string: STRING_32): STRING_32
		do
			Result := a_mask.apply (a_string).masked_string.to_string_32
		end

	on_unmask (a_widget: EV_TEXT_COMPONENT; a_mask: INPUT_MASK [ANY, detachable DATA_COLUMN_METADATA [ANY]]; a_string: STRING_32): STRING_32
		do
			check attached {STRING_32} a_mask.remove (a_widget.text, Void).value as al_value then
				Result := al_value
			end
		end

end
