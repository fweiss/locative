//
//  PoiDetailController2.h
//  OverThere
//
//  Created by Frank Weiss on 6/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PoiAnnotation.h"


@interface PoiDetailController2 : UITableViewController <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray* fields;
    uint phoneFieldIndex;
}

- (void) setPoi: (PoiAnnotation*) poi;;

@end
