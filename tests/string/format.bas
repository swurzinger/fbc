#include "fbcunit.bi"
# include "vbcompat.bi"

'' tests marked with "BUG" might be bugged on some platforms
#if ENABLE_CHECK_BUGS
	#define B1 1
	#define B2 1
#else
	'' inhibit some checks on win 64bit (typically mingw64)
	#if defined(__FB_WIN32__) and defined(__FB_64BIT__)
		#define B1 0
	#else
		#define B1 1
	#endif
	'' inhibit some checks on mingw-org, however, we can't
	'' tell the difference between mingw32 and mingw-org
	#if defined(__FB_WIN32__)
		#define B2 0
	#else
		#define B2 1
	#endif
#endif

tests_num:
	data   1, 0.1236,    "",                 ".1236"
' The following example now works because FORMAT now restricts the precision
' to 11 when no format specifier was given.
	data   1, 4578.1236, "",                 "4578.1236"
	data   1, 4578.125,  "",                 "4578.125"
	data   1, 1234.0,    "",                 "1234"

	data   1, 0.1236,    "##0.00%",          "12.36%"
	data   1, 123,       !"\"asd\\\"",        !"asd\\"
	data   1, 0,         "###",              "0"
	data   1, 123,       "###",              "123"
	data   1, 123,       "###00000",         "00123"
	data   1, 123,       "00000###",         "00000123"
	data   1, 123.5,     "0",                "123"
	data   1, 123.51,    "0",                "124"
	data   1, 123.6,     "0",                "124"
	data   1, 1.23,      "###.###",          "1.23"
	data   1, 0.123,     "###.###",          ".123"
	data   1, 0.1234,    "###.###",          ".123"
	data   1, 0.1235,    "###.###",          ".123"
	data   1, 0.12351,   "###.###",          ".124"
	data   1, 0.1236,    "###.###",          ".124"
	data   1, 123,       "###.###",          "123."
	data   1, 123,       "#",                "123"
	data   1, 123,       "#.##e-000",        "1.23e002"
	data   1, 123,       "#.##e+000",        "1.23e+002"
	data   1, 0.123,     "#.##e-000",        "1.23e-001"
	data   1, 0.1234,    "#.##e-000",        "1.23e-001"
	data   1, 0.1235,    "#.##e-000",        "1.23e-001"
	data   1, 0.12351,   "#.##e-000",        "1.24e-001"
	data   1, 0.1236,    "#.##e-000",        "1.24e-001"
	data   1, 0.000000000125,                "#.##e-0",          "1.25e-10"
	data   1, 0.999999,  "#.00e+000",        "1.00e+000"
	data  B1, 9.9e+20,   "#",                "990000000000000000000"
	data  B2, 4.9e-324,  "#.#e+#",           "4.9e-324"
	data  B1, 9.9e-100,  "###################e+#", "9900000000000000000e-118"

	data   1, -0.1236,   "##0.00%",          "-12.36%"
	data   1, -123,      !"\"asd\\\"",        !"asd\\"
	data   1, -0,        "###",              "0"
	data   1, -123,      "###",              "-123"
	data   1, -123,      "###00000",         "-00123"
	data   1, -123,      "00000###",         "-00000123"
	data   1, -123.5,    "0",                "-123"
	data   1, -123.51,   "0",                "-124"
	data   1, -123.6,    "0",                "-124"
	data   1, -1.23,     "###.###",          "-1.23"
	data   1, -0.123,    "###.###",          "-.123"
	data   1, -0.1234,   "###.###",          "-.123"
	data   1, -0.1235,   "###.###",          "-.123"
	data   1, -0.12351,  "###.###",          "-.124"
	data   1, -0.1236,   "###.###",          "-.124"
	data   1, -123,      "###.###",          "-123."
	data   1, -123,      "#",                "-123"
	data   1, -123,      "#.##e-000",        "-1.23e002"
	data   1, -123,      "#.##e+000",        "-1.23e+002"
	data   1, -0.123,    "#.##e-000",        "-1.23e-001"
	data   1, -0.1234,   "#.##e-000",        "-1.23e-001"
	data   1, -0.1235,   "#.##e-000",        "-1.23e-001"
	data   1, -0.12351,  "#.##e-000",        "-1.24e-001"
	data   1, -0.1236,   "#.##e-000",        "-1.24e-001"
	data   1, -0.000000000125,               "#.##e-0",          "-1.25e-10"
	data   1, -0.999999, "#.00e+000",        "-1.00e+000"
	data  B1, -9.9e+20,  "#",                "-990000000000000000000"
	data  B2, -4.9e-324, "#.#e+#",           "-4.9e-324"
	data  B1, -9.9e-100, "###################e+#", "-9900000000000000000e-118"

	data   1, -0.1236,   "##0.00%-",         "12.36%-"
	data   1, -123,      !"\"asd\\\"",        !"asd\\"
	data   1, -0,        "###-",             "0"
	data   1, -123,      "###-",             "123-"
	data   1, -123,      "###00000-",        "00123-"
	data   1, -123,      "00000###-",        "00000123-"
	data   1, -123.5,    "0-",               "123-"
	data   1, -123.51,   "0-",               "124-"
	data   1, -123.6,    "0-",               "124-"
	data   1, -1.23,     "###.###-",         "1.23-"
	data   1, -0.123,    "###.###-",         ".123-"
	data   1, -0.1234,   "###.###-",         ".123-"
	data   1, -0.1235,   "###.###-",         ".123-"
	data   1, -0.12351,  "###.###-",         ".124-"
	data   1, -0.1236,   "###.###-",         ".124-"
	data   1, -123,      "###.###-",         "123.-"
	data   1, -123,      "#-",               "123-"
	data   1, -123,      "#.##e-000-",       "1.23e002-"
	data   1, -123,      "#.##e+000-",       "1.23e+002-"
	data   1, -0.123,    "#.##e-000-",       "1.23e-001-"
	data   1, -0.1234,   "#.##e-000-",       "1.23e-001-"
	data   1, -0.1235,   "#.##e-000-",       "1.23e-001-"
	data   1, -0.12351,  "#.##e-000-",       "1.24e-001-"
	data   1, -0.1236,   "#.##e-000-",       "1.24e-001-"
	data   1, -0.000000000125,               "#.##e-0-",          "1.25e-10-"
	data   1, -0.999999, "#.00e+000-",       "1.00e+000-"
	data  B1, -9.9e+20,  "#-",               "990000000000000000000-"
	data  B2, -4.9e-324, "#.#e+#-",          "4.9e-324-"
	data  B1, -9.9e-100, "###################e+#-", "9900000000000000000e-118-"

	data   1, 0.1236,    "##0.00%-",         "12.36%"
	data   1, 123,       !"\"asd\\\"",        !"asd\\"
	data   1, 0,         "###-",             "0"
	data   1, 123,       "###-",             "123"
	data   1, 123,       "###00000-",        "00123"
	data   1, 123,       "00000###-",        "00000123"
	data   1, 123.5,     "0-",               "123"
	data   1, 123.51,    "0-",               "124"
	data   1, 123.6,     "0-",               "124"
	data   1, 1.23,      "###.###-",         "1.23"
	data   1, 0.123,     "###.###-",         ".123"
	data   1, 0.1234,    "###.###-",         ".123"
	data   1, 0.1235,    "###.###-",         ".123"
	data   1, 0.12351,   "###.###-",         ".124"
	data   1, 0.1236,    "###.###-",         ".124"
	data   1, 123,       "###.###-",         "123."
	data   1, 123,       "#-",               "123"
	data   1, 123,       "#.##e-000-",       "1.23e002"
	data   1, 123,       "#.##e+000-",       "1.23e+002"
	data   1, 0.123,     "#.##e-000-",       "1.23e-001"
	data   1, 0.1234,    "#.##e-000-",       "1.23e-001"
	data   1, 0.1235,    "#.##e-000-",       "1.23e-001"
	data   1, 0.12351,   "#.##e-000-",       "1.24e-001"
	data   1, 0.1236,    "#.##e-000-",       "1.24e-001"
	data   1, 0.000000000125,                "#.##e-0-",          "1.25e-10"
	data   1, 0.999999,  "#.00e+000-",       "1.00e+000"
	data  B1, 9.9e+20,   "#-",               "990000000000000000000"
	data  B2, 4.9e-324,  "#.#e+#-",          "4.9e-324"
	data  B1, 9.9e-100, "###################e+#-", "9900000000000000000e-118"

	data   1, 1234,      "###,0.00",         "1,234.00"
	data   1, 1234567,   "#,#,#,0.00",       "1,234,567.00"
	data   1, 1234,      "###,,0.00",        "0.00"
	data   1, 1234567,   "###,,0.00",        "1.23"
	data   1, 1234567,   "###0,,.00",        "1.23"
	data   1, 1234,      "###0,.00",         "1.23"
	data   1, 1234,      "#########,0.00",   "1,234.00"
	data   1, 123456,    "#######,##0.00",   "123,456.00"
	data   1, 12345678, 	"#######,##0.00",   "12,345,678.00"
	data   1, 123,       "#########,0.00",   "123.00"
	data   1, 100000,    "#,##0.00",         "100,000.00"

	data   1, "."

