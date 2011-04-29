#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

#import "me_math.h"
#import "me_Texture.h"

enum
{
	MEPT_NONE,
	MEPT_ANALOG,
	MEPT_BUTTON
};

struct me_SScreenPad
{
	int Type;
	int x, y;
	
	float Angle;
	
	int isOn;
	
	vector2f Delta;
	
	me_SScreenPad()
	{
		Type = MEPT_NONE;
	}
};

#define MAX_SCREENPAD 4
class me_CScreenPad
{
protected:
	me_STexture m_PadTex;
	me_STexture m_ButtonTex;
	
	me_SScreenPad m_ScreenPad[MAX_SCREENPAD];
	
public:
	void Init();
	
	int AddPad(int Type, int x, int y);
		
	void Render();
	
	me_SScreenPad GetPadInfo(int Idx) { return m_ScreenPad[Idx]; }
		
	void Check(float x, float y);
	void Stop(float x, float y);
};

extern me_CScreenPad g_ScreenPad;