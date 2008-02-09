#ifndef __FBDOC_LOADER_SQL_BI__
#define __FBDOC_LOADER_SQL_BI__

''  fbdoc - FreeBASIC User's Manual Converter/Generator
''	Copyright (C) 2006-2008 The FreeBASIC development team.
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


namespace fb.fbdoc

	declare function Fetch_Pages_From_Database _
		( _
			byval db_host as zstring ptr, _
			byval db_user as zstring ptr, _
			byval db_pass as zstring ptr, _
			byval db_name as zstring ptr, _
			byval db_port as integer _
		) as integer

end namespace

#endif
