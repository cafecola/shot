//
//  game_bug.h
//  Shot
//
//  Created by moonyoung on 11. 4. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "me_math.h"
#import "me_Sprite.h"

struct SBug {
    int Valid;
    float Speed;
    
    vector2f Pos;
    vector2f TargetPos;
    vector2f SpawnPos;
    
    int CookieIndex;
    int TargetCookieIndex;
    float Angle;
    
    me_CSprite BugSpr;
};

#define MAX_BUG 32
extern SBug g_Bug[MAX_BUG];

void Bug_Init();
void Bug_Create(float x, float y);
void Bug_Kill(int index);
void Bug_FrameMove();
void Bug_Render();

