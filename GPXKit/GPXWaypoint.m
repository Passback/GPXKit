//
//  GPXWaypoint.m
//  GPXKit
//
//  Created by Keith Sharp on 10/06/2013.
//  Copyright (c) 2013 Passback Consulting. All rights reserved.
//

#import "GPXWaypoint.h"

@implementation GPXWaypoint

@synthesize name = _name;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize elevation = _elevation;
@synthesize time = _time;

- (NSString *)description
{
    return [[NSString alloc] initWithFormat:@"%@, %f, %f", self.name, self.latitude, self.longitude];
}

@end
