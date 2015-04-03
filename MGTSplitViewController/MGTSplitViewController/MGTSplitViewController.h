//
//  MGTSplitViewController.h
//  MGTSplitViewController
//
//  Created by Sam Francis on 4/1/15.
//  Copyright (c) 2015 Mindgrub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGTSplitViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *masterViewController;
@property (strong, nonatomic) IBOutlet UIView *detailViewController;

@end


@protocol MGTSplitViewControllerDelegate

-(void)goBack;

@end