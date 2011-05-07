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
#import "game_effect.h"
#import "game_sound.h"
#import "game_common.h"

SBug g_Bug[MAX_BUG];
int g_SearchIndex = 0;

struct SDeadBug {
    float rTime;
    vector2f Pos;
    float Angle;
    
    me_CSprite DeadBugSpr;
};

#pragma mark - 죽은 벌레.

#define MAX_DEADBUG 32
SDeadBug g_DeadBug[MAX_DEADBUG];

void DeadBug_Init() {
    int i;
    for (i=0; i<MAX_DEADBUG; i++) {
        g_DeadBug[i].DeadBugSpr.Load("bug_dead.spr");
        g_DeadBug[i].rTime = 0.0f;
    }
}

void DeadBug_Create(int x, int y, int angle) {
    int i;
    for (i=0; i<MAX_DEADBUG; i++) {
        if (g_DeadBug[i].rTime<=0) {
            g_DeadBug[i].Pos[0] = x;
            g_DeadBug[i].Pos[1] = y;
            g_DeadBug[i].Angle = angle;
            g_DeadBug[i].rTime = 5.5f;
            
            g_DeadBug[i].DeadBugSpr.Reset();
            break;
        }
    }
}

void DeadBug_FrameMove()
{
    int i;
    for (i=0; i<MAX_DEADBUG; i++) {
        if (g_DeadBug[i].rTime>0)
            g_DeadBug[i].rTime -= me_GetElapsedTime();
    }
}

void DeadBug_Render() {
    int i;
    for (i=0; i<MAX_DEADBUG; i++) {
        if (g_DeadBug[i].rTime>0) {
            g_DeadBug[i].DeadBugSpr.Render(g_DeadBug[i].Pos[0], g_DeadBug[i].Pos[1], g_DeadBug[i].Angle);
        }
    }
}

#pragma mark - 그냥 벌레.
void Bug_Init() {
    int i;
    for (i=0; i<MAX_BUG; i++) {
        g_Bug[i].BugSpr.Load("bug.spr");
    }
    
    DeadBug_Init();
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
    
    DeadBug_Create(g_Bug[index].Pos[0]-32, g_Bug[index].Pos[1]-32, g_Bug[index].Angle);
    Effect_Create(g_Bug[index].Pos[0]-32, g_Bug[index].Pos[1]-32);
    
    Sound_Play(SID_HIT);
    
    g_Score += 10;
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
                
                g_CookieCount --;
                
            } else {
                d[0] /= length;
                d[1] /= length;
                g_Bug[i].Pos[0] += (d[0] * g_Bug[i].Speed) * me_GetElapsedTime();
                g_Bug[i].Pos[1] += (d[1] * g_Bug[i].Speed) * me_GetElapsedTime();
                
                float org[2] = {0, 0};
                g_Bug[i].Angle = GetAngle(org, d);
            }
            
            continue;
        }
        
        if (g_Bug[i].TargetCookieIndex == -1) {
            int j;
            for (j=0; j<MAX_COOKIE; j++) {
                g_SearchIndex++;
                g_SearchIndex = g_SearchIndex % MAX_COOKIE;
                
                if (g_Cookie[g_SearchIndex].Type == -1) continue;
                
                if (g_Cookie[g_SearchIndex].BugFlage == 0) {
                    g_Bug[i].TargetCookieIndex = g_SearchIndex;
                    break;
                }
            }
        } else {
            if (g_Cookie[g_Bug[i].TargetCookieIndex].BugFlage==1) {
                g_Bug[i].TargetCookieIndex = -1;
                continue;
            }
            vec2copy(g_Bug[i].TargetPos, g_Cookie[g_Bug[i].TargetCookieIndex].pos);
            
            float d[2];
            vec2sub(d, g_Bug[i].TargetPos, g_Bug[i].Pos);
            float length = vec2length(d);
            
            if (length<3.0f) {
                g_Bug[i].CookieIndex = g_Bug[i].TargetCookieIndex;
                g_Bug[i].TargetCookieIndex = -1;
                g_Cookie[g_Bug[i].CookieIndex].BugFlage = 1;
            } else {
                vec2normalize(d);
                g_Bug[i].Pos[0] += (d[0] * g_Bug[i].Speed) * me_GetElapsedTime();
                g_Bug[i].Pos[1] += (d[1] * g_Bug[i].Speed) * me_GetElapsedTime();
                
                float org[2] = {0, 0};
                g_Bug[i].Angle = GetAngle(org, d);
            }
        }
    }
    
    DeadBug_FrameMove();
}

void Bug_Render() {
    int i;
    for (i=0; i<MAX_BUG; i++) {
        if (g_Bug[i].Valid == 0) continue;
        
        g_Bug[i].BugSpr.Render(g_Bug[i].Pos[0]-32, g_Bug[i].Pos[1]-32, g_Bug[i].Angle);
    }
    
    DeadBug_Render();
}

void Bug_Check(int x, int y) {
    int i;
    vector2f p, d;
    float length;
    
    for (i=0; i<MAX_BUG; i++) {
        if (g_Bug[i].Valid == 0) continue;
        
        p[0] = x;
        p[1] = y;
        
        vec2sub(d, g_Bug[i].Pos, p);
        length = vec2length(d);
        
        if (length < 32) {
            Bug_Kill(i);
        }
    }
}









