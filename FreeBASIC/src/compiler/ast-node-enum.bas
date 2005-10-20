''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

'' AST enumeration nodes
'' l = NULL; r = NULL
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\ast.bi"

'':::::
function astNewENUM( byval value as integer, _
					 byval sym as FBSYMBOL ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = astNewNode( AST_NODECLASS_ENUM, IR_DATATYPE_ENUM, sym )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->val.int = value
	n->defined	= TRUE

end function

'':::::
function astLoadENUM( byval n as ASTNODE ptr ) as IRVREG ptr static

	if( ast.doemit ) then
		function = irAllocVRIMM( IR_DATATYPE_INTEGER, n->val.int )
	end if

end function

