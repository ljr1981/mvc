note
	description: "[
		MVC test object
		]"

class
	MOCK_OBJECT_ONE

feature -- Access

	mock_string_32: STRING_32
		attribute
			Result := Mock_string_32_default.twin
		end

feature -- Setters

	set_mock_string_32 (a_string_32: like mock_string_32)
		do
			mock_string_32 := a_string_32
		end

	reset_mock_string_32
		do
			mock_string_32 := Mock_string_32_default.twin
		end

feature -- Constants

	Mock_string_32_default: STRING = "mock_string_text"

end
