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

	mock_date_time: DATE_TIME
		attribute
			create Result.make (2017, 1, 1, 12, 0, 0)
		end

	mock_time: TIME
		attribute
			create Result.make (12, 0, 0)
		end

	mock_decimal: DECIMAL
		attribute
			create Result.make_zero
		end

	mock_integer: INTEGER

	mock_boolean: BOOLEAN

	mock_real: REAL

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

	set_mock_time (a_value: like mock_time)
		do
			mock_time := a_value
		end

	set_mock_date_time (a_value: like mock_date_time)
		do
			mock_date_time := a_value
		end

	set_mock_decimal (a_value: like mock_decimal)
		do
			mock_decimal := a_value
		end

	set_mock_integer (a_value: like mock_integer)
		do
			mock_integer := a_value
		end

	set_mock_boolean (a_value: like mock_boolean)
		do
			mock_boolean := a_value
		end

	set_mock_real (a_value: like mock_real)
		do
			mock_real := a_value
		end

feature -- Constants

	Mock_string_32_default: STRING = "mock_string_text"

end
