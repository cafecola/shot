//
//  game_bug.m
//  Shot
//
//  Created by moonyoung on 11. 4. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "game_bug.h"
#import "game_cookie.h"
#import "me_Timer.h"

SBug g_Bug[MAX_BUG];
int g_SearchIndex = 0;


void Bug_Init() {
    int i;
    for (i=0; i<MAX_BUG; i++) {
        g_Bug[i].BugSpr.Load("bug.spr");
    }
}

void Bug_Create(float x, float y) {
    int i;
    for (i=0; i<MAX_BUG; i++) {
        if (g_Bug[i].Valid == 0) {
            g_Bug[i].Valid = 1;
            g_Bug[i].Pos[0] = x;
            g_Bug[i].Pos[1] = y;
            g_Bug[i].SpawnPos[0] = x;
            g_Bug[i].SpawnPos[1] = y;
            g_Bug[i].Speed = (1.0f + (float)(rand()%10) / 20.0f) / 0.016f;
            
            g_Bug[i].CookieIndex = -1;
            g_Bug[i].TargetCookieIndex = -1;
            
            return;
        }
    }
}

void Bug_Kill(int index) {
    if (g_Bug[index].CookieIndex != -1) {
        g_Cookie[g_Bug[index].CookieIndex].BugFlage = 0;
        g_Bug[index].CookieIndex = -1;
        g_Bug[index].TargetCookieIndex = -1;
    }
    g_Bug[index].Valid = 0;
}

void Bug_FrameMove() {
    int i;
    for (i=0; i<MAX_BUG; i++) {
        if (g_Bug[i].Valid == 0) continue;
        
        if (g_Bug[i].CookieIndex != -1) {
            float d[2];
            vec2sub(d, g_Bug[i].SpawnPos, g_Bug[i].Pos);
            
            vec2copy(g_Cookie[g_Bug[i].CookieIndex].pos, g_Bug[i].Pos);
            
            float length = vec2length(d);
            if (length < 3.0f) {
                g_Cookie[g_Bug[i].CookieIndex].Type = -1;
                g_Bug[i].Valid = 0;
            } else {
                d[0] /= length;
                d[1] /= length;
                g_Bug[i].Pos[0] += (d[0] * g_Bug[i].Speed) * me_GetElapsedTime();
                g_Bug[i].Pos[1] += (d[0] * g_Bug[i].Speed) * me_GetElapsedTime();
                
                float org[2] = {0, 0};
                g_Bug[i].Angle = GetAngle(org, d);
            }
            
            continue;
        }
    }
}