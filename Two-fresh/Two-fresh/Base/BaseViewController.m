//
//  BaseViewController.m
//  Two-fresh
//
//  Created by jiang on 2017/3/20.
//  Copyright © 2017年 蒋玉顺. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

- (void)initCustomNabBarView
{
    [self.navigationController setNavigationBarHidden:YES];
    
    CustomNavigationBarView *barView = [[CustomNavigationBarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    barView.backgroundColor = CustomNavBarBackgroundColor;
    [self.view addSubview:barView];
    self.barView = barView;
    
    
    
}

- (void)initSettingData
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化导航栏
    [self initCustomNabBarView];
    
    [self initSettingData];
    
}

@end
