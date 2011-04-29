#pragma once
//#import <Cocoa/Cocoa.h>
#import <UIKit/UIKit.h>
#import <audiotoolbox/audioservices.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

SystemSoundID me_CreateSound(const char *filename);
void me_PlaySound(SystemSoundID sID);
void me_DeleteSound(SystemSoundID sID);