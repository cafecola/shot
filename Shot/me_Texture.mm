//
//  Texture.m
//  SkyAtWar
//
//  Created by 영호 천 on 09. 06. 05.
//  Copyright 2009 ... All rights reserved.
//

#import "me_Texture.h"

struct STextureContainer
{
	char filename[128];
	me_STexture Tex;
	
	int Count;
};

#define MAX_TEXTURECONTAINER 512
STextureContainer g_TextureContainer[MAX_TEXTURECONTAINER];

me_STexture me_CreateTexture(NSString *filename)
{
	return me_CreateTexture([filename UTF8String]);
}

me_STexture me_CreateTexture(const char *filename)
{
	int i;
	for(i=0;i<MAX_TEXTURECONTAINER;i++)
	{
		if(!strcmp(g_TextureContainer[i].filename, filename))
		{
			g_TextureContainer[i].Count++;
			return g_TextureContainer[i].Tex;
		}
	}
	
	CGImageRef spriteImage;
	CGContextRef spriteContext;
	GLubyte *spriteData;
	
	me_STexture tTex;
	
	NSString *fn = [[NSString alloc] initWithUTF8String: filename];
	spriteImage = [UIImage imageNamed:fn].CGImage;
	[fn release];
	
	tTex.Width = CGImageGetWidth(spriteImage);
	tTex.Height = CGImageGetHeight(spriteImage);
		
	if(spriteImage) 
	{
		spriteData = (GLubyte *) malloc(tTex.Width * tTex.Height * 4);
		memset(spriteData, 0, tTex.Width * tTex.Height * 4);
		spriteContext = CGBitmapContextCreate(spriteData, tTex.Width, tTex.Height, 8, tTex.Width * 4, 
											  CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast	);
		CGContextDrawImage(spriteContext, CGRectMake(0.0, 0.0, (CGFloat)tTex.Width, (CGFloat)tTex.Height), spriteImage);
		CGContextRelease(spriteContext);
		
		glGenTextures(1, &tTex.TexID);
		glBindTexture(GL_TEXTURE_2D, tTex.TexID);
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, tTex.Width, tTex.Height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
		free(spriteData);
		
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
		
		glEnable(GL_TEXTURE_2D);
	}
	
	for(i=0;i<MAX_TEXTURECONTAINER;i++)
	{
		if(g_TextureContainer[i].filename[0]==0)
		{
			strcpy(g_TextureContainer[i].filename, filename);
			g_TextureContainer[i].Tex = tTex;
			g_TextureContainer[i].Count = 1;
			break;
		}
	}
	
	return tTex;
}

void me_DeleteTexture(me_STexture Texture)
{
	if(Texture.TexID!=0)
	{
		int i;
		for(i=0;i<MAX_TEXTURECONTAINER;i++)
		{
			if(g_TextureContainer[i].Tex.TexID==Texture.TexID)
			{
				g_TextureContainer[i].Count--;
				if(g_TextureContainer[i].Count==0)
				{
					glDeleteTextures(1, &g_TextureContainer[i].Tex.TexID);
					g_TextureContainer[i].Tex.TexID=0;
				}
				
				break;
			}
		}
	}
}