/* fix function for singles and doubles FIX( x ) = SGN( x ) * INT( ABS( x ) ) */

#include "fb.h"

#ifdef HOST_MSVC
#include <math.h>
#pragma intrinsic(floorf, fabsf, floor, fabs)
#define __builtin_floorf floorf
#define __builtin_fabsf fabsf
#define __builtin_floor floor
#define __builtin_fabs fabs
#endif


/*:::::*/
FBCALL float fb_FIXSingle( float x )
{
	return __builtin_floorf( __builtin_fabsf( x ) ) * fb_SGNSingle( x );
}

/*:::::*/
FBCALL double fb_FIXDouble( double x )
{
	return __builtin_floor( __builtin_fabs( x ) ) * fb_SGNDouble( x );
}
