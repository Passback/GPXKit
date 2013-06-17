//
//  GPXTrack.m
//  GPXKit
//
//  Created by Keith Sharp on 17/06/2013.
//  Copyright (c) 2013 Passback Consulting. All rights reserved.
//

#import "GPXTrack.h"

@implementation GPXTrack

@synthesize trackPoints = _trackPoints;
@synthesize trackName = _trackName;

- (id)init
{
    if (self = [super init]) {
        _trackPoints = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)description
{
    return [[NSString alloc] initWithFormat:@"%@ has %ld trackpoints", self.trackName, [self.trackPoints count]];
}

@end
