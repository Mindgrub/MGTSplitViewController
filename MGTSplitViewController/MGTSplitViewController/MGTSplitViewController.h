//
//  MGTSplitViewController.h
//  MGTSplitViewController
//
//  Created by Sam Francis on 4/1/15.
//  Copyright (c) 2015 Mindgrub. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MGTSplitViewController;


@protocol MGTSplitViewControllerDelegate <NSObject>

-(NSArray *)viewControllers;
-(void)goBack;
-(UIBarButtonItem *)backButtonDefault;
-(UIBarButtonItem *)backButtonWithTitle:(NSString *)title;
-(UIBarButtonItem *)backButtonWithTintColor:(UIColor *)tintColor;
-(UIBarButtonItem *)backButtonWithTitle:(NSString *)title tintColor:(UIColor *)tintColor;

@end


@protocol MGTSplitViewControllerPropertyDelegate <NSObject>

@required
@property (weak, nonatomic) id <MGTSplitViewControllerDelegate> splitViewDelegate;

@end


@interface MGTSplitViewController : UIViewController <MGTSplitViewControllerDelegate>

@property (strong, nonatomic) UIViewController *masterViewController;
@property (strong, nonatomic) UIViewController *detailViewController;

@property  (nonatomic, strong) NSString *masterViewControllerStoryboardId;
@property  (nonatomic, strong) NSString *detailViewControllerStoryboardId;

-(id)initWithMasterVC:(UIViewController *)masterViewController detailVC:(UIViewController *)detailViewController;

@end

