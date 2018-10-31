/* chdir function */

#include "fb.h"
#if defined(HOST_MINGW) || defined(HOST_MSVC)
#include <direct.h>
#else
#include <unistd.h>
#endif

FBCALL int fb_ChDir( FBSTRING *path )
{
	int res;

#if defined(HOST_MINGW) || defined(HOST_MSVC)
	res = _chdir( path->data );
#else
	res = chdir( path->data );
#endif

	/* del if temp */
	fb_hStrDelTemp( path );

	return res;
}
