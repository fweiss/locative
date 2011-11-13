//
//  GeoRssFeedParser.h
//  MapCallouts
//
//  Created by Frank Weiss on 7/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PoiAnnotation.h"


@interface GeoRssFeedParser : NSObject <NSXMLParserDelegate> {
	NSMutableString* sb;
	NSMutableArray* pois;
	PoiAnnotation* currentPoi;
}
@property (nonatomic, retain) NSMutableString* sb;
@property (nonatomic, retain) NSMutableArray* pois;
@property (nonatomic, retain) PoiAnnotation* currentPoi;
- (NSArray*) getPointsOfInterestForTopic: (NSString*) topic;;

@end
