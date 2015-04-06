//
//  MGTSplitViewController.h
//  MGTSplitViewController
//
//  Created by Sam Francis on 4/1/15.
//  Copyright (c) 2015 Mindgrub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGTMasterViewControllerSegue.h"
#import "MGTDetailViewControllerSegue.h"
#import "UIBarButtonItem+DefaultBackButton.h"

@interface MGTSplitViewController : UIViewController

@property (strong, nonatomic) UIViewController *masterViewController;
@property (strong, nonatomic) UIViewController *detailViewController;

@property  (nonatomic, strong) NSString *masterViewControllerStoryboardId;
@property  (nonatomic, strong) NSString *detailViewControllerStoryboardId;

@property (nonatomic) NSInteger masterViewWidth;

-(id)initWithMasterVC:(UIViewController *)masterViewController detailVC:(UIViewController *)detailViewController;
-(UIBarButtonItem *)backButton;

@end


@protocol MGTSplitViewControllerDelegate

-(void)goBack;

@end