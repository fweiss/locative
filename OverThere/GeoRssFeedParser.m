//
//  GeoRssFeedParser.m
//  MapCallouts
//
//  Created by Frank Weiss on 7/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GeoRssFeedParser.h"

@interface GeoRssFeedParser (private)
    - (void) parsePoint: (NSString*) text;
@end


@implementation GeoRssFeedParser

@synthesize sb;
@synthesize pois;
@synthesize currentPoi;

- (NSArray*) getPointsOfInterestForTopic: (NSString*) topic {
	//NSURL* xmlURL = [NSURL URLWithString:@"http://www.castrosf.org/data/georss-8.xml"];
	NSURL* xmlURL = [NSURL URLWithString: [NSString stringWithFormat: @"http://www.castrosf.org/data/georss-%@.xml", topic]];
	NSXMLParser* poiParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
	[poiParser setDelegate:self];
	self.sb = [NSMutableString string];
	self.pois = [NSMutableArray array];
	BOOL success = [poiParser parse];
	return pois;
}

- (void) parsePoint:(NSString *)text {
    NSScanner *scanner = [NSScanner scannerWithString:text];
    double latitude, longitude;
    if ([scanner scanDouble:&latitude]) {
        if ([scanner scanDouble:&longitude]) {
            [currentPoi setLatitude: latitude];
            [currentPoi setLongitude: longitude];
        }
    }
}

#pragma mark - Implementation of NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceUri qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributes {
	if ([elementName isEqualToString:@"title"]) {
		self.currentPoi = [PoiAnnotation alloc];
	}
	[sb setString:@""];
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	[sb appendString:string];
}
- (void) parser: (NSXMLParser*) parser didEndElement: (NSString*) elementName namespaceURI: (NSString*) namespaceUri qualifiedName: (NSString*) qualifiedName {
	if ([elementName isEqualToString: @"title"]) {
		[currentPoi setTitle: [[NSString alloc] initWithString: sb]];
    } else if ([elementName isEqualToString: @"csf:streetAddress"]) {
        [currentPoi setSubtitle: [[NSString alloc] initWithString: sb]];
    } else if ([elementName isEqualToString: @"csf:phone"]) {
        currentPoi.phone = [[NSString alloc] initWithString: sb];
    } else if ([elementName isEqualToString: @"csf:hours"]) {
        currentPoi.hours = [[NSString alloc] initWithString: sb];
    } else if ([elementName isEqualToString: @"csf:specialties"]) {
        currentPoi.specialties = [[NSString alloc] initWithString: sb];
	} else if ([elementName isEqualToString: @"georss:point"]) {
        [self parsePoint: sb];
	} else if ([elementName isEqualToString: @"entry"]) {
		[pois addObject:currentPoi];
	}
}

@end
