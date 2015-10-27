//
//  WACoordinates.h
//  WeatherApp
//
//  Created by Pawel Weglewski on 26/10/15.
//  Copyright © 2015 Pawel Weglewski. All rights reserved.
//

#import "JSONModel.h"

@interface WACoordinates : JSONModel

@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *latitude;

@end
