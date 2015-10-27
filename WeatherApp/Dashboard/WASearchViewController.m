//
//  WASearchViewController.m
//  WeatherApp
//
//  Created by Pawel Weglewski on 26/10/15.
//  Copyright © 2015 Pawel Weglewski. All rights reserved.
//

#import "WASearchViewController.h"
#import "WAWSManager.h"
#import "AppDelegate.h"
#import "WADataManager.h"

@interface WASearchViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *datasource;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation WASearchViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        UIViewController *topCtrl = ((UINavigationController*)ApplicationDelegate.window.rootViewController).viewControllers.firstObject;
        [WADataManager sharedInstance].selectedCity = self.datasource[indexPath.row];
        [topCtrl performSegueWithIdentifier:@"ShowDetail" sender:topCtrl];
    }];
}
#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    WAWSManager *manager = [WAWSManager sharedInstance];
    [manager findCity:[manager paramsForName:searchText] completionBlock:^(NSArray *list) {
        self.datasource = list;
        [self.tableView reloadData];
    } failureBlock:^(NSError *error) {
        self.datasource = @[];
        [self.tableView reloadData];
    }];
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
