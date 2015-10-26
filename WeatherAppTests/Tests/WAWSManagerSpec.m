//
//  WAWSManagerSpec.m
//  WeatherApp
//
//  Created by Pawel Weglewski on 26/10/15.
//  Copyright 2015 Pawel Weglewski. All rights reserved.
//

#import "Specta.h"
#import "Expecta.h"
#import "WAWSManager.h"

#define EXP_SHORTHAND

SpecBegin(WAWSManager)

describe(@"WAWSManager", ^{
    
    beforeAll(^{

    });
    
    beforeEach(^{

    });
    
    it(@"Check if it is not nill", ^{
        expect([WAWSManager sharedInstance]).notTo.beNil();
    });
    
    it(@"Check if it is a signleton", ^{
        WAWSManager *manager = [WAWSManager sharedInstance];
        expect(manager).to.equal([WAWSManager sharedInstance]);
    });
    
//    it(@"has a login api call implementation", ^{
//        expect([PWWSManager sharedInstance]).to.respondTo(@selector(login:password:completionBlock:failureBlock:));
//    });
    
    
    afterEach(^{

    });
    
    afterAll(^{

    });
});

SpecEnd
