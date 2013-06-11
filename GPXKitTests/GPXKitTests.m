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
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"SingleWaypoint" ofType:@"GPX"];
    NSURL *file = [[NSURL alloc] initFileURLWithPath:filePath];
    
    GPXParser *gpxParser = [[GPXParser alloc] init];
    if (![gpxParser parseDocumentWithURL:file])
    {
        // Highlight failure of somekind
    }
    
    // NSArray *waypoints = [gpxParser waypoints];
    // Test that array length is one
    // Test that name is correct
    // Test that lat is correct
    // Test that lon is correct
    // Test that alt is correct
}

@end
