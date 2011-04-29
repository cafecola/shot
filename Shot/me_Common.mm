#import "me_common.h"

const char *me_GetBundlePath(const char *s, const char *directory)
{
	NSString *dir = nil;
	if (directory)
		dir = [[NSString alloc] initWithUTF8String: directory];
	NSString *name = [[NSString alloc] initWithUTF8String: s];
	NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil inDirectory:dir];
	
	return [path UTF8String];
	
}