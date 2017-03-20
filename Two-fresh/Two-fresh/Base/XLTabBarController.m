
//
//  XLTabBarController.m
//  Two-fresh
//
//  Created by jiang on 2017/3/20.
//  Copyright © 2017年 蒋玉顺. All rights reserved.
//

#import "XLTabBarController.h"

#import "HomeViewController.h"
#import "ClassifyViewController.h"
#import "FindViewController.h"
#import "SthViewController.h"
#import "MyViewController.h"

#import "XLNavigationController.h"

@implementation XLTabBarController
- (void)viewDidLoad {
    
    [super viewDidLoad];

    
    [self setUpAllChildViewController];
    
    
}
// 添加所有子控制器
- (void)setUpAllChildViewController
{
    // 首页
    HomeViewController *home = [[HomeViewController  alloc] init];
    [self setUpOneChildViewController:home title:@"首页" imageName:@"home" selImageName:@"homeSelect"];
    
    // 分类
    ClassifyViewController *classify = [[ClassifyViewController alloc] init];
    [self setUpOneChildViewController:classify title:@"分类" imageName:@"sortIconNormal" selImageName:@"sortIconSelect"];
    
    // 发现
    FindViewController *discover = [[FindViewController alloc] init];
    [self setUpOneChildViewController:discover title:@"发现" imageName:@"discover" selImageName:@"discoverSelect"];
    
    // 两鲜团
    SthViewController *sth = [[SthViewController alloc] init];
    [self setUpOneChildViewController:sth title:@"两鲜团" imageName:@"groupon" selImageName:@"grouponSelect"];
    
    
    // 我的两鲜
    MyViewController *my = [[MyViewController alloc] init];
    [self setUpOneChildViewController:my title:@"我的两鲜" imageName:@"myFresh" selImageName:@"myFreshSelect"];
    
}

// 添加一个控制器的属性
- (void)setUpOneChildViewController:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName selImageName:(NSString *)selImageName
{
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *selImage = [UIImage imageNamed:selImageName];
    if (DEVICE_SYSTEM_VERSION>=7) {
        selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    vc.tabBarItem.selectedImage = selImage;
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UICOLOR_HEX(0x383736), NSForegroundColorAttributeName, [UIFont systemFontOfSize:12], NSFontAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UICOLOR_HEX(0x383736), NSForegroundColorAttributeName, [UIFont systemFontOfSize:12], NSFontAttributeName, nil] forState:UIControlStateSelected];
    
    XLNavigationController *nav = [[XLNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
    
}


@end
