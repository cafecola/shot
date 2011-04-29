#import "me_Sound.h"
#import "me_Common.h"

SystemSoundID me_CreateSound(const char *filename)
{
	SystemSoundID sID;
	
	const char *path = me_GetBundlePath(filename, 0);
	NSString *dir = [[NSString alloc] initWithUTF8String: path];
	
	CFURLRef sndURL = (CFURLRef)[[NSURL alloc] initFileURLWithPath:dir];
	AudioServicesCreateSystemSoundID(sndURL, &sID);	
	
	return sID;	
}

void me_PlaySound(SystemSoundID sID)
{
	AudioServicesPlaySystemSound(sID);
}

void me_DeleteSound(SystemSoundID sID)
{
	AudioServicesDisposeSystemSoundID(sID);
}