#import "me_Timer.h"

float me_gElapsedTime=0;
CFTimeInterval me_gOldTime=0;

float me_GetElapsedTime()
{
	return me_gElapsedTime;
}

void me_Update()
{
	// 프레임이 흘러간 시간 계산
	CFTimeInterval time = CFAbsoluteTimeGetCurrent();
	me_gElapsedTime = (float)(time - me_gOldTime);
	me_gOldTime = time;	
}