//
//  ExampleTableViewController.m
//  MGTSplitViewController
//
//  Created by Sam Francis on 4/10/15.
//  Copyright (c) 2015 Mindgrub. All rights reserved.
//

#import "EX1SecondTableViewController.h"

@interface EX1SecondTableViewController ()

@end

@implementation EX1SecondTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell" forIndexPath:indexPath];
    
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
    
    if ([detail isKindOfClass:[EX1ImageViewController class]]) {
        ((EX1ImageViewController *)detail).mainImageView.image = image;
    }
    else{
        NSLog(@"The detail view is not an image view controller");
    }
}


@end
