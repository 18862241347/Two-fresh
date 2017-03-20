//
//  GlobalUtils.m
//  Two-fresh
//
//  Created by jiang on 2017/3/20.
//  Copyright © 2017年 蒋玉顺. All rights reserved.
//

//登录用户的登录信息本地保存文件名
#define USER_LOGIN_INFO @"userLoginInfo"

#import "GlobalUtils.h"
#import "PathUtilities.h"

@implementation GlobalUtils

+(void)showAlertView_HUD:(NSString *)text_
{
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    
    [SVProgressHUD showInfoWithStatus:text_ maskType:SVProgressHUDMaskTypeClear];
}

//断网提示
+(void)showHUDWithoutNetwork:(NSString *)text_
{
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    
    [SVProgressHUD showImage:[UIImage imageNamed:@"noNetWork"] status:text_ maskType:SVProgressHUDMaskTypeClear];

}

+(void)show_HUD:(NSString*)text
{
    
    [SVProgressHUD setForegroundColor:[UIColor redColor]];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    
    [SVProgressHUD showWithStatus:text maskType:SVProgressHUDMaskTypeClear];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

+(void)show_HUDWithNetworkActivityIndicator
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

+(void)success_HUD:(NSString*)text
{    
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD showSuccessWithStatus:text];
        
    });
    
}

+(void)success_HUD:(NSString*)text CompleteWith:(void (^)(void))completeBlock
{
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD showSuccessWithStatus:text];
        
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            completeBlock();
            
        });
        
    });
    
}

//请求数据成功直接隐藏
+ (void)dismiss_HUD
{
    
    double delayInSeconds = 0.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
        
    });
}

//请求失败
+ (void) fail_HUD:(NSString *)text_
{
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self showHUDWithoutNetwork:text_];

//        [SVProgressHUD showErrorWithStatus:text_];
        
    });
}

+(void)fail_HUD:(NSString*)text CompleteWith:(void (^)(void))completeBlock
{
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    
    double delayInSeconds = 0.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD showErrorWithStatus:text];
        
        double delayInSeconds = 1.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            completeBlock();
            
        });
        
    });
    
}

//延迟
+(void)delayTime:(double)time_ CompleteWith:(void (^)(void))completeBlock
{
    double delayInSeconds = time_;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        completeBlock();
        
    });
}

//Json解析成Dictionary
+ (id)parserWithJSONString:(NSString *)jsonString_
{
    
    jsonString_ = [FunctionUtilities ReplacingNewLineAndWhitespaceCharactersFromJson:jsonString_];
    
    NSData *jsonData_ = [jsonString_ dataUsingEncoding:NSUTF8StringEncoding];
    id jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData_ options:NSJSONReadingMutableContainers error:nil];
    
    if (jsonDic)
    {
        return jsonDic;
    }
    
    return nil;
    
}

//获取已登录用户信息， 判断是否需要登录
+(NSDictionary *)userInfoFrowLocal
{
    NSMutableDictionary *infoDic_ = [PathUtilities readDictionaryPlistForKey:NSDocumentDirectory withFile:USER_LOGIN_INFO];
    
    NSDictionary *userInfoDic_ = [NSDictionary dictionaryWithDictionary:infoDic_];
    
    return userInfoDic_;
}

//登录用户信息本地保存，下次使用该软件不用再次登录
+(void)saveUserInfoToLocal:(NSDictionary *)userInfoDic_ 
{
    [PathUtilities updatePlist:NSDocumentDirectory withFile:USER_LOGIN_INFO withDictionary:userInfoDic_];
    
}

@end
