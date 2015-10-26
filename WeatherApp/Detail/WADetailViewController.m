//
//  WADetailViewController.m
//  WeatherApp
//
//  Created by Pawel Weglewski on 26/10/15.
//  Copyright © 2015 Pawel Weglewski. All rights reserved.
//

#import "WADetailViewController.h"
#import "WADataManager.h"
#import "WAWSManager.h"
#import <FSLineChart.h>

@interface WADetailViewController ()

@property (nonatomic, copy) WAForcast *forecast;
@property (nonatomic, strong)  FSLineChart *lineChart;
@property (nonatomic, strong)  FSLineChart *trendChart;
@property (weak, nonatomic) IBOutlet UIView *graphContainer;
@property (weak, nonatomic) IBOutlet UILabel *tempGraphDescription;
@property (weak, nonatomic) IBOutlet UIView *trendGraphContainer;
@property (weak, nonatomic) IBOutlet UILabel *trendGraphDescription;

@end

@implementation WADetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    WAWSManager *manager = [WAWSManager sharedInstance];
    WADetailViewController __weak *weakSelf = self;
    [manager getForecast:[manager paramsForName:[WADataManager sharedInstance].selectedCity.name] completionBlock:^(WAForcast *forecast) {
        weakSelf.forecast = forecast;
        [self fillWithModel];
    } failureBlock:^(NSError *error) {
        
    }];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self reloadTempGraph];
}

- (void)fillWithModel
{
    [self setTitle:self.forecast.city.name];
    [self reloadTempGraph];
    [self.tempGraphDescription setText:NSLocalizedString(@"24h Forcasted Temperature", nil)];
    [self reloadTrendGraph];
    [self.trendGraphDescription setText:NSLocalizedString(@"24h Forcasted Weather Worsening Trend", nil)];
}

- (void)reloadTempGraph
{
    if (self.lineChart)
    {
        [self.lineChart removeFromSuperview];
    }
    NSArray *temps = [[self.forecast.list valueForKey:@"main"] valueForKey:@"temp"];
    self.lineChart = [[FSLineChart alloc] initWithFrame:self.graphContainer.bounds];
    self.lineChart.labelForValue = ^(CGFloat value) {
        return [NSString stringWithFormat:@"%.2f °C", value];
    };
    [self.lineChart setDisplayDataPoint:YES];
    [self.lineChart setBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [self.graphContainer addSubview:self.lineChart];
    [self.lineChart setChartData:temps];
}

- (NSArray *)weatherTrend
{
    NSMutableArray *trends = [@[]mutableCopy];
    WAMain *prev;
    WAMain *now;
    for (NSInteger i=0; i<self.forecast.list.count; i++)
    {
        if (i == 0) {
            prev = [WADataManager sharedInstance].selectedCity.main;
        }else {
            prev = ((WAForcastedWeather*)self.forecast.list[i-1]).main;
        }
        now = ((WAForcastedWeather*)self.forecast.list[i]).main;
        
        CGFloat deltaPressure = fabs(fabs(prev.pressure.floatValue - 1024) - fabs(now.pressure.floatValue - 1024));
        CGFloat deltaTemp = fabs(fabs(prev.temp.floatValue - 25) - fabs(now.temp.floatValue - 25));
        CGFloat deltaHumidity = fabs(fabs(prev.humidity.floatValue - 50) - fabs(now.humidity.floatValue - 50));
        [trends addObject:@((deltaHumidity + deltaTemp + deltaPressure)*0.66)];
    }
    return [trends copy];
}

- (void)reloadTrendGraph
{
    if (self.trendChart)
    {
        [self.trendChart removeFromSuperview];
    }
    self.trendChart = [[FSLineChart alloc] initWithFrame:self.trendGraphContainer.bounds];
    self.trendChart.labelForValue = ^(CGFloat value) {
        return [NSString stringWithFormat:@"%.0f%%", value];
    };
    [self.trendChart setDisplayDataPoint:YES];
    [self.trendChart setColor:[UIColor redColor]];
    [self.trendChart setFillColor:[UIColor redColor]];
    [self.trendChart setBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [self.trendGraphContainer addSubview:self.trendChart];
    [self.trendChart setChartData:[self weatherTrend]];
}

@end
