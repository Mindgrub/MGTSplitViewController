//
//  ExampleTableViewController.h
//  MGTSplitViewController
//
//  Created by Sam Francis on 4/10/15.
//  Copyright (c) 2015 Mindgrub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGTSplitViewController.h"
#import "EX1ImageViewController.h"

@interface EX1SecondTableViewController : UITableViewController <MGTSplitViewControllerPropertyDelegate>

@property (weak, nonatomic) id <MGTSplitViewControllerDelegate> splitViewDelegate;

@end
