//
//  WADashboardCollectionViewCell.m
//  WeatherApp
//
//  Created by Pawel Weglewski on 26/10/15.
//  Copyright © 2015 Pawel Weglewski. All rights reserved.
//

#import "WADashboardCollectionViewCell.h"
#import "WACity.h"

@interface WADashboardCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIView *container;

@end

@implementation WADashboardCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.container.layer setCornerRadius:15];
    [self.container.layer setBorderWidth:3];
    [self.container.layer setBorderColor:[UIColor darkGrayColor].CGColor];
}

- (void)setupWithModel:(WACity *)city
{
    [self.cityName setText:city.name];
    [self.temperature setText:[NSString stringWithFormat:@"%.1f°C",city.main.temp.floatValue]];
    [self.humidity setText:[NSString stringWithFormat:@"%@ %ld%%",NSLocalizedString(@"Humidity", nil),(long)city.main.temp.integerValue]];
    [self.clouds setText:[NSString stringWithFormat:@"%@ %ld%%",NSLocalizedString(@"Clouds", nil),(long)city.clouds.all.integerValue]];
}
@end
