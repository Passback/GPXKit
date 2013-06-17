//
//  GPXRoute.m
//  GPXKit
//
//  Created by Keith Sharp on 10/06/2013.
//  Copyright (c) 2013 Passback Consulting. All rights reserved.
//

#import "GPXRoute.h"

@implementation GPXRoute

@synthesize wayPoints = _wayPoints;
@synthesize routeName = _routeName;

- (id)init
{
    if (self = [super init]) {
        _wayPoints = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
