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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.serviceManager)
    {
        self.serviceManager.delegate = self;
    }
    
   
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.serviceManager)
    {
        self.serviceManager.delegate = nil;
    }
}
#pragma mark-
#pragma mark---XLAFServiceMangerDelegate

//请求数据出错
- (void)dataSourceDidError:(NSDictionary *)info withMethod:(NSString *)method
{
    NSInteger returnCode_ = [[info objectForKey:server_return_Code] integerValue];
    if (returnCode_ == -100)
    {
        //请求服务失败
        NSString *errorMessage_ = [info objectForKey:server_return_Message];
        [GlobalUtils fail_HUD:errorMessage_];
        
    }
    else if (returnCode_ == -200)
    {
        //返回的数据结构不是NSDictionary类型
        NSString *errorMessage_ = [info objectForKey:server_return_Message];
        [GlobalUtils fail_HUD:errorMessage_];
        
    }
    
}



@end
