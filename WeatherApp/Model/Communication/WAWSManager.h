//
//  WAWSManager.h
//  WeatherApp
//
//  Created by Pawel Weglewski on 26/10/15.
//  Copyright © 2015 Pawel Weglewski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WACoordinates.h"
#import "WACity.h"
#import "WAForcast.h"

@interface WAWSManager : NSObject

+ (instancetype)sharedInstance;

- (void)getWeather:(NSDictionary *)params
   completionBlock:(void (^)(WACity *result))completionBlock
      failureBlock:(void (^)(NSError *error))failureBlock;

- (void)getForecast:(NSDictionary *)params
    completionBlock:(void (^)(WAForcast *forecast))completionBlock
       failureBlock:(void (^)(NSError *error))failureBlock;

- (void)findCity:(NSDictionary *)params
 completionBlock:(void (^)(NSArray *list))completionBlock
    failureBlock:(void (^)(NSError *error))failureBlock;

- (NSDictionary *)paramsForCoordinates:(WACoordinates *)coords;
- (NSDictionary *)paramsForName:(NSString *)name;
- (NSDictionary *)paramsForId:(NSArray *)identifiers;

@end
