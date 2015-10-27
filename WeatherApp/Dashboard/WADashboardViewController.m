//
//  WADashboardViewController.m
//  WeatherApp
//
//  Created by Pawel Weglewski on 26/10/15.
//  Copyright © 2015 Pawel Weglewski. All rights reserved.
//

#import "WADashboardViewController.h"
#import "WAWSManager.h"
#import "WADataManager.h"
#import "WADashboardCollectionViewCell.h"

@interface WADashboardViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray *datasource;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation WADashboardViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    WADataManager *dataManager = [WADataManager sharedInstance];
    WAWSManager *wsmanager = [WAWSManager sharedInstance];
    WADashboardViewController __weak *weakSelf = self;
    NSArray *displayedIDs = [self.datasource valueForKey:@"identifier"];
    if (dataManager.dashboardList.count) {
        [dataManager.dashboardList enumerateObjectsUsingBlock:^(NSString *identifier, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![displayedIDs containsObject:identifier]) {
                [wsmanager getWeather:[wsmanager paramsForId:identifier]
                      completionBlock:^(WACity *result) {
                          [weakSelf.datasource addObject:result];
                          [weakSelf.collectionView reloadData];
                      } failureBlock:^(NSError *error) {
                      }];
            }
        }];
    }
    if (self.datasource.count) {
        [self.datasource enumerateObjectsUsingBlock:^(WACity *city, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![dataManager.dashboardList containsObject:city.identifier]) {
                [self.datasource removeObject:city];
                [self.collectionView reloadData];
            }
        }];
    }
}

- (NSMutableArray *)datasource
{
    if (!_datasource) {
        _datasource = [@[]mutableCopy];
    }
    return _datasource;
}
#pragma mark - UICollectionDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WADashboardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    [cell setupWithModel:self.datasource[indexPath.item]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collectionView.bounds.size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [WADataManager sharedInstance].selectedCity = self.datasource[indexPath.item];
    [self performSegueWithIdentifier:@"ShowDetail" sender:self];
}
@end
