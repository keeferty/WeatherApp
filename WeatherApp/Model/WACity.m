//
//  WACity.m
//  WeatherApp
//
//  Created by Pawel Weglewski on 26/10/15.
//  Copyright © 2015 Pawel Weglewski. All rights reserved.
//

#import "WACity.h"

@implementation WACity

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"identifier"
                                                       }];
}

- (NSDate *)date
{
    return [NSDate dateWithTimeIntervalSince1970:self.dt.integerValue];
}
@end
