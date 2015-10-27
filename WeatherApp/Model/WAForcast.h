//
//  WAForcast.h
//  WeatherApp
//
//  Created by Pawel Weglewski on 26/10/15.
//  Copyright © 2015 Pawel Weglewski. All rights reserved.
//

#import "JSONModel.h"
#import "WACity.h"
#import "WAForcastedWeather.h"

@interface WAForcast : JSONModel

@property (nonatomic, strong) WACity *city;
@property (nonatomic, strong) NSArray <WAForcastedWeather> *list;
@end
