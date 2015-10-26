//
//  WAForcastedWeather.h
//  WeatherApp
//
//  Created by Pawel Weglewski on 26/10/15.
//  Copyright © 2015 Pawel Weglewski. All rights reserved.
//

#import "JSONModel.h"
#import "WAWeather.h"
#import "WAMain.h"
#import "WAWind.h"
#import "WAClouds.h"

@protocol WAForcastedWeather;

@interface WAForcastedWeather : JSONModel

@property (nonatomic, strong) NSNumber  *dt;
@property (nonatomic, readonly) NSDate  <Ignore> *date;
@property (nonatomic, strong) NSArray   <WAWeather,Optional> *weather;
@property (nonatomic, strong) WAMain    <Optional> *main;
@property (nonatomic, strong) WAWind    <Optional> *wind;
@property (nonatomic, strong) WAClouds  <Optional> *clouds;

@end
