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
#import "WACity.h"
#import "WAForcast.h"


#define BASE_URL            @"http://api.openweathermap.org/data/2.5"
#define WEATHER_URL         @"weather"
#define FORECAST_URL        @"forecast"
#define SEARCH_URL          @"find"
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
        [_operationManager.operationQueue setMaxConcurrentOperationCount:2];
        [_operationManager.requestSerializer setTimeoutInterval:10];
    }
    return _operationManager;
}

#pragma mark - API Calls

- (void)getData:(NSString *)type
         params:(NSDictionary *)params
completionBlock:(void(^)(id responseObject))completionBlock
   failureBlock:(void(^)(NSError *error))failureBlock
{
    [self.operationManager GET:type
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

- (void)getWeather:(NSDictionary *)params
   completionBlock:(void (^)(WACity *result))completionBlock
      failureBlock:(void (^)(NSError *error))failureBlock
{
    [self getData:WEATHER_URL params:params completionBlock:^(NSDictionary *responseObject)
    {
        NSError *error = nil;
        WACity *city = [[WACity alloc]initWithDictionary:responseObject error:&error];
        if (!error && completionBlock) {
            completionBlock(city);
        }else if (failureBlock) {
            failureBlock(error);
        }
    } failureBlock:failureBlock];
}

- (void)getForecast:(NSDictionary *)params
    completionBlock:(void (^)(WAForcast *forecast))completionBlock
       failureBlock:(void (^)(NSError *error))failureBlock
{
    NSMutableDictionary *dic = [@{@"cnt" : @8} mutableCopy];
    [dic addEntriesFromDictionary:params];
    [self getData:FORECAST_URL params:dic completionBlock:^(NSDictionary *responseObject)
    {
        NSError *error = nil;
        WAForcast *forecast = [[WAForcast alloc] initWithDictionary:responseObject error:&error];
        if (!error && completionBlock) {
            completionBlock(forecast);
        }else {
            if (failureBlock) {
                failureBlock(error);
            }
        }
    } failureBlock:failureBlock];
}

- (void)findCity:(NSDictionary *)params
 completionBlock:(void (^)(NSArray *list))completionBlock
    failureBlock:(void (^)(NSError *error))failureBlock
{
    NSMutableDictionary *dic = [@{@"type" : @"like"} mutableCopy];
    [dic addEntriesFromDictionary:params];
    [self getData:SEARCH_URL params:dic completionBlock:^(NSDictionary *responseObject) {
        NSError *error = nil;
        if ([responseObject objectForKey:@"list"]) {
            NSArray *list = [WACity arrayOfModelsFromDictionaries:responseObject[@"list"] error:&error];
            if (!error && completionBlock) {
                completionBlock(list);
            }else if (failureBlock){
                failureBlock(error);
            }
        }else if (failureBlock) {
            failureBlock(nil);
        }
    } failureBlock:failureBlock];
}

#pragma mark - Request params preperation

- (NSMutableDictionary *)params
{
    return [@{@"units" : @"metric",
              @"APPID" : API_KEY,
              @"lang" : [NSLocale currentLocale].localeIdentifier}mutableCopy];
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
    if (identifier)
    {
        [dic addEntriesFromDictionary:@{@"id" : identifier}];
    }
    return [dic copy];
}

@end
