
//
//  GlobalUtils.h
//  Two-fresh
//
//  Created by jiang on 2017/3/20.
//  Copyright © 2017年 蒋玉顺. All rights reserved.
//

//针对不同的项目有不同的公共操作在此类实现

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"

@interface GlobalUtils : NSObject

//提示语
+(void)showAlertView_HUD:(NSString *)text_;
//断网提示
+(void)showHUDWithoutNetwork:(NSString *)text_;
//请求加载提示
+(void)show_HUD:(NSString*)text;
//请求
+(void)show_HUDWithNetworkActivityIndicator;
//请求完成
+(void)success_HUD:(NSString*)text;
//请求完成
+(void)success_HUD:(NSString*)text CompleteWith:(void (^)(void))completeBlock;
//请求数据成功直接隐藏
+ (void)dismiss_HUD;
//请求失败
+ (void)fail_HUD:(NSString *)text_;
//请求失败
+(void)fail_HUD:(NSString*)text CompleteWith:(void (^)(void))completeBlock;
//延迟
+(void)delayTime:(double)time_ CompleteWith:(void (^)(void))completeBlock;

//获取已登录用户信息， 判断是否需要登录
+(NSDictionary *)userInfoFrowLocal;
//登录用户信息本地保存，下次使用该软件不用再次登录
+(void)saveUserInfoToLocal:(NSDictionary *)userInfoDic_;


@end


