//
//  WAWind.h
//  WeatherApp
//
//  Created by Pawel Weglewski on 26/10/15.
//  Copyright © 2015 Pawel Weglewski. All rights reserved.
//

#import "JSONModel.h"

@interface WAWind : JSONModel

@property (nonatomic, strong) NSNumber *speed;
@property (nonatomic, strong) NSNumber *deg;

@end
