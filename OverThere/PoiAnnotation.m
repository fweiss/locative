//
//  PoiAnnotation.m
//  OverThere
//
//  Created by Frank Weiss on 6/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PoiAnnotation.h"


@implementation PoiAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
@synthesize phone;
@synthesize hours;
@synthesize specialties;

- (id) init {
    coordinate.latitude = 0.0;
    coordinate.longitude = 0.0;
    return self;
}
- (void) setLatitude: (double) latitude {
    coordinate.latitude = latitude;
}
- (void) setLongitude: (double )longitude {
    coordinate.longitude = longitude;
}
@end
