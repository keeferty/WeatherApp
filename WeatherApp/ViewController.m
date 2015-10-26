//
//  ViewController.m
//  WeatherApp
//
//  Created by Pawel Weglewski on 26/10/15.
//  Copyright © 2015 Pawel Weglewski. All rights reserved.
//

#import "ViewController.h"
#import "WAWSManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    WAWSManager *manager = [WAWSManager sharedInstance];
//    [manager getWeather:[manager paramsForName:@"Tczew"] completionBlock:^(WACity *result) {
//        NSLog(@"success");
//    } failureBlock:^(NSError *error) {
//        NSLog(@"error");
//    }];
//    [manager getForecast:[manager paramsForName:@"Tczew"] completionBlock:^(WAForcast *forecast) {
//        NSLog(@"success");
//    } failureBlock:^(NSError *error) {
//        NSLog(@"error");
//    }];
    [manager findCity:[manager paramsForName:@"lon"] completionBlock:^(NSArray *list) {
        NSLog(@"success");
    } failureBlock:^(NSError *error) {
        NSLog(@"error");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
