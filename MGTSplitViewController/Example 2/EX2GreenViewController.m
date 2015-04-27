//
//  EX3GreenViewController.m
//  MGTSplitViewController
//
//  Created by Sam Francis on 4/13/15.
//  Copyright (c) 2015 Mindgrub. All rights reserved.
//

#import "EX2GreenViewController.h"

@interface EX2GreenViewController ()

@end

@implementation EX2GreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    navBar.backgroundColor = [UIColor whiteColor];
    
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer setWidth:-10];
    
    UIBarButtonItem *backButton = [self.splitViewDelegate backButtonWithTitle:@"GET BACK" tintColor:[UIColor redColor]];
    
    navItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,backButton,nil];
    
    navBar.items = @[navItem];
    
    [self.view addSubview:navBar];    
}


@end
