//
//  WADataManagerSpec.m
//  WeatherApp
//
//  Created by Pawel Weglewski on 27/10/15.
//  Copyright 2015 Pawel Weglewski. All rights reserved.
//

#import "Specta.h"
#import "Expecta.h"
#import "WADataManager.h"

#define EXP_SHORTHAND


SpecBegin(WADataManager)

describe(@"WADataManager", ^{
    
    it(@"Check if it is not nill", ^{
        expect([WADataManager sharedInstance]).notTo.beNil();
    });
    
    it(@"Check if it is a signleton", ^{
        WADataManager *manager = [WADataManager sharedInstance];
        expect(manager).to.equal([WADataManager sharedInstance]);
    });

    it(@"Check if it implements save functionality", ^{
        WADataManager *manager = [WADataManager sharedInstance];
        expect(manager).to.respondTo(@selector(save));
    });

    it(@"Check if save functionality works correctly", ^{
        WADataManager *manager = [WADataManager sharedInstance];
        manager.dashboardList = [@[@"1111"]mutableCopy];
        [manager save];
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"DataManager"];
        WADataManager *newDataManager = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        expect(newDataManager.dashboardList.firstObject).to.equal(@"1111");
    });
    
    afterAll(^{
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"DataManager"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
});

SpecEnd
