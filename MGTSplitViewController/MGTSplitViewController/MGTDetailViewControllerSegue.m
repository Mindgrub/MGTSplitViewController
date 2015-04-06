//
//  DetailViewControllerSegue.m
//  MGTSplitViewController
//
//  Created by Sam Francis on 4/6/15.
//  Copyright (c) 2015 Mindgrub. All rights reserved.
//

#import "MGTDetailViewControllerSegue.h"

@implementation MGTDetailViewControllerSegue

- (void)perform {
    UIViewController *srcViewController = self.sourceViewController;
    UIViewController *destinationViewController = [self destinationViewController];
    
    [srcViewController addChildViewController:destinationViewController];
    [srcViewController.view addSubview:destinationViewController.view];
    
    //This line uses FLKAutolayout library to setup constraints
    //[dst.view alignToView:src.view];
    
    [destinationViewController didMoveToParentViewController:srcViewController];
}

@end
