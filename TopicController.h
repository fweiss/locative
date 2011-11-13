//
//  TopicController.h
//  OverThere
//
//  Created by Frank Weiss on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TopicController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
    NSArray* topics;
}

@property (nonatomic, retain) NSArray* topics;

@end
