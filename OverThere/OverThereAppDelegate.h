//
//  OverThereAppDelegate.h
//  OverThere
//
//  Created by Frank Weiss on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapController.h"
#import "TopicController.h"

@interface OverThereAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    MapController* mapController;
    TopicController* topicController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
