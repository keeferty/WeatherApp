//
//  WASearchViewController.m
//  WeatherApp
//
//  Created by Pawel Weglewski on 26/10/15.
//  Copyright © 2015 Pawel Weglewski. All rights reserved.
//

#import "WASearchViewController.h"
#import "WAWSManager.h"

@interface WASearchViewController ()<UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *datasource;

@end

@implementation WASearchViewController

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = ((WACity *)self.datasource[indexPath.row]).name;
    return cell;
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    WAWSManager *manager = [WAWSManager sharedInstance];
    [manager findCity:[manager paramsForName:searchText] completionBlock:^(NSArray *list) {
        if (list.count != self.datasource.count) {
            self.datasource = list;
            [self.tableView reloadData];
        }
    } failureBlock:^(NSError *error) {
    }];
}

@end
