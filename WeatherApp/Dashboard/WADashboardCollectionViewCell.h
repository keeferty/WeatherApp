//
//  WADashboardCollectionViewCell.h
//  WeatherApp
//
//  Created by Pawel Weglewski on 26/10/15.
//  Copyright © 2015 Pawel Weglewski. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WACity;

@interface WADashboardCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *cityName;
@property (weak, nonatomic) IBOutlet UILabel *temperature;
@property (weak, nonatomic) IBOutlet UILabel *humidity;
@property (weak, nonatomic) IBOutlet UILabel *clouds;

- (void)setupWithModel:(WACity *)city;
@end
