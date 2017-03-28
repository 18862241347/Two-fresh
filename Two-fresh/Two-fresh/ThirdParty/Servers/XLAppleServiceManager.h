//
//  XLAppleServiceManager.h
//  Michelin
//
//  Created by 谢传波 on 15/10/15.
//  Copyright © 2015年 Michelin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XLAppleServiceManagerDelegate <NSObject>

@optional

//请求数据成功
- (void)dataSourceDidLoad:(NSDictionary *)info withMethod:(NSString *)method;
//请求数据失败
- (void)dataSourceDidFailed:(NSDictionary *)info withMethod:(NSString *)method;
//请求数据出错
- (void)dataSourceDidError:(NSDictionary *)info withMethod:(NSString *)method;

@end

@interface XLAppleServiceManager : NSObject

@property(nonatomic, assign) id<XLAppleServiceManagerDelegate>delegate;


//get method
- (void)getDataWithMethod:(NSString *)method_ withDictionary:(NSMutableDictionary*)dictionary;

//post method
- (void)postDataWithMethod:(NSString *)method_ withDictionary:(NSMutableDictionary*)dictionary;

@end
