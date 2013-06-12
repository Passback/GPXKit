//
//  GPXKitTests.m
//  GPXKitTests
//
//  Created by Keith Sharp on 10/06/2013.
//  Copyright (c) 2013 Passback Consulting. All rights reserved.
//

#import "GPXKitTests.h"
#import "GPXParser.h"
#import "GPXWaypoint.h"

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

- (void)testParseSingleWaypoint
{
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"SingleWaypoint" ofType:@"GPX"];
    NSURL *file = [[NSURL alloc] initFileURLWithPath:filePath];
    
    GPXParser *gpxParser = [[GPXParser alloc] init];
    STAssertTrue([gpxParser parseDocumentWithURL:file], @"Parser failed to parse file: %@", filePath);
    
    // Test that array length is one
    NSArray *waypoints = [gpxParser waypoints];
    STAssertEquals([waypoints count], (NSUInteger)1, @"Waypoint array has %d member(s)", [waypoints count]);
    
    // Test the details of the waypoint
    GPXWaypoint *wpt = [waypoints lastObject];
    STAssertEqualObjects([wpt name], @"Apple Store Glasgow", @"Waypoint has name: %@", [wpt name]);
    STAssertEquals([wpt latitude], 55.861780, @"Waypoint has latitude: %f", [wpt latitude]);
    STAssertEquals([wpt longitude], -4.253628, @"Waypoint has longitude: %f", [wpt longitude]);
    STAssertEquals([wpt elevation], 29.0, @"Waypoint has elevation: %f", [wpt elevation]);
}

- (void)testParseTwoWaypoints
{
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"TwoWaypoints" ofType:@"GPX"];
    NSURL *file = [[NSURL alloc] initFileURLWithPath:filePath];
    
    GPXParser *gpxParser = [[GPXParser alloc] init];
    STAssertTrue([gpxParser parseDocumentWithURL:file], @"Parser failed to parse file: %@", filePath);
    
    // Test that array length is two
    NSArray *waypoints = [gpxParser waypoints];
    STAssertEquals([waypoints count], (NSUInteger)2, @"Waypoint array has %d member(s)", [waypoints count]);
    
    // Test details of first waypoint
    GPXWaypoint *wpt = [waypoints objectAtIndex:0];
    STAssertEqualObjects([wpt name], @"Apple Store Braehead", @"Waypoint has name: %@", [wpt name]);
    STAssertEquals([wpt latitude], 55.876766, @"Waypoint has latitude: %f", [wpt latitude]);
    STAssertEquals([wpt longitude], -4.365726, @"Waypoint has longitude: %f", [wpt longitude]);
    STAssertEquals([wpt elevation], 8.0, @"Waypoint has elevation: %f", [wpt elevation]);
    
    // Test details of second waypoint
    wpt = [waypoints objectAtIndex:1];
    STAssertEqualObjects([wpt name], @"Apple Store Glasgow", @"Waypoint has name: %@", [wpt name]);
    STAssertEquals([wpt latitude], 55.861780, @"Waypoint has latitude: %f", [wpt latitude]);
    STAssertEquals([wpt longitude], -4.253628, @"Waypoint has longitude: %f", [wpt longitude]);
    STAssertEquals([wpt elevation], 29.0, @"Waypoint has elevation: %f", [wpt elevation]);
}

@end
