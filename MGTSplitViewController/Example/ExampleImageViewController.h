//
//  ExampleImageViewController.h
//  MGTSplitViewController
//
//  Created by Sam Francis on 4/10/15.
//  Copyright (c) 2015 Mindgrub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGTSplitViewController.h"

@interface ExampleImageViewController : UIViewController <MGTSplitViewControllerPropertyDelegate>

@property (weak, nonatomic) id <MGTSplitViewControllerDelegate> splitViewDelegate;

@property (strong, nonatomic) IBOutlet UIImageView *mainImageView;


@end
