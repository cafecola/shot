//
//  MyTexture.h
//  Shot
//
//  Created by moonyoung on 11. 4. 25..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <OpenGlES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

struct sMyTexture {
    int Width, height;
    GLuint TexID;
    
    sMyTexture() {
        TexID = 0;
    }
};

sMyTexture MyCreateTexture(char *filename);
sMyTexture MyCreateTexture(NSString *filename);
void MyDeleteTexture(sMyTexture texture);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  