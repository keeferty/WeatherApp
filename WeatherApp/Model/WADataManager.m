//
//  WADataManager.m
//  WeatherApp
//
//  Created by Pawel Weglewski on 26/10/15.
//  Copyright © 2015 Pawel Weglewski. All rights reserved.
//

#import "WADataManager.h"
#import "WAWSManager.h"

@implementation WADataManager

+ (instancetype)sharedInstance
{
    static WADataManager *sDataManager;
    if (!sDataManager) {
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"DataManager"]) {
            NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"DataManager"];
            sDataManager = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }else{
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                sDataManager = [WADataManager new];
            });
        }
    }
    return sDataManager;
}

#pragma mark - NSKeyedArchiver saving

- (void)save
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"DataManager"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
