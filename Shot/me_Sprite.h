#pragma once

//#import <Cocoa/Cocoa.h>
#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

#import "me_Texture.h"

void me_PutSpr(int x, int y, me_STexture tex, float angle=0.0f, float scalex=1.0f, float scaley=1.0f);

struct me_SSpriteKey
{
	float time;
	float r, g, b, a;
	float scalex, scaley;
	float angle;
	float x, y;
	
	int resettimer;
	
	me_STexture Tex;
	
	me_SSpriteKey()
	{
		clear();
	}
	
	void clear()
	{
		time = -1;
		resettimer = 0;
		
		r = g = b = a = 1.0f;
		scalex = scaley = 1.0f;
		x = y = 0;
		angle = 0;
	}
};

#define MAX_SPRITEKEY	16
class me_CSprite
{
protected:
	float m_currentTime;
	float m_prevTime;
	
	me_SSpriteKey m_currentKey;
	
	int m_currentKeyIdx;
	int m_nextKeyIdx;
	
	int m_keyCount;
	me_SSpriteKey m_Key[MAX_SPRITEKEY];
	
public:
	void Load(const char *filename);
	
	void FrameMove();
	void Render(int x, int y, float angle=0, float scale=1);
	
	void Reset();
	
	me_CSprite();
	~me_CSprite();	
};