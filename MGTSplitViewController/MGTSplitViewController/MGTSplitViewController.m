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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    if (!self.masterViewWidth) {
        self.masterViewWidth = DEFAULT_MASTER_WIDTH;
    }
    
    if (!self.masterViewController) {
        self.masterViewController = [[UIViewController alloc] init];
    }
    
    if (!self.detailViewController) {
        self.detailViewController = [[UIViewController alloc] init];
    }
    
    [self setupContainers];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setMasterViewController:(UIViewController *)masterViewController{
    _masterViewController = masterViewController;
    
    if (![[[self.navigationController viewControllers] firstObject] isEqual:self]) {
        // instantiate a back button
        UIBarButtonItem *backButton = [self backButton];
        
        
        if ([[[masterViewController.navigationController viewControllers] firstObject] isEqual:masterViewController]) {
            [self.navigationItem setBackBarButtonItem:backButton];
        }
    }
}

-(void)setupContainers{
    
    UIView *masterContainerView = [[UIView alloc] initWithFrame:CGRectZero];
    masterContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    // Setting bg color just for visual
    masterContainerView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:masterContainerView];
    
    UIView *detailContainerView = [[UIView alloc] initWithFrame:CGRectZero];
    detailContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    // Setting bg color just for visual
    detailContainerView.backgroundColor = [UIColor darkGrayColor];
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
    
    //1. Add the detail controller as child of the container
    [self addChildViewController:controller];
    
    //2. Define the controller's view size
    controller.view = [[UIView alloc] initWithFrame:CGRectZero];
    controller.view.translatesAutoresizingMaskIntoConstraints = NO;
    if ([controller isEqual:self.masterViewController]) {
        controller.view.backgroundColor = [UIColor greenColor];
    }else{
        controller.view.backgroundColor = [UIColor blueColor];
    }
    
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
    
    //3. Add the controller's view to the Container's view // and save a reference to the View Controller
    [containerView addSubview:controller.view];
    
    //4. Complete the add flow calling the function didMoveToParentViewController
    [controller didMoveToParentViewController:self];
    
}


- (UIBarButtonItem *)backButton{
    return [self.navigationItem backBarButtonItem];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if (![segue.destinationViewController isKindOfClass:[MGTSplitViewController class]]) {
        [[self navigationController] setNavigationBarHidden:NO animated:YES];
    }
    
}


@end
