//
//  MapController.h
//  OverThere
//
//  Created by Frank Weiss on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "PoiDetailController2.h"

@interface MapController : UIViewController <MKMapViewDelegate> {
    MKMapView* mapView;
    BOOL isZoomed;
    PoiDetailController2* detailController;
    MKCoordinateRegion defaultRegion;
    MKCoordinateRegion metroRegion;
    MKCoordinateRegion detailRegion;
}

- (void) topicChanged: (NSNotification*) notification;
- (void) gotoLocation;

@end
