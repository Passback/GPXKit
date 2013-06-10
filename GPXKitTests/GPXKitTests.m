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

- (void)parserTest
{
//    STFail(@"Unit tests are not implemented yet in GPXKitTests");
    NSURL *file = [[NSURL alloc] initFileURLWithPath:@"/Users/kms/tmp.gpx"];
    
    GPXParser *gpxParser = [[GPXParser alloc] init];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:file];
    [parser setDelegate:gpxParser];
    
    [parser parse];
}

@end
