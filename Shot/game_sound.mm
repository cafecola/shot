//
//  game_sound.mm
//  Shot
//
//  Created by moonyoung kim on 11. 5. 8..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "game_sound.h"
#import "me_Sound.h"

SystemSoundID g_SoundID[SID_MAX];

void Sound_Init() {
    g_SoundID[SID_HIT] = me_CreateSound("hit.wav");
}

void Sound_Play(int ID) {
    me_PlaySound(g_SoundID[ID]);
}