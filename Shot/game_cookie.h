//
//  game_cookie.h
//  Shot
//
//  Created by moonyoung on 11. 4. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "me_math.h"

struct SCookie
{
    int Type;
    vector2f pos;
    int BugFlage;
    
};

#define MAX_COOKIE 20

extern SCookie g_Cookie[MAX_COOKIE];

void Cookie_Init();
void Cookie_Render();