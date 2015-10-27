//
//  WACoordinates.m
//  WeatherApp
//
//  Created by Pawel Weglewski on 26/10/15.
//  Copyright © 2015 Pawel Weglewski. All rights reserved.
//

#import "WACoordinates.h"

@implementation WACoordinates

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"lon": @"longitude",
                                                       @"lat": @"latitude"
                                                       }];
}
@end
