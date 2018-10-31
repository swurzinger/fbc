/* rmdir function */

#include "fb.h"
#if defined(HOST_MINGW) || defined(HOST_MSVC)
#include <direct.h>
#else
#include <unistd.h>
#endif

/*:::::*/
FBCALL int fb_RmDir( FBSTRING *path )
{
	int res;

#if defined(HOST_MINGW) || defined(HOST_MSVC)
	res = _rmdir( path->data );
#else
	res = rmdir( path->data );
#endif

	/* del if temp */
	fb_hStrDelTemp( path );

	return res;
}
