
//
//  JSessionInfo.h
//  Two-fresh
//
//  Created by jiang on 2017/3/20.
//  Copyright © 2017年 蒋玉顺. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface JSessionInfo : NSObject
{
    
}
//用户登录返回信息
@property(nonatomic, retain) NSMutableDictionary *userDictionary;

/// 会员登陆的凭证
@property(nonatomic, copy) NSString *token;

///  活动倒计时秒数
@property(nonatomic, assign) int  timeout;


+ (JSessionInfo *)sharedInstance;

@end
