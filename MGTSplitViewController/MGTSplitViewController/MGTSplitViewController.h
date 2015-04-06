//
//  MGTSplitViewController.h
//  MGTSplitViewController
//
//  Created by Sam Francis on 4/1/15.
//  Copyright (c) 2015 Mindgrub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGTSplitViewController : UIViewController

//@property (strong, nonatomic) UIView *masterView;
//@property (strong, nonatomic) UIView *detailView;

@property (strong, nonatomic) UIViewController *masterViewController;
@property (strong, nonatomic) UIViewController *detailViewController;

@property (nonatomic) NSInteger masterViewWidth;

-(UIBarButtonItem *)backButton;

@end


@protocol MGTSplitViewControllerDelegate

-(void)goBack;

@end