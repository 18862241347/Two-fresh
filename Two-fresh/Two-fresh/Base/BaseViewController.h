//
//  BaseViewController.h
//  Two-fresh
//
//  Created by jiang on 2017/3/20.
//  Copyright © 2017年 蒋玉顺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNavigationBarView.h"
#import "XLAFServiceManger.h"


@interface BaseViewController : UIViewController<XLAFServiceMangerDelegate>


@property (nonatomic, weak) CustomNavigationBarView *barView;
//网络请求对象
@property(nonatomic, retain) XLAFServiceManger *serviceManager;
@end
