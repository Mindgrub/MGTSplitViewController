//
//  ExampleTableViewController.m
//  MGTSplitViewController
//
//  Created by Sam Francis on 4/10/15.
//  Copyright (c) 2015 Mindgrub. All rights reserved.
//

#import "ExampleTableViewController.h"

@interface ExampleTableViewController ()

@end

@implementation ExampleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MGTSplitViewControllerDelegate

-(void)goBackFromSplitView:(MGTSplitViewController *)splitView{
    if (![[[splitView.navigationController viewControllers] firstObject] isEqual:self]) {
        [[splitView navigationController] setNavigationBarHidden:NO animated:YES];
        [splitView.navigationController popViewControllerAnimated:YES];
    }
    
}

-(NSArray *)viewControllersForSplitView:(MGTSplitViewController *)splitView{
    
    return @[splitView.masterViewController, splitView.detailViewController];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MasterCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"First Image";
            break;
        case 1:
            cell.textLabel.text = @"Second Image";
            break;
        case 2:
            cell.textLabel.text = @"Third Image";
            break;
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIImage *image = nil;
    
    switch (indexPath.row) {
        case 0:
            image = [UIImage imageNamed:@"image1"];
            break;
        case 1:
            image = [UIImage imageNamed:@"image2"];
            break;
        case 2:
            image = [UIImage imageNamed:@"image3"];
            break;
        default:
            break;
    }
    
    id detail = [[self.splitViewDelegate viewControllers] objectAtIndex:1];
    
    if ([detail isKindOfClass:[ExampleImageViewController class]]) {
        ((ExampleImageViewController *)detail).mainImageView.image = image;
    }
    else{
        NSLog(@"The detail view is not an image view controller");
    }
    
//    id master = self.navigationController;
//    
//    if ([master conformsToProtocol:@protocol(MGTSplitViewControllerPropertyDelegate)]) {
//        id detail = [[((ExampleNavigationController *)master).splitViewDelegate viewControllers] objectAtIndex:1];
//        
//        if ([detail isKindOfClass:[ExampleImageViewController class]]) {
//            ((ExampleImageViewController *)detail).mainImageView.image = image;
//        }
//        else{
//            NSLog(@"The detail view is not an image view controller");
//        }
//    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