tests_dt:
    data "Jun 1, 2005",       "yyyy-mm-dd",       "2005-06-01"
    data "Jun 1, 2005",       "yyyy-MM-dd",       "2005-06-01"
    data "Jun 1, 2005",       "yy-MM-dd",         "05-06-01"
    data "Jun 1, 2005",       "yy-M-dd",          "05-6-01"
    data "Jun 1, 2005",       "yy-M-d",           "05-6-1"
    data "Dec 1, 2005",       "yy-M-d",           "05-12-1"
    data "Dec 10, 2005",      "yy-M-d",           "05-12-10"
    data "13:14:15",          "hh:nn:ss",         "13:14:15"
    data "13:14:15",          "nn:ss",            "14:15"
    data "13:14:15",          "hh:mm:ss",         "13:14:15"
    data "13:14:15",          "hh:mm:ss AM/PM",   "01:14:15 PM"
    data "13:14:15",          "hh:mm:ss AM/pM",   "01:14:15 pM"
    data "13:14:15",          "hh:mm:ss A/p",     "01:14:15 p"
    data "01:14:15",          "hh:mm:ss A/p",     "01:14:15 A"
    data "00:14:15",          "hh:mm:ss A/p",     "12:14:15 A"
    data "12:14:15",          "hh:mm:ss A/p",     "12:14:15 p"
    data "Aug. 9, 2005",      "ddd dddd ddddd",   "Tue Tuesday 08/09/2005"
    data "."

