//
//  game_cookie.m
//  Shot
//
//  Created by moonyoung on 11. 4. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "game_cookie.h"
#import "me_Sprite.h"

SCookie g_Cookie[MAX_COOKIE];

me_STexture g_CookieTex[3];


void Cookie_Init() {
    int i;
    for (i=0; i<MAX_COOKIE; i++) {
        g_Cookie[i].pos[0] = rand()%196 + 142;
        g_Cookie[i].pos[1] = rand()%24 + 148;
        
        g_Cookie[i].Type = rand()%3;
        g_Cookie[i].BugFlage = 0;
    }
    
    g_CookieTex[0] = me_CreateTexture(@"cookie01.png");
    g_CookieTex[1] = me_CreateTexture(@"cookie02.png");
    g_CookieTex[2] = me_CreateTexture(@"cookie03.png");
}

void Cookie_Render() {
    int i;
    for (i=0; i<MAX_COOKIE; i++) {
        if (g_Cookie[i].Type == -1)
            continue;
        me_PutSpr(g_Cookie[i].pos[0]-32, g_Cookie[i].pos[1]-32, g_CookieTex[g_Cookie[i].Type]);
    }
}