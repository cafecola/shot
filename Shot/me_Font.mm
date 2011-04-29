//
//  me_font.m
//  math lib
//
//  Created by 영호 천 on 09. 06. 05.
//  Copyright 2009 ... All rights reserved.
//

#import "me_Font.h"

me_STexture g_FontTex;
float g_FontCharSize[27] = 
	{	0, 9, 20, 28, 38, 48, 57, 67, 77, 83, 92, 103, 111, 124, 
		134, 144, 154, 164, 174, 184, 194, 204, 214, 227, 238, 248, 255 };

float g_FontNumberSize[11] =
	{	0, 12, 20, 30, 40, 51, 61, 71, 81, 91, 101 };

void me_FontInit()
{	
	g_FontTex = me_CreateTexture(@"font.png");
	
	int i;
	for(i=0;i<27;i++)	g_FontCharSize[i]=g_FontCharSize[i]/256.0f;
	for(i=0;i<11;i++)	g_FontNumberSize[i]=g_FontNumberSize[i]/256.0f;
}


void me_PutChar(int x, int y, int sx, int sy, float u1, float v1, float u2, float v2)
{	
	GLfloat spriteVertices[] = {
		x,			y,		
		x,			y + sy,
		x + sx,		y,
		x + sx,		y + sy,
	};
		
	GLfloat spriteTexcoords[] = {
		u1, v1,
		u1, v2,
		u2, v1,
		u2, v2,
	};
	
	glBindTexture(GL_TEXTURE_2D, g_FontTex.TexID);
	
	// Sets up pointers and enables states needed for using vertex arrays and textures
	glVertexPointer(2, GL_FLOAT, 0, spriteVertices);
	glEnableClientState(GL_VERTEX_ARRAY);
	glTexCoordPointer(2, GL_FLOAT, 0, spriteTexcoords);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
}

void me_PutText(int x, int y, const char *Text, float r, float g, float b, float a)
{
	glColor4f(r,g,b,a);
	
	int i, n = strlen(Text);
	for(i=0;i<n;i++)
	{
		if(Text[i] == ' ')
		{
			x += 8;
			continue;
		}
		
		if(Text[i] >= 'A' && Text[i] <= 'Z')
		{
			int idx = Text[i]-'A';
			int Width = (g_FontCharSize[idx+1]-g_FontCharSize[idx])*256.0f;
			me_PutChar(x, y, Width, 16, g_FontCharSize[idx],  0.0f, g_FontCharSize[idx+1], 0.5f);
			x += Width;
			continue;
		}
		
		if(Text[i] >= '0' && Text[i] <= '9')
		{
			int idx = Text[i]-'0';
			int Width = (g_FontNumberSize[idx+1]-g_FontNumberSize[idx])*256.0f;
			me_PutChar(x, y, Width, 16, g_FontNumberSize[idx], 0.5f, g_FontNumberSize[idx+1],  1.0f);
			x += Width;
		}
	}
	
	glColor4f(1,1,1,1);
}