declare sub fb_I18nSet alias "fb_I18nSet"( byval on_off as long )

SUITE( fbc_tests.string_.format_ )

	TEST( numberFormatTest )
		dim as string sValue, sMask, sWanted, sResult
		dim as double dblValue
		dim as integer bTest

		restore tests_num
		read bTest, sValue
		while sValue<>"."
			dblValue = val(sValue)
			read sMask, sWanted
	'        print sWanted,
			sResult = Format(dblValue, sMask)
	'        print sResult
		if( bTest ) then
				CU_ASSERT_EQUAL( sWanted, sResult )
			end if
			read bTest, sValue
		wend

	END_TEST

	TEST( dateFormatTest )
		dim as string sValue, sMask, sWanted, sResult
		dim as double dblValue

		restore tests_dt
		read sValue
		while sValue<>"."
			dblValue = datevalue(sValue) + timevalue(sValue)
			read sMask, sWanted
	'        print sWanted,
			sResult = Format(dblValue, sMask)
	'        print sResult
			CU_ASSERT_EQUAL( sWanted, sResult )
			read sValue
		wend

		CU_ASSERT( len( format(now(), "yyyy.mm.dd") ) > 0 )
	END_TEST

	SUITE_INIT
		' Turn off I18N and L10N
		fb_I18nSet 0
		return 0
	END_SUITE_INIT

	SUITE_CLEANUP
		' Turn on I18N and L10N
		fb_I18nSet 1
		return 0
	END_SUITE_CLEANUP


END_SUITE
