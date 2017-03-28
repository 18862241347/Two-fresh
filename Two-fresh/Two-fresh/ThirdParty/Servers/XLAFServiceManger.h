//
//  XLAFServiceManger.h
//  SesProject
//
//  Created by 谢传波 on 15/4/30.
//  Copyright (c) 2015年 ___coco-sh___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLAFBaseService.h"

@protocol XLAFServiceMangerDelegate <NSObject>

@optional

//请求数据成功
- (void)dataSourceDidLoad:(NSDictionary *)info withMethod:(NSString *)method;
//请求数据失败
- (void)dataSourceDidFailed:(NSDictionary *)info withMethod:(NSString *)method;
//请求数据出错
- (void)dataSourceDidError:(NSDictionary *)info withMethod:(NSString *)method;

@end

@interface XLAFServiceManger : NSObject

@property(nonatomic, assign) id<XLAFServiceMangerDelegate>delegate;


//get method
- (void)getDataWithMethod:(NSString *)method_ withDictionary:(NSMutableDictionary*)dictionary;

//post method
- (void)postDataWithMethod:(NSString *)method_ withDictionary:(NSMutableDictionary*)dictionary;

@end
