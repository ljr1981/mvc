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

	mock_date: DATE
		attribute
			create Result.make (2017, 1, 1)
		end

	mock_decimal: DECIMAL
		attribute
			create Result.make_zero
		end

feature -- Setters

	set_mock_string_32 (a_value: like mock_string_32)
		do
			mock_string_32 := a_value
		end

	reset_mock_string_32
		do
			mock_string_32 := Mock_string_32_default.twin
		end

	set_mock_date (a_value: like mock_date)
		do
			mock_date := a_value
		end

	set_mock_decimal (a_value: like mock_decimal)
		do
			mock_decimal := a_value
		end

feature -- Constants

	Mock_string_32_default: STRING = "mock_string_text"

end
