#pragma once

//#import <Cocoa/Cocoa.h>
#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

struct me_STexture
{
	int Width, Height;
	GLuint TexID;
	
	me_STexture()
	{
		TexID = 0;
	}
};

me_STexture me_CreateTexture(NSString *filename);
me_STexture me_CreateTexture(const char *filename);
void me_DeleteTexture(me_STexture Texture);

