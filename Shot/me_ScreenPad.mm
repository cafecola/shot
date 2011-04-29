#import "me_ScreenPad.h"
#import "me_Sprite.h"


me_CScreenPad g_ScreenPad;

void me_CScreenPad::Init()
{
	m_PadTex = me_CreateTexture(@"ScreenPadAnalog.png");
	m_ButtonTex = me_CreateTexture(@"ScreenPadButton.png");
}

int me_CScreenPad::AddPad(int Type, int x, int y)
{
	int i;
	for(i=0;i<MAX_SCREENPAD;i++)
	{
		if(m_ScreenPad[i].Type==MEPT_NONE)
		{
			m_ScreenPad[i].Type = Type;
			m_ScreenPad[i].x = x;
			m_ScreenPad[i].y = y;
			
			return i;
		}
	}
	
	return -1;
}


void me_CScreenPad::Render()
{
	glPushMatrix();
	
	int i;
	for(i=0;i<MAX_SCREENPAD;i++)
	{
		switch(m_ScreenPad[i].Type)
		{
			case MEPT_ANALOG:
				me_PutSpr(m_ScreenPad[i].x, m_ScreenPad[i].y, m_PadTex);
				break;
				
			case MEPT_BUTTON:
				me_PutSpr(m_ScreenPad[i].x, m_ScreenPad[i].y, m_ButtonTex);
				break;
		}
	}
	
		
	glPopMatrix();
}

void me_CScreenPad::Check(float x, float y)
{
	int i;
	for(i=0;i<MAX_SCREENPAD;i++)
	{
		if(x>m_ScreenPad[i].x && x<m_ScreenPad[i].x+128 && 
		   y>m_ScreenPad[i].y && y<m_ScreenPad[i].y+128) {} else continue;
		
		m_ScreenPad[i].isOn = 0;
		vector2f tpos, cpos, delta;
		
		// 아날로그 일때
		if(m_ScreenPad[i].Type == MEPT_ANALOG)
		{
			tpos[0]=x; tpos[1]=y;	
			cpos[0]=m_ScreenPad[i].x+64; 
			cpos[1]=m_ScreenPad[i].y+64;
			
			vec2sub(delta, tpos, cpos);
			float length = vec2length(delta);
			
			if(length>0.0f && length<=92)
			{
				vec2copy(m_ScreenPad[i].Delta, delta);
				vec2normalize(m_ScreenPad[i].Delta);
				m_ScreenPad[i].isOn=1;
				
				m_ScreenPad[i].Angle = GetAngle(cpos, tpos);
			}
		}
		
		// 버튼일떄
		if(m_ScreenPad[i].Type == MEPT_BUTTON)
		{
			tpos[0]=x; tpos[1]=y;	
			cpos[0]=m_ScreenPad[i].x+32; 
			cpos[1]=m_ScreenPad[i].y+32;
			
			vec2sub(delta, tpos, cpos);
			float length = vec2length(delta);
			
			if(length>0.0f && length<=54)
			{
				m_ScreenPad[i].isOn=1;				
			}			
		}
	}
}

void me_CScreenPad::Stop(float x, float y)
{
	int i;
	for(i=0;i<MAX_SCREENPAD;i++)
	{
		switch(m_ScreenPad[i].Type)
		{
			case MEPT_ANALOG:
				if(x>m_ScreenPad[i].x && x<m_ScreenPad[i].x+128 && y>m_ScreenPad[i].y && y<m_ScreenPad[i].y+128)
				{
					m_ScreenPad[i].isOn = 0;
				}
				break;
				
			case MEPT_BUTTON:
				if(x>m_ScreenPad[i].x && x<m_ScreenPad[i].x+64 && y>m_ScreenPad[i].y && y<m_ScreenPad[i].y+64)
				{
					m_ScreenPad[i].isOn = 0;
				}
				break;
		}
	}
}
