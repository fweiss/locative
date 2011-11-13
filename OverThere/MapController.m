//
//  MapController.m
//  OverThere
//
//  Created by Frank Weiss on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapController.h"
#import "PoiAnnotation.h"
#import "GeoRssFeedParser.h"

@interface MapController (private)
    - (void) setAnnotations: (NSArray*) annotations;
    - (void) downloadAnnotations;
@end

MKCoordinateRegion xMKCoordinateRegionMake(float f) {
    MKCoordinateRegion bb;
    return bb;
}

@implementation MapController

- (id) init {
    [super init];
    // center of US, try to include Alaska
    defaultRegion = (MKCoordinateRegion) { { 44.67137, -103.85215 }, { 27.0, 64 } };
    metroRegion = (MKCoordinateRegion) { { 37.762336, -122.435640 }, { 0.112872 / 2., 0.109863 / 2. } };
    detailRegion = (MKCoordinateRegion) { { 37.762336, -122.435640 }, { 0.112872 / 8., 0.109863 / 8. } };
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void) loadView {
    mapView = [[MKMapView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    mapView.mapType = MKMapTypeStandard;   // also MKMapTypeSatellite or MKMapTypeHybrid
    mapView.delegate = self;
    mapView.region = defaultRegion;

    detailController = [[PoiDetailController2 alloc] init];
    detailController.title = @"Detail";
    
    // create a custom navigation bar button and set it to always says "Back"
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    // FIXME: title is always "Back"
	temporaryBarButtonItem.title = @"Map";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];
       
    self.view = mapView;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
    return YES;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    //mapView.frame = self.view.frame;
}

#pragma mark - main class methods

- (void ) gotoLocation {
    // start off by default in San Francisco
    if ( ! isZoomed) { // FIXME: check for rectangle intersection
        [mapView setRegion: detailRegion animated:YES];
        isZoomed = YES;
    }
}

- (void) setAnnotations: (NSArray*) annotations {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self gotoLocation];
    [mapView removeAnnotations: [mapView annotations]];
    [mapView addAnnotations: annotations];
}

- (void) getAnnotations: (NSData*) data {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    GeoRssFeedParser* parser = [GeoRssFeedParser alloc];
    NSArray* pois = [parser getPointsOfInterestForTopic: (NSString*) data];
    [self performSelectorOnMainThread:@selector(setAnnotations:) withObject:pois waitUntilDone:NO];
	[pool release];
}

#pragma mark - MKMapViewDelegate implementation

/**
 * Get an annotation view object for the given annotation. The annotation view is obtained from 
 * a pool maintained by the map view, or created if the pool is empty.
 *
 * A detail disclosure button is added to the annotation view as a right callout accessory.
 */
- (MKAnnotationView*) mapView: (MKMapView*) mv viewForAnnotation: (id<MKAnnotation>) annotation {
    static NSString* PoiAnnotationIdentifier = @"poiAnnotation";
    MKPinAnnotationView* pinView = (MKPinAnnotationView*) [mapView dequeueReusableAnnotationViewWithIdentifier:PoiAnnotationIdentifier];
    if (pinView) {
        pinView.annotation = annotation;  
        return pinView;
    } else {
		// if an existing pin view was not available, create one
		MKPinAnnotationView* annotationView = [[[MKPinAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: PoiAnnotationIdentifier] autorelease];
		annotationView.pinColor = MKPinAnnotationColorPurple;
		annotationView.animatesDrop = YES;
		annotationView.canShowCallout = YES;
		
		// add a detail disclosure button to the callout which will open a new view controller page
		UIButton* rightButton = [UIButton buttonWithType:   UIButtonTypeDetailDisclosure];
		annotationView.rightCalloutAccessoryView = rightButton;
        return annotationView;
    }
}

- (void) mapView: (MKMapView*) mapView annotationView: (MKAnnotationView*)view calloutAccessoryControlTapped: (UIControl*) control {
    // the detail view does not want a toolbar so hide it
    [self.navigationController setToolbarHidden:YES animated:NO];
    PoiAnnotation* poi = view.annotation;
    [detailController setPoi:poi];
    self.navigationController.navigationBar.backItem.title = @"Map";
    [self.navigationController pushViewController: detailController animated:YES];
   
}

#pragma mark - notifications

- (void) topicChanged:(NSNotification *) notification {
    NSString* topicKey = [[notification userInfo] objectForKey: @"topicId"];
    [NSThread detachNewThreadSelector: @selector(getAnnotations:) toTarget: self withObject: topicKey];
}
@end
