//
//  WADataManager.h
//  WeatherApp
//
//  Created by Pawel Weglewski on 26/10/15.
//  Copyright © 2015 Pawel Weglewski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WACity.h"
#import "WAForcast.h"

@interface WADataManager : NSObject

@property (nonatomic, copy) WACity *selectedCity;

+ (instancetype)sharedInstance;

@end
