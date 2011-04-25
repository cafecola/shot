//
//  ShotAppDelegate.h
//  Shot
//
//  Created by moonyoung on 11. 4. 25..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShotViewController;

@interface ShotAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet ShotViewController *viewController;

@end
