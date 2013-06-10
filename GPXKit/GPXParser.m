//
//  GPXParser.m
//  GPXKit
//
//  Created by Keith Sharp on 10/06/2013.
//  Copyright (c) 2013 Passback Consulting. All rights reserved.
//

#import "GPXParser.h"

@interface GPXParser ()
{
    BOOL inRte;
    BOOL inName;
    BOOL inRtePt;
}
@end

@implementation GPXParser

@synthesize waypoints = _waypoints;
@synthesize routes = _routes;
@synthesize tracks = _tracks;

- (id)init
{
    if (self = [super init]) {
        _routes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
}

@end
