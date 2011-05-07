//
//  game_effect.mm
//  Shot
//
//  Created by moonyoung kim on 11. 5. 8..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "game_effect.h"
#import "me_math.h"
#import "me_Sprite.h"
#import "me_Timer.h"

struct SEffect {
    float rTime;
    vector2f Pos;
    
    me_CSprite Spr;
};

#define MAX_EFFECT 10
SEffect g_Effect[MAX_EFFECT];

void Effect_Init() {
    int i;
    for (i=0; i<MAX_EFFECT; i++) {
        g_Effect[i].rTime = 0.0f;
        g_Effect[i].Spr.Load("hit.spr");
    }
}

void Effect_Create(float x, float y) {
    int i;
    for (i=0; i<MAX_EFFECT; i++) {
        if (g_Effect[i].rTime <= 0.0f) {
            
            g_Effect[i].Pos[0] = x;
            g_Effect[i].Pos[1] = y;
            g_Effect[i].Spr.Reset();
            g_Effect[i].rTime = 0.5f;
            
            break;
        }
    }
}

void Effect_FrameMove() {
    int i;
    for (i=0; i<MAX_EFFECT; i++) {
        if (g_Effect[i].rTime > 0.0f)
            g_Effect[i].rTime -= me_GetElapsedTime();
    }
}

void Effect_Render() {
    int i;
    for (i=0; i<MAX_EFFECT; i++) {
        if (g_Effect[i].rTime <= 0.0f) continue;
        g_Effect[i].Spr.Render(g_Effect[i].Pos[0], g_Effect[i].Pos[1]);
    }
}