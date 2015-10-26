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
    
    it(@"has a params preperation for set coordinates", ^{
        expect([WAWSManager sharedInstance]).to.respondTo(@selector(paramsForCoordinates:));
    });
    
    it(@"params preperation for set coordinates is resistant to ill input", ^{
        expect([[WAWSManager sharedInstance] paramsForCoordinates:nil]).to.beKindOf([NSDictionary class]);
    });
    
    it(@"has a params preperation for set city name", ^{
        expect([WAWSManager sharedInstance]).to.respondTo(@selector(paramsForName:));
    });
    
    it(@"params preperation for set city name is resistant to ill input", ^{
        expect([[WAWSManager sharedInstance] paramsForName:nil]).to.beKindOf([NSDictionary class]);
    });
    
    it(@"has a params preperation for set city id", ^{
        expect([WAWSManager sharedInstance]).to.respondTo(@selector(paramsForId:));
    });
 
    it(@"params preperation for set city id is resistant to ill input", ^{
        expect([[WAWSManager sharedInstance] paramsForId:nil]).to.beKindOf([NSDictionary class]);
    });
    
    afterEach(^{

    });
    
    afterAll(^{

    });
});

SpecEnd
