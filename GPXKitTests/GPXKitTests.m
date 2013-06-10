//
//  GPXKitTests.m
//  GPXKitTests
//
//  Created by Keith Sharp on 10/06/2013.
//  Copyright (c) 2013 Passback Consulting. All rights reserved.
//

#import "GPXKitTests.h"
#import "GPXParser.h"

@implementation GPXKitTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)parserSingleWaypoint
{
    // FIXME - how to refer to a file within this bundle?
    NSURL *file = [[NSURL alloc] initFileURLWithPath:@"/Users/kms/SingleWaypoint.gpx"];
    
    GPXParser *gpxParser = [[GPXParser alloc] init];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:file];
    [parser setDelegate:gpxParser];
    
    [parser parse];
    
    NSArray *waypoints = [gpxParser waypoints];
    // Test that array length is one
    // Test that name is correct
    // Test that lat is correct
    // Test that lon is correct
    // Test that alt is correct
}

@end
