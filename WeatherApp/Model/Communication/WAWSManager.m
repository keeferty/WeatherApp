//
//  WAWSManager.m
//  WeatherApp
//
//  Created by Pawel Weglewski on 26/10/15.
//  Copyright © 2015 Pawel Weglewski. All rights reserved.
//

#import "WAWSManager.h"
#import <AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>
#import <AFNetworkActivityLogger.h>


#define BASE_URL            @"http://api.openweathermap.org/data/2.5"
#define API_KEY             @"c818ea0a0896001fae16ea6db75d58cd"

@interface WAWSManager ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *operationManager;

@end

@implementation WAWSManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static WAWSManager *sharedManager = nil;
    dispatch_once(&onceToken, ^{
        sharedManager = [WAWSManager new];
        [[NSNotificationCenter defaultCenter] addObserver:sharedManager selector:@selector(afNetworkingListener:) name:AFNetworkingTaskDidCompleteNotification object:nil];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
#ifdef DEBUG
        [[AFNetworkActivityLogger sharedLogger] startLogging];
        [[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelDebug];
#endif
    });
    return sharedManager;
}

#pragma mark - Listener for errors

- (void)afNetworkingListener:(NSNotification *)note
{
    NSError *error = note.userInfo[AFNetworkingTaskDidCompleteErrorKey];
    CLS_LOG(@"%@",[error localizedDescription]);
}

#pragma mark - Getters for lazy instantiation

- (AFHTTPRequestOperationManager *)operationManager
{
    if (!_operationManager) {
        _operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        [_operationManager.operationQueue setMaxConcurrentOperationCount:1];
        [_operationManager.requestSerializer setTimeoutInterval:10];
    }
    return _operationManager;
}

#pragma mark - API Calls

- (void)getWeather:(NSDictionary *)params
   completionBlock:(void(^)(id responseObject))completionBlock
      failureBlock:(void(^)(NSError *error))failureBlock
{
    [self.operationManager GET:@"weather"
                    parameters:params
                       success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject)
                                {
                                    if (completionBlock) {
                                        completionBlock(responseObject);
                                    }
                                }
                       failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error)
                                {
                                    if (failureBlock) {
                                        failureBlock(error);
                                    }
                                }];
}

#pragma mark - Request params preperation

- (NSMutableDictionary *)params
{
    return [@{@"units" : @"metric",
             @"APPID" : API_KEY}mutableCopy];
}

- (NSDictionary *)paramsForCoordinates:(WACoordinates *)coords
{
    NSMutableDictionary *dic = [self params];
    if (coords && coords.longitude && coords.latitude) {
        [dic addEntriesFromDictionary:@{@"lon" : coords.longitude,
                                        @"lat" : coords.latitude}];
    }
    return [dic copy];
}

- (NSDictionary *)paramsForName:(NSString *)name
{
    NSMutableDictionary *dic = [self params];
    if (name) {
        [dic addEntriesFromDictionary:@{@"q" : name}];
    }
    return [dic copy];
}

- (NSDictionary *)paramsForId:(NSString *)identifier
{
    NSMutableDictionary *dic = [self params];
    if (identifier) {
        [dic addEntriesFromDictionary:@{@"id" : identifier}];
    }
    return [dic copy];
}

@end
