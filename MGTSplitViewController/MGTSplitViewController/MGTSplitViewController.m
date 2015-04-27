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

-(id)initWithMasterVC:(UIViewController *)masterViewController detailVC:(UIViewController *)detailViewController{
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
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setSplitViewBackButtonForViewController:self.masterViewController];
    
    if (self.masterViewController) {
        if (self.detailViewController) {
            [self setupContainers];
        }
        else {
            NSLog(@"ERROR, no detail view contorller.");
        }
    }
    else{
        if (!self.detailViewController) {
            NSLog(@"ERROR, no master or detail view contorller.");
        }
        NSLog(@"ERROR, no master view contorller.");
    }
    
}

-(void)setSplitViewDelegateForViewController:(UIViewController *)viewController{
    // If navigation controller, set the delegate of its root vc.
    // It's up to the developer to pass the delegate on when a new vc is pushed onto the navigation stack.
    if ([viewController isKindOfClass:[UINavigationController class]]){
        [self setSplitViewDelegateForViewController:((UINavigationController *)viewController).viewControllers[0]];
    }
    
    // If tab bar controller, set the delegates of each of its vc's
    else if ([viewController isKindOfClass:[UITabBarController class]]){
        for (UIViewController *vc in ((UITabBarController *)viewController).viewControllers) {
            if ([vc conformsToProtocol:@protocol(MGTSplitViewControllerPropertyDelegate)]) {
                [self setSplitViewDelegateForViewController:vc];
            }
        }
    }
    
    else if ([viewController conformsToProtocol:@protocol(MGTSplitViewControllerPropertyDelegate)]) {
        ((id<MGTSplitViewControllerPropertyDelegate>)viewController).splitViewDelegate = self;
    }
}

- (void)setMasterViewController:(UIViewController *)masterViewController{
    [self setSplitViewDelegateForViewController:masterViewController];
    _masterViewController = masterViewController;
}

- (void)setDetailViewController:(UIViewController *)detailViewController{
    [self setSplitViewDelegateForViewController:detailViewController];
    _detailViewController = detailViewController;
}


#pragma mark - Container View Setup

-(void)setupContainers{
    
    UIView *masterContainerView = [[UIView alloc] initWithFrame:CGRectZero];
    masterContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:masterContainerView];
    
    UIView *detailContainerView = [[UIView alloc] initWithFrame:CGRectZero];
    detailContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:detailContainerView];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(masterContainerView, detailContainerView);
    
    // SET CONTAINER AUTO LAYOUT CONSTRAINTS
    NSString *masterWidthFormat = [[@"H:[masterContainerView(" stringByAppendingString:[@(DEFAULT_MASTER_WIDTH) stringValue]] stringByAppendingString:@")]"];
    
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

-(NSArray *)viewControllers{
    
    return @[self.masterViewController, self.detailViewController];
}


#pragma mark Back Button

-(void)setSplitViewBackButtonForViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        [self setSplitViewBackButtonForViewController:[((UINavigationController *)viewController).viewControllers firstObject]];
    }
    
    // If tab bar controller, set the buttons of each of its vc's
    else if ([viewController isKindOfClass:[UITabBarController class]]){
        for (UIViewController *vc in ((UITabBarController *)viewController).viewControllers) {
            [self setSplitViewBackButtonForViewController:vc];
        }
    }
    
    else{
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        [negativeSpacer setWidth:-10];
        
        viewController.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,[self backButtonDefault],nil];
    }
}

- (UIBarButtonItem *)backButtonDefault{
    return [self backButtonWithTitle:@"Back" tintColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
}

- (UIBarButtonItem *)backButtonWithTitle:(NSString *)title{
    
    return [self backButtonWithTitle:title tintColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
    
}

- (UIBarButtonItem *)backButtonWithTintColor:(UIColor *)tintColor{
    return [self backButtonWithTitle:@"Back" tintColor:tintColor];
}


- (UIBarButtonItem *)backButtonWithTitle:(NSString *)title tintColor:(UIColor *)tintColor{
    UILabel *label = [[UILabel alloc]init];
    label.text = title;
    
    CGFloat buttonFrameWidth = 35.0f + [label.text boundingRectWithSize:label.frame.size
                                                                options:NSStringDrawingUsesLineFragmentOrigin
                                                             attributes:@{ NSFontAttributeName:label.font }
                                                                context:nil].size.width;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, buttonFrameWidth, 20.5f);
    
    UIImage *backImage = [UIImage imageNamed:@"back"];
    CGFloat backImageWidth = backImage.size.width;
    CGFloat backImageHeight = backImage.size.height;
    
    // Tint Image
    if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(backImage.size, NO, 0.0f);
    }
    else {
        UIGraphicsBeginImageContext([backImage size]);
    }
    
    CGRect rect = CGRectZero;
    rect.size = backImage.size;
    [tintColor set];
    UIRectFill(rect);
    [backImage drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0];
    backImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Resize Image
    backImage = [backImage resizableImageWithCapInsets:UIEdgeInsetsMake(backImageWidth, backImageHeight, backImageWidth, backImageHeight)];
    
    [button setBackgroundImage:backImage forState:UIControlStateNormal];
    
    
    // Set Highlighted Image Tint
    UIImage *highlightedBackImage = backImage;
    
    UIGraphicsBeginImageContextWithOptions(highlightedBackImage.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    rect = CGRectMake(0, 0, backImageWidth, backImageHeight);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -backImageHeight);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, 0.3);
    CGContextDrawImage(ctx, rect, highlightedBackImage.CGImage);
    highlightedBackImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    highlightedBackImage = [highlightedBackImage resizableImageWithCapInsets:UIEdgeInsetsMake(backImageWidth, backImageHeight, backImageWidth, backImageHeight)];
    
    const CGFloat* components = CGColorGetComponents(tintColor.CGColor);
    [button setTitleColor:[UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:0.3f] forState:UIControlStateHighlighted];
    [button setBackgroundImage:highlightedBackImage forState:UIControlStateHighlighted];
    
    // Set Title
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 21, 0, 0)];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:tintColor forState:UIControlStateNormal];
    
    // Add target and action
    [button addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    
}



@end
