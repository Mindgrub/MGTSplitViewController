//
//  EX1FirstTableViewController.h
//  MGTSplitViewController
//
//  Created by Sam Francis on 4/15/15.
//  Copyright (c) 2015 Mindgrub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGTSplitViewController.h"

@interface EX1FirstTableViewController : UITableViewController <MGTSplitViewControllerPropertyDelegate>

@property (weak, nonatomic) id <MGTSplitViewControllerDelegate> splitViewDelegate;

@end
