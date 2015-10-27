//
//  WACity.h
//  WeatherApp
//
//  Created by Pawel Weglewski on 26/10/15.
//  Copyright © 2015 Pawel Weglewski. All rights reserved.
//

#import "JSONModel.h"
#import "WACoordinates.h"
#import "WAWeather.h"
#import "WAMain.h"
#import "WAWind.h"
#import "WAClouds.h"

@interface WACity : JSONModel

@property (nonatomic, copy) NSString        *name;
@property (nonatomic, copy) NSString        *identifier;
@property (nonatomic, strong) NSNumber      <Optional>*dt;
@property (nonatomic, readonly) NSDate      <Ignore>*date;
@property (nonatomic, strong) WACoordinates <Optional> *coord;
@property (nonatomic, strong) NSArray       <WAWeather,Optional> *weather;
@property (nonatomic, strong) WAMain        <Optional> *main;
@property (nonatomic, strong) WAWind        <Optional> *wind;
@property (nonatomic, strong) WAClouds      <Optional> *clouds;
@property (nonatomic, strong) NSNumber      <Ignore>*locationAdded;

@end
