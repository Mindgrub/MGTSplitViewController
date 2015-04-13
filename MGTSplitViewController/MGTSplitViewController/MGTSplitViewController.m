//
//  MGTSplitViewController.m
//  MGTSplitViewController
//
//  Created by Sam Francis on 4/1/15.
//  Copyright (c) 2015 Mindgrub. All rights reserved.
//

#import "MGTSplitViewController.h"

#define DEFAULT_MASTER_WIDTH 320.0

@interface MGTSplitViewController ()

@end

@implementation MGTSplitViewController

-(instancetype)initWithMasterVC:(UIViewController *)masterViewController detailVC:(UIViewController *)detailViewController{
    self.masterViewController = masterViewController;
    self.detailViewController = detailViewController;
    
    return self;
}

-(void)awakeFromNib{
    
    if (self.masterViewControllerStoryboardId) {
        self.masterViewController = [self.storyboard instantiateViewControllerWithIdentifier:self.masterViewControllerStoryboardId];
    }
    if (self.detailViewControllerStoryboardId) {
        self.detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:self.detailViewControllerStoryboardId];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (self.backButtonTintColor == nil) {
        self.backButtonTintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    }
    if (self.backButtonTitle == nil) {
        self.backButtonTitle = @"Back";
    }
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (!self.masterViewWidth) {
        self.masterViewWidth = DEFAULT_MASTER_WIDTH;
    }
    
    //self.masterViewController.navigationItem.leftBarButtonItem = [self backButton];
    [self setSplitViewBackButtonForViewController:self.masterViewController];
    
    if (self.masterViewController && self.detailViewController) {
        [self setupContainers];
    }
    else{
        NSLog(@"ERROR, no master/detail view contorller.");
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setSplitViewBackButtonForViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        [self setSplitViewBackButtonForViewController:[((UINavigationController *)viewController).viewControllers firstObject]];
    }
    
    // If tab bar controller, set the delegates of each of its vc's
    else if ([viewController isKindOfClass:[UITabBarController class]]){
        for (UIViewController *vc in ((UITabBarController *)viewController).viewControllers) {
            [self setSplitViewBackButtonForViewController:vc];
        }
    }
    
    else{
        viewController.navigationItem.leftBarButtonItem = [self backButton];
    }
}


-(void)setSplitViewDelegate:(UIViewController *)viewController{
    // If navigation controller, set the delegate of its root vc.
    // It's up to the developer to pass the delegate on when a new vc is pushed onto the navigation stack.
    if ([viewController isKindOfClass:[UINavigationController class]]){
        [self setSplitViewDelegate:((UINavigationController *)viewController).viewControllers[0]];
    }
    
    // If tab bar controller, set the delegates of each of its vc's
    else if ([viewController isKindOfClass:[UITabBarController class]]){
        for (UIViewController *vc in ((UITabBarController *)viewController).viewControllers) {
            if ([vc conformsToProtocol:@protocol(MGTSplitViewControllerPropertyDelegate)]) {
                [self setSplitViewDelegate:vc];
            }
        }
    }
    
    else if ([viewController conformsToProtocol:@protocol(MGTSplitViewControllerPropertyDelegate)]) {
        ((id<MGTSplitViewControllerPropertyDelegate>)viewController).splitViewDelegate = self;
    }
}


- (void)setMasterViewController:(UIViewController *)masterViewController{
    [self setSplitViewDelegate:masterViewController];
    
    _masterViewController = masterViewController;
}

- (void)setDetailViewController:(UIViewController *)detailViewController{
    [self setSplitViewDelegate:detailViewController];
    _detailViewController = detailViewController;
}

- (UIBarButtonItem *)backButton{
    return [UIBarButtonItem backButtonWithTitle:self.backButtonTitle
                                      tintColor:self.backButtonTintColor
                                         target:self
                                      andAction:@selector(goBack)];
}

- (UIBarButtonItem *)backButtonWithTitle:(NSString *)title{
    
    return [UIBarButtonItem backButtonWithTitle:title
                                tintColor:self.backButtonTintColor
                                   target:self
                                andAction:@selector(goBack)];
    
}

- (UIBarButtonItem *)backButtonWithTintColor:(UIColor *)tintColor{
    
    return [UIBarButtonItem backButtonWithTitle:self.backButtonTitle
                                tintColor:tintColor
                                   target:self
                                andAction:@selector(goBack)];
}

- (UIBarButtonItem *)backButtonWithTitle:(NSString *)title tintColor:(UIColor *)tintColor{
    
    return [UIBarButtonItem backButtonWithTitle:title
                                tintColor:tintColor
                                   target:self
                                andAction:@selector(goBack)];
    
}

-(void)setBackButtonWithTitle:(NSString *)title{
    self.backButtonTitle = title;
    
}

-(void)setBackButtonWithTitle:(NSString *)title tintColor:(UIColor *)tintColor{
    
}

-(void)setBackButtonWithTintColor:(UIColor *)tintColor{
    
}

-(void)setupContainers{
    
    UIView *masterContainerView = [[UIView alloc] initWithFrame:CGRectZero];
    masterContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:masterContainerView];
    
    UIView *detailContainerView = [[UIView alloc] initWithFrame:CGRectZero];
    detailContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:detailContainerView];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(masterContainerView, detailContainerView);
    
    // SET CONTAINER AUTO LAYOUT CONSTRAINTS
    NSString *masterWidthFormat = [[@"H:[masterContainerView(" stringByAppendingString:[@(self.masterViewWidth) stringValue]] stringByAppendingString:@")]"];
    
    [self.view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:masterWidthFormat
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary]];
    
    [self.view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[masterContainerView]-0-[detailContainerView]|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary]];
    
    [self.view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[masterContainerView]|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary]];
    
    [self.view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[detailContainerView]|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary]];
    
    [self setupController:self.masterViewController forContainerView:masterContainerView];
    [self setupController:self.detailViewController forContainerView:detailContainerView];
    
}


-(void)setupController:(UIViewController *)controller forContainerView:(UIView *)containerView{
    
    [self addChildViewController:controller];
    controller.view.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:controller.view];
    
    NSDictionary *viewsDictionary = @{@"view":controller.view};
    
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewsDictionary]];
    
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewsDictionary]];
    
    [containerView addSubview:controller.view];
    [controller didMoveToParentViewController:self];
    
}

#pragma mark - MGTSplitViewControllerDelegate

-(void)goBack{
    if (![[[self.navigationController viewControllers] firstObject] isEqual:self]) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(NSArray *)viewControllersForSplitView:(MGTSplitViewController *)splitView{
    
    return @[splitView.masterViewController, splitView.detailViewController];
}

-(NSArray *)viewControllers{
    
    return @[self.masterViewController, self.detailViewController];
}


@end
