//
//  WADataManager.m
//  WeatherApp
//
//  Created by Pawel Weglewski on 26/10/15.
//  Copyright © 2015 Pawel Weglewski. All rights reserved.
//

#import "WADataManager.h"
#import "WAWSManager.h"
#import <RNEncryptor.h>
#import <RNDecryptor.h>

const char myKey[] = { 0x0065,0x0031,0x0036,0x0065,0x0061,0x0036,0x0064,0x0062,0x0037,0x0035,0x0064,0x0035,0x0038,0x0063,0x0064,0x0063,0x0038,0x0031,0x0038,0x0065,0x0061,0x0030,0x0061,0x0030,0x0038,0x0039,0x0036,0x0030,0x0030,0x0031,0x0066,0x0061,0x00};

@implementation WADataManager

+ (instancetype)sharedInstance
{
    static WADataManager *sDataManager;
    static dispatch_once_t onceToken;
    if (!sDataManager) {
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"DataManager"]) {
            NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"DataManager"];
            NSError *error;
            NSData *decryptedData = [RNDecryptor decryptData:data
                                                withSettings:kRNCryptorAES256Settings
                                                    password:[[NSString alloc]initWithBytes:myKey length:strlen(myKey) encoding:NSASCIIStringEncoding]
                                                       error:&error];
            if (!error) {
                sDataManager = [NSKeyedUnarchiver unarchiveObjectWithData:decryptedData];
            }else {
                dispatch_once(&onceToken, ^{
                    sDataManager = [WADataManager new];
                });
            }
        }else{
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
    NSError *error;
    NSData *ciphertext = [RNEncryptor encryptData:data
                                     withSettings:kRNCryptorAES256Settings
                                         password:[[NSString alloc]initWithBytes:myKey length:strlen(myKey) encoding:NSASCIIStringEncoding]
                                            error:&error];
    if (!error) {
        [[NSUserDefaults standardUserDefaults] setObject:ciphertext forKey:@"DataManager"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (NSMutableArray *)dashboardList
{
    if (!_dashboardList) {
        _dashboardList = [@[] mutableCopy];
    }
    return _dashboardList;
}
@end
