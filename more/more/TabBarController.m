//
//  TabBarController.m
//  more
//
//  Created by Yulin Zhao on 2018/12/11.
//  Copyright © 2018 Yulin Zhao. All rights reserved.
//

#import "TabBarController.h"
#import "PenetrationSegmentController.h"

#import "SecoundViewController.h"
#import "ThirdViewController.h"
#import "FourTableViewController.h"
@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PenetrationSegmentController * first = [[PenetrationSegmentController alloc]init];
   
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:first];
    [self addChildViewController:nav];
    nav.tabBarItem.title = @"first";
    SecoundViewController * s = [[SecoundViewController alloc]init];
    ThirdViewController * t = [[ThirdViewController alloc]initWithStyle:UITableViewStylePlain];
    FourTableViewController * f = [[FourTableViewController alloc]initWithStyle:UITableViewStylePlain];
    first.titles = @[@"锄禾",@"日",@"当午"];
    first.vcArray = @[s,t,f];
    first.titleColor = [UIColor blueColor];
    first.tinColor = [UIColor purpleColor];
    first.titleViewBackgroudColor = [UIColor whiteColor];
}


@end
