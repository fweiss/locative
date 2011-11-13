//
//  PoiAnnotation.h
//  OverThere
//
//  Created by Frank Weiss on 6/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface PoiAnnotation : NSObject <MKAnnotation>  {
    CLLocationCoordinate2D coordinate;
    NSString* title;
    NSString* subtitle; // aka address
    NSString* phone;
    NSString* hours;
    NSString* specialties;
}

@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* subtitle;
@property (retain) NSString* phone;
@property (retain) NSString* hours;
@property (retain) NSString* specialties;

@property (nonatomic) CLLocationCoordinate2D coordinate;
    - (void) setLatitude: (double) latitude;
    - (void) setLongitude: (double) longitude;
@end

