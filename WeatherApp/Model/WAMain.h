//
//  WAMain.h
//  WeatherApp
//
//  Created by Pawel Weglewski on 26/10/15.
//  Copyright © 2015 Pawel Weglewski. All rights reserved.
//

#import "JSONModel.h"

@interface WAMain : JSONModel

@property (nonatomic, strong) NSNumber *temp;
@property (nonatomic, strong) NSNumber <Optional>*tempMin;
@property (nonatomic, strong) NSNumber <Optional>*tempMax;
@property (nonatomic, strong) NSNumber *pressure;
@property (nonatomic, strong) NSNumber <Optional>*seaLevel;
@property (nonatomic, strong) NSNumber <Optional>*groundLevel;
@property (nonatomic, strong) NSNumber *humidity;

@end
