//
//  EX3GreenViewController.h
//  MGTSplitViewController
//
//  Created by Sam Francis on 4/13/15.
//  Copyright (c) 2015 Mindgrub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGTSplitViewController.h"

@interface EX2GreenViewController : UIViewController <MGTSplitViewControllerPropertyDelegate>

@property (weak, nonatomic) id <MGTSplitViewControllerDelegate> splitViewDelegate;

@end
