#import "me_Sprite.h"
#import "me_Common.h"
#import "me_Timer.h"

const GLfloat spriteTexcoords[] = {
	0, 0,
	1, 0,
	0, 1,
	1, 1,
};

void me_PutSpr(int x, int y, me_STexture tex, float angle, float scalex, float scaley)
{
	glPushMatrix();
	
	glTranslatef(x, y, 0);
	
	glTranslatef(tex.Width/2.0f, tex.Height/2.0f, 0);
	glRotatef(angle, 0, 0, 1);
	glScalef(scalex, scaley, 1);
	glTranslatef(-tex.Width/2.0f, -tex.Height/2.0f, 0);
	
	
	GLfloat spriteVertex[8] =
	{
		0,			0,
		tex.Width,	0,
		0,			tex.Height,
		tex.Width,	tex.Height
	};
	
	glBindTexture(GL_TEXTURE_2D, tex.TexID);
	
	glVertexPointer(2, GL_FLOAT, 0, spriteVertex);
	glEnableClientState(GL_VERTEX_ARRAY);
	glTexCoordPointer(2, GL_FLOAT, 0, spriteTexcoords);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);	
	
	glPopMatrix();
}


me_CSprite::me_CSprite()
{
	m_currentTime = 0.0f;
	m_prevTime = 0.0f;
	
	m_keyCount=0;
}

me_CSprite::~me_CSprite()
{
}

void me_CSprite::Load(const char *filename)
{
	const char *path = me_GetBundlePath(filename, 0);
	FILE *fp;
	fp = fopen(path, "rt");
	if(fp==NULL)
	{
		NSLog(@"CSprite::Load load fail.");
		return;
	}
	
	me_SSpriteKey tKey;
	m_keyCount=0;
	
	char Text[256];
	while(!feof(fp))
	{
		fscanf(fp, "%s", Text);
		
		if(!strcmp(Text, "texture"))
		{
			fscanf(fp, "%s", Text);
			
			tKey.Tex = me_CreateTexture(Text);
			continue;
		}
		
		if(!strcmp(Text, "addkey"))
		{
			fscanf(fp, "%f", &tKey.time);
			
			if(m_keyCount<MAX_SPRITEKEY)
			{
				m_Key[m_keyCount]=tKey;
				m_keyCount++;
				
				tKey.clear();
			}
			
			continue;
		}
		
		if(!strcmp(Text, "color"))
		{
			fscanf(fp, "%f %f %f %f", &tKey.r, &tKey.g, &tKey.b, &tKey.a);
			continue;
		}
		
		if(!strcmp(Text, "scale"))
		{
			fscanf(fp, "%f %f", &tKey.scalex, &tKey.scaley);
			continue;
		}
		
		if(!strcmp(Text, "angle"))
		{
			fscanf(fp, "%f", &tKey.angle);
			continue;
		}
		
		if(!strcmp(Text, "move"))
		{
			fscanf(fp, "%f %f", &tKey.x, &tKey.y);
			continue;
		}
		
		if(!strcmp(Text, "resettimer"))
		{
			tKey.resettimer = 1;
			continue;
		}
	}
	
	Reset();
	
	fclose(fp);	
}

void me_CSprite::Reset()
{
	m_currentTime = 0;
	m_currentKey = m_Key[0];
	
	m_currentKeyIdx = 0;
	if(m_keyCount>1)
		m_nextKeyIdx = 1;
	else
		m_nextKeyIdx = 0;
}

void me_CSprite::FrameMove()
{
	m_currentTime+= me_GetElapsedTime();
	
	int i;
	for(i=0;i<m_keyCount;i++)
	{
		if(m_prevTime < m_Key[i].time && m_currentTime >= m_Key[i].time)
		{
			m_currentKeyIdx = i;
			m_nextKeyIdx = i+1;
			
			if(m_nextKeyIdx >= m_keyCount)
			{
				m_nextKeyIdx = m_keyCount - 1;
			}
			
			if(m_Key[m_currentKeyIdx].resettimer)
			{
				Reset();
				return;
			}

			break;
		}
	}
	
	if(m_currentKeyIdx == m_nextKeyIdx)
	{
		m_currentKey = m_Key[m_currentKeyIdx];
	}
	else
	{
		float delta = m_Key[m_nextKeyIdx].time - m_Key[m_currentKeyIdx].time;
		float abTime = m_currentTime - m_Key[m_currentKeyIdx].time;
		
		float alpha = abTime / delta;
		float invalpha = 1.0f - alpha;
		
		m_currentKey.r = m_Key[m_nextKeyIdx].r * alpha + m_Key[m_currentKeyIdx].r * invalpha;
		m_currentKey.g = m_Key[m_nextKeyIdx].g * alpha + m_Key[m_currentKeyIdx].g * invalpha;
		m_currentKey.b = m_Key[m_nextKeyIdx].b * alpha + m_Key[m_currentKeyIdx].b * invalpha;
		m_currentKey.a = m_Key[m_nextKeyIdx].a * alpha + m_Key[m_currentKeyIdx].a * invalpha;
		
		m_currentKey.scalex = m_Key[m_nextKeyIdx].scalex * alpha + m_Key[m_currentKeyIdx].scalex * invalpha;
		m_currentKey.scaley = m_Key[m_nextKeyIdx].scaley * alpha + m_Key[m_currentKeyIdx].scaley * invalpha;
		m_currentKey.angle = m_Key[m_nextKeyIdx].angle * alpha + m_Key[m_currentKeyIdx].angle * invalpha;
		
		m_currentKey.x = m_Key[m_nextKeyIdx].x * alpha + m_Key[m_currentKeyIdx].x * invalpha;
		m_currentKey.y = m_Key[m_nextKeyIdx].y * alpha + m_Key[m_currentKeyIdx].y * invalpha;
		
		m_currentKey.Tex = m_Key[m_currentKeyIdx].Tex;
	}

	m_prevTime = m_currentTime;
}

void me_CSprite::Render(int x, int y, float angle, float scale)
{
	FrameMove();
	
	glColor4f(m_currentKey.r, m_currentKey.g, m_currentKey.b, m_currentKey.a);
	
	me_PutSpr(x + m_currentKey.x, y + m_currentKey.y, m_currentKey.Tex, 
			  m_currentKey.angle+angle, m_currentKey.scalex*scale, m_currentKey.scaley*scale);
	
	glColor4f(1, 1, 1, 1);
}
