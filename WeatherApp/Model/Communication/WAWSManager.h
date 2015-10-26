//
//  WAWSManager.h
//  WeatherApp
//
//  Created by Pawel Weglewski on 26/10/15.
//  Copyright © 2015 Pawel Weglewski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WACoordinates.h"

@interface WAWSManager : NSObject

+ (instancetype)sharedInstance;

- (void)getWeather:(NSDictionary *)params
   completionBlock:(void(^)(id responseObject))completionBlock
      failureBlock:(void(^)(NSError *error))failureBlock;

- (NSDictionary *)paramsForCoordinates:(WACoordinates *)coords;
- (NSDictionary *)paramsForName:(NSString *)name;
- (NSDictionary *)paramsForId:(NSString *)identifier;

@end
