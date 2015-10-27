//
//  WAWeather.h
//  WeatherApp
//
//  Created by Pawel Weglewski on 26/10/15.
//  Copyright © 2015 Pawel Weglewski. All rights reserved.
//

#import "JSONModel.h"

@protocol WAWeather; 

@interface WAWeather : JSONModel

@property (nonatomic, copy) NSString *main;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *icon;

@end
