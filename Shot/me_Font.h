//
//  font.h
//  font lib
//
//  Created by 영호 천 on 09. 06. 05.
//  Copyright 2009 ... All rights reserved.
//

//#import <Cocoa/Cocoa.h>
#import <UIKit/UIKit.h>
#include "me_Texture.h"

void me_FontInit();
void me_PutText(int x, int y, const char *Text, float r=1, float g=1, float b=1, float a=1);