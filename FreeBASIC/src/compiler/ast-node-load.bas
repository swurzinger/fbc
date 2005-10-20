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

'' AST loading nodes
'' l = expression to load to a register; r = NULL
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\ast.bi"

'':::::
function astNewLOAD( byval l as ASTNODE ptr, _
					 byval dtype as integer, _
					 byval isresult as integer ) as ASTNODE ptr static
    dim n as ASTNODE ptr

	'' alloc new node
	n = astNewNode( AST_NODECLASS_LOAD, dtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->l  = l
	n->lod.isres = isresult

end function

'':::::
function astLoadLOAD( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr l
    dim as IRVREG ptr v1, vr

	l = n->l
	if( l = NULL ) then
		return NULL
	end if

	v1 = astLoad( l )

	if( ast.doemit ) then
		if( n->lod.isres ) then
			vr = irAllocVREG( irGetVRDataType( v1 ) )
			irEmitLOADRES( v1, vr )
		else
			irEmitLOAD( v1 )
		end if
	end if

	astDel( l )

	function = v1

end function

