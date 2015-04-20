//
//  EX1FirstTableViewController.m
//  MGTSplitViewController
//
//  Created by Sam Francis on 4/15/15.
//  Copyright (c) 2015 Mindgrub. All rights reserved.
//

#import "EX1FirstTableViewController.h"
#import "EX1SecondTableViewController.h"

@interface EX1FirstTableViewController ()

@end

@implementation EX1FirstTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *destinationViewController = [segue destinationViewController];
    
    if ([destinationViewController conformsToProtocol:@protocol(MGTSplitViewControllerPropertyDelegate)]) {
        ((id<MGTSplitViewControllerPropertyDelegate>)destinationViewController).splitViewDelegate = self.splitViewDelegate;
    }
    
}


@end
