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
#import "GPXRoute.h"
#import "GPXTrack.h"

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
    NSArray *waypoints = [gpxParser wayPoints];
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
    NSArray *waypoints = [gpxParser wayPoints];
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

- (void)testParseOneRoute
{
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"SingleRoute" ofType:@"GPX"];
    NSURL *file = [[NSURL alloc] initFileURLWithPath:filePath];
    
    GPXParser *gpxParser = [[GPXParser alloc] init];
    STAssertTrue([gpxParser parseDocumentWithURL:file], @"Parser failed to parse file: %@", filePath);
    
    // Test that number of routes is one
    NSArray *routes = [gpxParser routes];
    STAssertEquals([routes count], (NSUInteger)1, @"Routes array has %d member(s)", [routes count]);
    
    // Test that number of waypoints in the route is two
    GPXRoute *rte = [routes objectAtIndex:0];
    STAssertEquals([[rte wayPoints] count], (NSUInteger)2, @"Route has %d waypoints", [[rte wayPoints] count]);
    
    // Test name of route
    STAssertEqualObjects([rte routeName], @"Apple to Apple", @"Route has name %@", [rte routeName]);
}

- (void)testParseSingleTrack
{
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"SingleTrack" ofType:@"GPX"];
    NSURL *file = [[NSURL alloc] initFileURLWithPath:filePath];
    
    GPXParser *gpxParser = [[GPXParser alloc] init];
    STAssertTrue([gpxParser parseDocumentWithURL:file], @"Parser failed to parse file: %@", filePath);
    
    // Test that number of tracks is one
    NSArray *tracks = [gpxParser tracks];
    STAssertEquals([tracks count], (NSUInteger)1, @"Failed to create correct number of tracks");
    
    // Test that number of trackpoints in the track is five
    GPXTrack *trk = [tracks objectAtIndex:0];
    STAssertEquals([[trk trackPoints] count], (NSUInteger)5, @"Track has wrong number of trackpoints");
    
    // Test name of track
    STAssertEqualObjects([trk trackName], @"Track Snippet One", @"Track has wrong name");
}

- (void)testParseTwoTracks
{
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"TwoTracks" ofType:@"GPX"];
    NSURL *file = [[NSURL alloc] initFileURLWithPath:filePath];
    
    GPXParser *gpxParser = [[GPXParser alloc] init];
    STAssertTrue([gpxParser parseDocumentWithURL:file], @"Parser failed to parse file: %@", filePath);
    
    // Test that number of tracks is two
    NSArray *tracks = [gpxParser tracks];
    STAssertEquals([tracks count], (NSUInteger)2, @"Failed to create correct number of tracks");
    
    // Test track one
    GPXTrack *trk = [tracks objectAtIndex:0];
    STAssertEquals([[trk trackPoints] count], (NSUInteger)5, @"Track has wrong number of trackpoints");
    STAssertEqualObjects([trk trackName], @"Track Snippet One", @"Track has wrong name");
    
    // Test track two
    trk = [tracks objectAtIndex:1];
    STAssertEquals([[trk trackPoints] count], (NSUInteger)5, @"Track has wrong number of trackpoints");
    STAssertEqualObjects([trk trackName], @"Track Snippet Two", @"Track has wrong name");
}

- (void)testParseComplexFile
{
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Blackhouse Heights" ofType:@"GPX"];
    NSURL *file = [[NSURL alloc] initFileURLWithPath:filePath];
    
    GPXParser *gpxParser = [[GPXParser alloc] init];
    STAssertTrue([gpxParser parseDocumentWithURL:file], @"Parser failed to parse file: %@", filePath);
    
    // Test top level object parsing/creation
    STAssertEquals([[gpxParser wayPoints] count], (NSUInteger)11, @"Failed to create correct number of waypoints");
    STAssertEquals([[gpxParser routes] count], (NSUInteger)1, @"Failed to create correct number of routes");
    STAssertEquals([[gpxParser tracks] count], (NSUInteger)1, @"Failed to create correct number of tracks");
    
    // Test route object
    GPXRoute *rte = [[gpxParser routes] objectAtIndex:0];
    STAssertEquals([[rte wayPoints] count], (NSUInteger)14, @"Route has wrong number of waypoints");
    STAssertEqualObjects([rte routeName], @"Blackhouse Heights", @"Route has wrong name");
    
    // Test track object
    GPXTrack *trk = [[gpxParser tracks] objectAtIndex:0];
    STAssertEquals([[trk trackPoints] count], (NSUInteger)2155, @"Track has wrong number of trackpoints");
    STAssertEqualObjects([trk trackName], @"Blackhouse Heights", @"Route has wrong name");
}

@end
