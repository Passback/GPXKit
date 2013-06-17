//
//  GPXParser.m
//  GPXKit
//
//  Created by Keith Sharp on 10/06/2013.
//  Copyright (c) 2013 Passback Consulting. All rights reserved.
//

#import "GPXParser.h"
#import "GPXWaypoint.h"
#import "GPXRoute.h"
#import "GPXTrack.h"

@interface GPXParser ()
{
    // Booleans to determine which element/attribute we are in when parsing
    BOOL inName;
    BOOL inTime;
    BOOL inEle;
    BOOL inWpt;
    BOOL inRte;
    BOOL inRtePt;
    BOOL inTrk;
    BOOL inTrkPt;
    
    // The results of the parsing are held internally as mutable arrays, but
    // returned as non-mutable arrays.
    NSMutableArray *_waypoints;
    NSMutableArray *_routes;
    NSMutableArray *_tracks;
    
    // Temp variables to hold waypoints, routes, and tracks, as we parse them
    GPXWaypoint *waypoint;
    GPXRoute *route;
    GPXTrack *track;
    
    // Formatter to parse ISO 8601 format timestamps
    NSDateFormatter *timeFormatter;
}
@end

@implementation GPXParser

- (id)init
{
    if (self = [super init]) {
        _waypoints = [[NSMutableArray alloc] init];
        _routes = [[NSMutableArray alloc] init];
        _tracks = [[NSMutableArray alloc] init];
        
        // Need to set the locale and timezone as GPX files are assumed to be
        // in UTC.  Applications should update to display in the users locale
        // as necessary.
        timeFormatter = [[NSDateFormatter alloc] init];
        [timeFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        [timeFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        [timeFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    }
    return self;
}

- (NSArray *)waypoints
{
    return (NSArray *)_waypoints;
}

- (NSArray *)routes
{
    return (NSArray *)_routes;
}

- (NSArray *)tracks
{
    return (NSArray *)_tracks;
}

- (BOOL)parseDocumentWithURL:(NSURL *)url
{
    if (url == nil) {
        return NO;
    }
    
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [xmlParser setDelegate:self];
    [xmlParser setShouldResolveExternalEntities:NO];
    
    return [xmlParser parse];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"wpt"]) {
        inWpt = YES;
        waypoint = [[GPXWaypoint alloc] init];
        NSString *lat = [attributeDict objectForKey:@"lat"];
        [waypoint setLatitude:[lat doubleValue]];
        NSString *lon = [attributeDict objectForKey:@"lon"];
        [waypoint setLongitude:[lon doubleValue]];
    } else if ([elementName isEqualToString:@"name"]) {
        inName = YES;
    } else if ([elementName isEqualToString:@"ele"]) {
        inEle = YES;
    } else if ([elementName isEqualToString:@"time"]) {
        inTime = YES;
    } else if ([elementName isEqualToString:@"rte"]) {
        inRte = YES;
        route = [[GPXRoute alloc] init];
    } else if ([elementName isEqualToString:@"rtept"]) {
        inRtePt = YES;
        waypoint = [[GPXWaypoint alloc] init];
        NSString *lat = [attributeDict objectForKey:@"lat"];
        [waypoint setLatitude:[lat doubleValue]];
        NSString *lon = [attributeDict objectForKey:@"lon"];
        [waypoint setLongitude:[lon doubleValue]];
    } else if ([elementName isEqualToString:@"trk"]) {
        inTrk = YES;
        track = [[GPXTrack alloc] init];
    } else if ([elementName isEqualToString:@"rtept"]) {
        inTrkPt = YES;
        waypoint = [[GPXWaypoint alloc] init];
        NSString *lat = [attributeDict objectForKey:@"lat"];
        [waypoint setLatitude:[lat doubleValue]];
        NSString *lon = [attributeDict objectForKey:@"lon"];
        [waypoint setLongitude:[lon doubleValue]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (inName && (inWpt || inRtePt || inTrkPt)) {
        [waypoint setName:string];
    } else if (inEle && (inWpt || inRtePt || inTrkPt)) {
        [waypoint setElevation:[string doubleValue]];
    } else if (inTime && (inWpt || inRtePt || inTrkPt)) {
        NSDate *time = [timeFormatter dateFromString:string];
        [waypoint setTime:time];
    } else if (inName && inRte) {
        [route setRouteName:string];
    } else if (inName && inTrk) {
        [route setRouteName:string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"wpt"]) {
        inWpt = NO;
        [_waypoints addObject:waypoint];
    } else if ([elementName isEqualToString:@"name"]) {
        inName = NO;
    } else if ([elementName isEqualToString:@"ele"]) {
        inEle = NO;
    } else if ([elementName isEqualToString:@"time"]) {
        inTime = NO;
    } else if ([elementName isEqualToString:@"rte"]) {
        inRte = NO;
        [_routes addObject:route];
    } else if ([elementName isEqualToString:@"rtept"]) {
        inRtePt = NO;
        [[route wayPoints] addObject:waypoint];
    } else if ([elementName isEqualToString:@"trk"]) {
        inTrk = NO;
        [_tracks addObject:track];
    } else if ([elementName isEqualToString:@"trkpt"]) {
        inTrkPt = NO;
        [[track trackPoints] addObject:waypoint];
    }
}

@end
